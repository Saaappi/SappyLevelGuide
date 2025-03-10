local addonName, HelpMePlay = ...
local eventFrame = CreateFrame("Frame")
local LHMP = LibStub("LibHelpMePlay")

local button

local mounts = {}

local minGroundMountLevel = 10
local minFlyingMountLevel = 20
local minSkyridingMountLevel = 30

function HelpMePlay.GetPlayerDurability(threshold)
    local slots = { 1, 3, 5, 6, 7, 8, 9, 10, 16, 17 }
    local totalCurrentDurability = 0
    local totalMaxDurability = 0
    for _, slotID in ipairs(slots) do
        local itemLocation = ItemLocation:CreateFromEquipmentSlot(slotID)
        if itemLocation:IsValid() then
            local currentDurability, maxDurability = GetInventoryItemDurability(slotID)
            if currentDurability and maxDurability then
                totalCurrentDurability = totalCurrentDurability + currentDurability
                totalMaxDurability = totalMaxDurability + maxDurability
            end
        end
    end
    if totalCurrentDurability > 0 and totalMaxDurability > 0 then
        local durability = (totalCurrentDurability / totalMaxDurability) * 100
        if durability <= threshold then
            return true
        end
    end
    return false
end

function HelpMePlay.GetFreeInventorySpacePercentage(numFreeSlots, numTotalSlots, threshold)
    local spaceUsed = (numFreeSlots / numTotalSlots) * 100
    if (100 - spaceUsed) >= (100 - threshold) then
        return true
    end
    return false
end

