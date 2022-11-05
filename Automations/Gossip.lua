local addonName, addonTable = ...
local e = CreateFrame("Frame")
local currentMapId = 0
local gossipEnabledMaps = {
	[17] 	= true, -- Blasted Lands
	[1246] 	= true, -- Blasted Lands
	[1419] 	= true, -- Blasted Lands
	[84] 	= true, -- Stormwind City
	[87] 	= true, -- Ironforge
	[641] 	= true, -- Val'sharah
	[642] 	= true, -- Darkpens, Val'sharah
	[650] 	= true, -- Highmountain
	[652] 	= true, -- Thunder Totem, Highmountain
	[654] 	= true, -- Mucksnout Den, Highmountain
	[657] 	= true, -- Path of Huln (Floor 1), Highmountain
	[658] 	= true, -- Path of Huln (Floor 2), Highmountain
	[659] 	= true, -- Stonedark Grotto, Highmountain
	[750] 	= true, -- Thunder Totem, Highmountain
	[1189] 	= true, -- Highmountain
	[862] 	= true, -- Zuldazar
	[1181] 	= true, -- Zuldazar
	[1193] 	= true, -- Zuldazar
	[863] 	= true, -- Nazmir
	[1194] 	= true, -- Nazmir
	[864] 	= true, -- Vol'dun
	[1195] 	= true, -- Vol'dun
	[1409] 	= true, -- Exile's Reach
	[1610] 	= true, -- Terrace of Reanimation, Darkmaul Citadel
	[1565] 	= true, -- Ardenweald
	[1603] 	= true, -- Ardenweald
	[1643] 	= true, -- Ardenweald
	[1709] 	= true, -- Ardenweald
	[1739] 	= true, -- Ardenweald
	[1740] 	= true, -- Ardenweald
	[2005] 	= true, -- Ardenweald
	[1525] 	= true, -- Revendreth
	[1734] 	= true, -- Revendreth
	[1738] 	= true, -- Revendreth
	[1742] 	= true, -- Revendreth
}

local function GetParentMapID(mapId)
	currentMapId = C_Map.GetBestMapForUnit("player")
	if mapId then
		local mapInfo = C_Map.GetMapInfo(mapId)
		if mapInfo.mapType ~= 2 and mapInfo.parentMapID ~= 0 then
			GetParentMapID(mapInfo.parentMapID)
		else
			parentMapId = mapInfo.mapID
		end
	end
	return parentMapId
end

local function GetGossipTable(parentMapId)
	local gossipTable
	if parentMapId == 12 or parentMapId == 13 or parentMapId == 948 then
		gossipTable = addonTable.DIALOG_CLASSIC
	elseif parentMapId == 572 then
		gossipTable = addonTable.DIALOG_WOD
	elseif parentMapId == 619 or parentMapId == 905 then
		gossipTable = addonTable.DIALOG_LEGION
	elseif parentMapId == 875 or parentMapId == 876 then
		gossipTable = addonTable.DIALOG_BFA
	elseif parentMapId == 1409 or parentMapId == 1550 or parentMapId == 1610 then
		gossipTable = addonTable.DIALOG_SL
	end
	return gossipTable
end