-- Gets a random mount based on the given type.
function HelpMePlay.GetRandomMountByType(type)
    -- If we ran out of mounts for a given type, then
    -- refresh the mounts for that type.
    if mounts[type] == nil or (#mounts[type] == 0) then
        HelpMePlay.RefreshMountsByType(type)
    end

    -- Get a random index from the mounts table, then get the
    -- mountID at that index.
    if mounts[type] then
        local index = math.random(1, #mounts[type])
        local mount = mounts[type][index]

        -- Remove the mount from the original table.
        table.remove(mounts[type], index)

        -- Return the mount ID
        return mount.mountID
    end
end

function HelpMePlay.IsMountCollected(mountID)
    local isCollected = select(11, C_MountJournal.GetMountInfoByID(mountID))
    if isCollected then
        return true
    end
    return false
end

function HelpMePlay.IsMountUsable(mountID)
    local isUsable = C_MountJournal.GetMountUsabilityByID(mountID, false)
    if isUsable then
        return true
    end
    return false
end

function HelpMePlay.GetMountTypeNameByID(mountTypeID)
    if HelpMePlay.MountTypes[mountTypeID] then
        return HelpMePlay.MountTypes[mountTypeID]
    end
    return "UNK"
end

function HelpMePlay.SummonMountByType(type)
    local mountID = HelpMePlay.GetRandomMountByType(type)
    if mountID then
        C_Timer.After(0.1, function()
            local isUsable = HelpMePlay.IsMountUsable(mountID)
            if isUsable then
                C_MountJournal.SummonByID(mountID)
            else
                HelpMePlay.SummonMountByType(type)
            end
        end)
    end
end

function HelpMePlay.CategorizeMountByID(mountID)
    local name, _, _, _, _, _, _, _, factionID, shouldHideOnChar, isCollected = C_MountJournal.GetMountInfoByID(mountID)
    if isCollected then
        local mountTypeID = select(5, C_MountJournal.GetMountInfoExtraByID(mountID))
        if mountTypeID then
            local mountTypeName = HelpMePlay.GetMountTypeNameByID(mountTypeID)
            if mountTypeName ~= "UNK" then
                -- We need to verify the mount is usable by the player period.
                if factionID ~= nil and factionID ~= HelpMePlay.playerFactionID then return false end
                if shouldHideOnChar then return false end

                table.insert(HelpMePlayDB["Mounts"][mountTypeName], {name = name, mountID = mountID})
            else
                HelpMePlay.Print(string.format(HelpMePlay.ErrorMessages["MOUNT_TYPE_UNKNOWN"], mountTypeID))
            end
        end
    end
    return false
end

function HelpMePlay.RefreshMountsByType(type)
    if mounts[type] == nil then
        mounts[type] = {}
    end

    for _, mount in pairs(HelpMePlayDB["Mounts"][type]) do
        table.insert(mounts[type], mount)
    end
end

function HelpMePlay.Mount()
    -- If the player is already mounted, then dismount them and return.
    -- This will save me from creating a keybind for dismount.
    if IsMounted() and (not IsFlying()) then
        Dismount()
        return
    elseif IsMounted() and IsFlying() then
        return
    end

    -- Check if the player is in combat.
    if InCombatLockdown() then return false end

    -- Determine which Flight Mode the player has enabled.
    local activeFlightStyleSpellID = 0
    local flightStyleSpells = {404464, 404468}
    for _, spellID in next, flightStyleSpells do
        local aura = C_UnitAuras.GetPlayerAuraBySpellID(spellID)
        if aura and aura.name then
            activeFlightStyleSpellID = spellID
            break
        end
    end

    -- Get some information about the player's inventory. We'll use these
    -- values to determine if we need to summon a vendor mount or not.
    local numTotalSlots = 0
    local numFreeSlots = 0
    for bagID = 0, 4 do
        numTotalSlots = numTotalSlots + C_Container.GetContainerNumSlots(bagID)
        numFreeSlots = numFreeSlots + C_Container.GetContainerNumFreeSlots(bagID)
    end

    if (HelpMePlay.playerLevel < minGroundMountLevel) and (IsOutdoors() and (not LHMP:IsPlayerHeroClass(HelpMePlay.playerClassID))) then -- Chauffer Mount
        if HelpMePlay.playerFactionID == 1 then
            local mountID = 679
            if HelpMePlay.IsMountCollected(mountID) then
                C_MountJournal.SummonByID(mountID)
            end
        elseif HelpMePlay.playerFactionID == 0 then
            local mountID = 678
            if HelpMePlay.IsMountCollected(mountID) then
                C_MountJournal.SummonByID(mountID)
            end
        end
    elseif (HelpMePlay.playerLevel < minFlyingMountLevel) and (IsOutdoors() and IsShiftKeyDown()) then
        -- This is SKYRIDING before flight styles are available.
        HelpMePlay.SummonMountByType("Dynamic")
    elseif (GetMirrorTimerInfo(2)) == "BREATH" and IsOutdoors() then -- Aquatic Mounts
        -- If the player is submerged/swimming and they're outdoors,
        -- then summon an aquatic mount.
        --
        -- If the player is in a special map (like Vashj'ir), then use
        -- the appropriate mount. If they don't have it, then use an
        -- aquatic mount.
        if HelpMePlay.SpecialMaps[HelpMePlay.mapID] then
            local mountID = HelpMePlay.SpecialMaps[HelpMePlay.mapID][1]
            if HelpMePlay.IsMountCollected(mountID) then
                C_MountJournal.SummonByID(mountID)
            else
                HelpMePlay.SummonMountByType("Aquatic")
            end
        else
            HelpMePlay.SummonMountByType("Aquatic")
        end
    elseif HelpMePlay.SpecialMaps[HelpMePlay.mapID] and IsOutdoors() then -- Ahn'Qiraj Mounts
        -- If the player is in a special map, such as Ahn'Qiraj,
        -- then use a random mount from the list.
        local randomNum = random(1, #HelpMePlay.SpecialMaps[HelpMePlay.mapID])
        local mountID = HelpMePlay.SpecialMaps[HelpMePlay.mapID][randomNum]
        if HelpMePlay.IsMountCollected(mountID) then
            C_MountJournal.SummonByID(mountID)
        end
    elseif HelpMePlay.GetFreeInventorySpacePercentage(numFreeSlots, numTotalSlots, 20) or HelpMePlay.GetPlayerDurability(70) then -- Inventory Mounts (to repair/vendor)
        -- First, try to summon a random vendor mount. If that mount isn't available,
        -- then fallback to using one of the cheap Tundra Mammoths.
        local numMounts = LHMP:GetTableSize(HelpMePlay.VendorMounts)
        local rand = math.random(1, numMounts)
        local mountId = HelpMePlay.VendorMounts[rand]

        if HelpMePlay.IsMountCollected(mountId) then
            C_MountJournal.SummonByID(mountId)
        else
            if HelpMePlay.playerFactionID == 1 then
                mountId = 280
            else
                mountId = 284
            end

            if HelpMePlay.IsMountCollected(mountId) then
                C_MountJournal.SummonByID(mountId)
            else
                -- The player doesn't have any vendor mount, so just pick a random mount.
                if HelpMePlay.playerLevel >= minGroundMountLevel and HelpMePlay.playerLevel < minFlyingMountLevel then
                    HelpMePlay.SummonMountByType("Ground")
                elseif HelpMePlay.playerLevel >= minFlyingMountLevel and HelpMePlay.playerLevel < minSkyridingMountLevel then
                    HelpMePlay.SummonMountByType("Flying")
                else
                    HelpMePlay.SummonMountByType("Dynamic")
                end
            end
        end
    elseif IsAdvancedFlyableArea() and IsOutdoors() and (HelpMePlay.playerLevel > minSkyridingMountLevel) and (not IsShiftKeyDown()) then -- Skyriding Mounts
        HelpMePlay.SummonMountByType("Dynamic")
    elseif IsFlyableArea() and IsOutdoors() and (HelpMePlay.playerLevel >= minFlyingMountLevel) and IsShiftKeyDown() then -- Static Flying Mounts
        HelpMePlay.SummonMountByType("Flying")
    else -- Ground Mounts
        HelpMePlay.SummonMountByType("Ground")
    end
end

local function OnEvent(_, event, arg1)
    if event == "NEW_MOUNT_ADDED" then
        HelpMePlay.CategorizeMountByID(arg1)
    end
end

eventFrame:RegisterEvent("NEW_MOUNT_ADDED")
eventFrame:SetScript("OnEvent", OnEvent)

function HelpMePlay.ResetAllMounts()
    -- Wipe out the mount tables.
    for key in pairs(HelpMePlayDB["Mounts"]) do
        HelpMePlayDB["Mounts"][key] = {}
    end

    -- Categorize the mounts.
    for _, mountID in ipairs(C_MountJournal.GetMountIDs()) do
        HelpMePlay.CategorizeMountByID(mountID)
    end

    -- Refresh the mounts.
    for mountType in ipairs(HelpMePlayDB["Mounts"]) do
        HelpMePlay.RefreshMountsByType(mountType)
    end
end

EventRegistry:RegisterCallback("MountJournal.OnShow", function()
    if not button then
        button = HelpMePlay.CreateWidget("IconButton", {
            name = string.format("%sCategorizeMountsButton", addonName),
            width = 32,
            height = 32,
            parent = MountJournalSummonRandomFavoriteButton,
            texture = 2143075,
            useFontString = true,
            fontStringText = "Categorize Mounts"
        })

        button:ClearAllPoints()
        button:SetPoint("TOPRIGHT", MountJournalSummonRandomFavoriteButton, "TOPRIGHT", -310, 0)

        button:SetScript("OnClick", function()
            if not InCombatLockdown() then
                HelpMePlay.ResetAllMounts()
            end
        end)
        button:SetScript("OnEnter", function(self)
            HelpMePlay.Tooltip_OnEnter(self, "Categorize Mounts", string.format("Categorize all of your known mounts. Mounts will be summoned based on your current location, player level, and other character attributes.\n\n" ..
            "Current Keybind: %s", GetBindingKey("HELPMEPLAY_MOUNTUP") or "Not Set"))
        end)
        button:SetScript("OnLeave", HelpMePlay.Tooltip_OnLeave)
    end
end)