local function SelectGossipOption(options, npcId, parentMapId)
	for index, gossipSubTable in ipairs(options) do
		if HelpMePlayPlayerDialogDB[npcId] then
			if HelpMePlayPlayerDialogDB[npcId]["g"] then
				for _, index in ipairs(HelpMePlayPlayerDialogDB[npcId]["g"]) do
					C_GossipInfo.SelectOption(index)
				end
			end
		end
	end
	
	local gossipTable = GetGossipTable(parentMapId)
	if gossipTable[npcId] then
		for index, gossipSubTable in ipairs(options) do
			for _, gossip in pairs(gossipTable[npcId]["g"]) do
				local numConditions = #gossip.c
				local numConditionsMatched = 0
				for _, condition in ipairs(gossip.c) do
					if condition == "none" then
						C_GossipInfo.SelectOption(gossip.o)
					elseif condition == "level.higher" then
						if UnitLevel("player") > gossip.l then
							numConditionsMatched = numConditionsMatched + 1
						end
					elseif condition == "level.equal" then
						if UnitLevel("player") == gossip.l then
							numConditionsMatched = numConditionsMatched + 1
						end
					elseif condition == "level.lower" then
						if UnitLevel("player") < gossip.l then
							numConditionsMatched = numConditionsMatched + 1
						end
					elseif condition == "level.between" then
						local minLevel, maxLevel = gossip.l[1], gossip.l[2]
						local playerLevel = UnitLevel("player")
						
						if playerLevel >= minLevel and playerLevel <= maxLevel then
							numConditionsMatched = numConditionsMatched + 1
						end
					elseif condition == "money.higher" then
						if GetMoney("player") > gossip.m then
							numConditionsMatched = numConditionsMatched + 1
						end
					elseif condition == "quests.active" then
						local numQuests = #gossip.q
						for i = 1, numQuests do
							if C_QuestLog.IsOnQuest(gossip.q[i]) then
								numQuests = numQuests - 1
								if numQuests == 0 then
									numConditionsMatched = numConditionsMatched + 1
								end
							end
						end
					elseif condition == "quests.notActive" then
						local numQuests = #gossip.q
						for i = 1, numQuests do
							if C_QuestLog.IsOnQuest(gossip.q[i]) == false then
								numQuests = numQuests - 1
								if numQuests == 0 then
									numConditionsMatched = numConditionsMatched + 1
								end
							end
						end
					elseif condition == "quests.complete" then
						local numQuests = #gossip.q
						for i = 1, numQuests do
							if C_QuestLog.IsQuestFlaggedCompleted(gossip.q[i]) then
								numQuests = numQuests - 1
								if numQuests == 0 then
									numConditionsMatched = numConditionsMatched + 1
								end
							end
						end
					elseif condition == "quests.notComplete" then
						local numQuests = #gossip.q
						for i = 1, numQuests do
							if C_QuestLog.IsQuestFlaggedCompleted(gossip.q[i]) == false then
								numQuests = numQuests - 1
								if numQuests == 0 then
									numConditionsMatched = numConditionsMatched + 1
								end
							end
						end
					elseif condition == "quest.obj.complete" then
						local objectives = C_QuestLog.GetQuestObjectives(gossip.q)
						if objectives[gossip.obj].finished then
							numConditionsMatched = numConditionsMatched + 1
						end
					elseif condition == "quest.obj.notComplete" then
						local objectives = C_QuestLog.GetQuestObjectives(gossip.q)
						if objectives[gossip.obj].finished == false then
							numConditionsMatched = numConditionsMatched + 1
						end
					elseif condition == "player.faction" then
						if (UnitFactionGroup("player")) == gossip.f then
							numConditionsMatched = numConditionsMatched + 1
						end
					elseif condition == "map" then
						if C_Map.GetBestMapForUnit("player") == gossip.m then
							numConditionsMatched = numConditionsMatched + 1
						end
					elseif condition == "chromieTime" then
						if UnitChromieTimeID("player") == gossip.ct then
							numConditionsMatched = numConditionsMatched + 1
						end
					elseif condition == "addon.setting" then
						if HelpMePlayDB[gossip.s] == gossip.r then
							numConditionsMatched = numConditionsMatched + 1
						end
					end
				end
				if numConditionsMatched == numConditions then
					C_GossipInfo.SelectOption(gossip.o)
					return
				end
			end
		end
	end
end

local function ProcessDialogTree(parentMapId)
	local index = 1
	local unitGUID = UnitGUID("target") or UnitGUID("mouseover")
	local gossipOptions = C_GossipInfo.GetOptions()
	if unitGUID then
		local _, _, _, _, _, npcId = strsplit("-", unitGUID); npcId = tonumber(npcId)
		if HelpMePlayIgnoredCreaturesDB[npcId] then return end
		
		if HelpMePlayDB.DevModeEnabled then
			for i = 1, #gossipOptions do
				print(npcId .. " | " .. i .. " | " .. gossipOptions[i].gossipOptionID)
			end
		end
		
		SelectGossipOption(gossipOptions, npcId, parentMapId)
	else
		SelectGossipOption(gossipOptions, 0, parentMapId)
	end
end

local function ConfirmConfirmationMessage(message, npcId, parentMapId)
	if HelpMePlayPlayerDialogDB[npcId] then
		if HelpMePlayPlayerDialogDB[npcId]["c"] then
			StaticPopup1Button1:Click("LeftButton")
			return
		end
	end
	
	local gossipTable = GetGossipTable(parentMapId)
	if gossipTable[npcId] then
		if gossipTable[npcId]["c"] then
			StaticPopup1Button1:Click("LeftButton")
			return
		end
	end
end

e:RegisterEvent("GOSSIP_CONFIRM")
e:RegisterEvent("GOSSIP_SHOW")
e:SetScript("OnEvent", function(self, event, ...)
	if event == "GOSSIP_CONFIRM" then
		if HelpMePlayDB.Enabled == false or HelpMePlayDB.Enabled == nil then return false end
		if HelpMePlayDB.GossipEnabled == false or HelpMePlayDB.GossipEnabled == nil then return false end
		
		local _, message = ...
		local index = 1
		local unitGUID = UnitGUID("target") or UnitGUID("mouseover")
		if unitGUID then
			local _, _, _, _, _, npcId = strsplit("-", unitGUID); npcId = tonumber(npcId)
			if HelpMePlayIgnoredCreaturesDB[npcId] then return end
			
			local parentMapId = GetParentMapID(C_Map.GetBestMapForUnit("player"))
			if gossipEnabledMaps[currentMapId] then
				ConfirmConfirmationMessage(message, npcId, parentMapId)
			end
		end
	end
	if event == "GOSSIP_SHOW" then
		if HelpMePlayDB.Enabled == false or HelpMePlayDB.Enabled == nil then return false end
		if HelpMePlayDB.GossipEnabled == false or HelpMePlayDB.GossipEnabled == nil then return end
		
		local parentMapId = GetParentMapID(C_Map.GetBestMapForUnit("player"))
		--if gossipEnabledMaps[currentMapId] then
			ProcessDialogTree(parentMapId)
		--end
	end
end)