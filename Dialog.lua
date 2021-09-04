local addonName, addonTable = ...
local e = CreateFrame("Frame")
local L = addonTable.L

e:RegisterEvent("GOSSIP_CONFIRM")
e:RegisterEvent("GOSSIP_CONFIRM_CANCEL")
e:RegisterEvent("GOSSIP_SHOW")
e:RegisterEvent("MODIFIER_STATE_CHANGED")

local creatures = {
	[1] = { -- Gossip options used on two or more NPCs.
		["gossips"] = {
			L["Are you enjoying yourself?"], -- Added from Quest: Mix, Mingle, and Meddle (Revendreth)
			L["Go hunt somewhere else!"], -- Added from Quest: Amateur Hour (Highmountain)
			L["There is no time left. Run!"], -- Added from Quest: Evacuate Snowmane (Highmountain)
			L["Let's go!"], -- Added from Quest: Lead the Way (Revendreth)
			L["I'm ready."], -- Added from Quest: Heroes of the Horde! (Hillsbrad Foothills)
			L["Let's duel."], -- Added from Quest: To Be Prepared (Durotar)
			L["I am ready."], -- Added from Quest: Cenarius, Keeper of the Grove (Val'sharah)
			L["Leave the Darkpens."], -- Added from Quest: Lieutenant of the Tower (Val'sharah)
			L["Take us back to Zuldazar."], -- Added from Quest: Return to Zuldazar (Stormsong Valley)
			L["<Reach inside and pull something out.>"], -- Added from Quest: Krazzlefrazz Outpost (Drustvar)
			L["<Reach inside and pull out something that feels more like a building.>"], -- Added from Quest: Krazzlefrazz Outpost (Drustvar)
			L["Begin pet battle."],
			L["Let's do battle!"],
			L["I've heard this tale before..."],
		}
	},
	[2] = { -- NPCs with Cost
		["gossips"] = {
			L["I'd like to heal and revive my battle pets."],
		},
	},
	-- Exile's Reach
	[167179] = { -- Daelya Twilightsbane
		["gossips"] = {
			L["Daelya Twilightsbane 1"],
			L["Daelya Twilightsbane 2"],
		},
	},
	[167298] = { -- Herbert Gloomburst
		["gossips"] = {
			L["Herbert Gloomburst 1"],
		},
	},
	[167309] = { -- Herbert Gloomburst
		["gossips"] = {
			L["Herbert Gloomburst 2"],
		},
	},
	[167663] = { -- Warlord Breka Grimaxe
		["gossips"] = {
			L["Warlord Breka Grimaxe 1"],
		},
	},
	-- Eastern Kingdoms: Blasted Lands
	[78423] = { -- Archmage Khadgar
		["gossips"] = {
			L["Archmage Khadgar 1"],
		},
		["confirms"] = {
			L["Archmage Khadgar 2"],
		},
	},
	-- Eastern Kingdoms: Hillsbrad Foothills
	[47442] = { -- Johnny Awesome
		["gossips"] = {
			L["Johnny Awesome 1"],
			L["Johnny Awesome 2"],
			L["Johnny Awesome 3"],
		},
	},
	[47443] = { -- Kingslayer Orkus
		["gossips"] = {
			L["Kingslayer Orkus 1"],
			L["Kingslayer Orkus 2"],
			L["Kingslayer Orkus 3"],
		},
	},
	[47444] = { -- Dumass
		["gossips"] = {
			L["Dumass 1"],
			L["Dumass 2"],
		},
	},
	[48218] = { -- Kingslayer Orkus
		["gossips"] = {
			L["Kingslayer Orkus 4"]
		},
	},
	-- Eastern Kingdoms: Silverpine Forest
	[44825] = { -- Bat Handler Maggotbreath
		["gossips"] = {
			L["Bat Handler Maggotbreath 1"],
		},
	},
	[45752] = { -- Ambermill Dimensional Portal
		["gossips"] = {
			L["Ambermill Dimensional Portal 1"],
		},
	},
	-- Eastern Kingdoms: Stormwind City
	[107934] = { -- Recruiter Lee
		["gossips"] = {
			L["I've heard this tale before..."],
		},
		["confirms"] = {
			L["Are you sure you want to skip the Broken Shore introduction?"],
		},
	},
	[149626] = { -- Vanguard Battlemage (Alliance)
		["gossips"] = {
			L["Vanguard Battlemage 1"],
		},
	},
	-- Eastern Kingdoms: Tirisfal Glades
	[141488] = { -- Zidormi
		["gossips"] = {
			L["Zidormi 1"],
		},
	},
	-- Kalimdor: Durotar
	[4311] = { -- Holgar Stormaxe
		["gossips"] = {
			L["I've heard this tale before..."],
		},
		["confirms"] = {
			L["Are you sure you want to skip the Broken Shore introduction?"],
		},
	},
	-- Kalimdor: Orgrimmar
	[135205] = { -- Nathanos Blightcaller
		["gossips"] = {
			L["Nathanos Blightcaller 1"],
		}
	},
	[167032] = { -- Chromie
		["gossips"] = {
			L["Chromie 1"],
			L["Chromie 2"],
		}
	},
	[168431] = { -- Warlord Breka Grimaxe
		["gossips"] = {
			L["Warlord Breka Grimaxe 2"],
		},
	},
	[171791] = { -- Nazgrim
		["gossips"] = {
			L["Nazgrim 1"],
		}
	},
	-- Draenor: Garrison (Alliance)
	[79243] = { -- Baros Alexston
		["gossips"] = {
			L["Baros Alexston 1"],
		},
	},
	[84455] = { -- Assistant Brightstone
		["gossips"] = {
			L["Assistant Brightstone 1"],
		},
	},
	[81441] = { -- Shelly Hamby
		["gossips"] = {
			L["Shelly Hamby 1"],
		},
	},
	-- Draenor: Tanaan Jungle
	[78568] = { -- Thaelin Darkanvil
		["gossips"] = {
			L["Thaelin Darkanvil 1"],
		},
	},
	-- Draenor: Garrison (Horde)
	[80225] = { -- Skaggit
		["gossips"] = {
			L["Skaggit 1"],
		},
	},
	[86775] = { -- Senior Peon II
		["gossips"] = {
			L["Senior Peon II 1"],
		},
	},
	[88228] = { -- Sergeant Grimjaw
		["gossips"] = {
			L["Sergeant Grimjaw 1"],
		},
	},
	-- Draenor: Shadowmoon Valley
	[72871] = { -- All-Seeing Eye
		["gossips"] = {
			L["All-Seeing Eye 1"],
		},
	},
	[78556] = { -- Ariok
		["gossips"] = {
			L["Ariok 1"],
		},
	},
	-- Broken Isles: Highmountain
	[98825] = { -- Spiritwalker Ebonhorn
		["gossips"] = {
			L["Spiritwalker Ebonhorn 1"],
			L["Spiritwalker Ebonhorn 2"],
		},
	},
	[99745] = { -- Snazzle Shinyfinder
		["gossips"] = {
			L["Snazzle Shinyfinder 1"],
		},
	},
	[99746] = { -- Trytooth Hardchisel
		["gossips"] = {
			L["Trytooth Hardchisel 1"],
		},
	},
	[99747] = { -- Kindle Candlecrafter
		["gossips"] = {
			L["Kindle Candlecrafter 1"],
		},
	},
	[99748] = { -- Dug Digger
		["gossips"] = {
			L["Dug Digger 1"],
		},
	},
	[99781] = { -- Snazzle Shinyfinder
		["gossips"] = {
			L["Snazzle Shinyfinder 2"],
		},
	},
	[99782] = { -- Trytooth Hardchisel
		["gossips"] = {
			L["Trytooth Hardchisel 2"],
			L["Trytooth Hardchisel 3"],
		},
	},
	[99784] = { -- Kindle Candlecrafter
		["gossips"] = {
			L["Kindle Candlecrafter 2"],
		},
	},
	[95403] = { -- Windmaster Julan
		["gossips"] = {
			L["Windmaster Julan 1"],
		},
	},
	[96286] = { -- Navarrogg
		["gossips"] = {
			L["Navarrogg 1"],
		},
	},
	[98773] = { -- Lasan Skyhorn
		["gossips"] = {
			L["Yes!"],
		},
	},
	[94434] = { -- Addie Fizzlebog
		["gossips"] = {
			L["Addie Fizzlebog 1"],
		},
	},
	-- Broken Isles: Val'sharah
	[92734] = { -- Penelope Heathrow
		["gossips"] = {
			L["Penelope Heathrow 1"],
		},
	},
	[94974] = { -- Sirius Ebonwing
		["gossips"] = {
			L["Sirius Ebonwing 1"],
		},
	},
	[94975] = { -- Asha Ravensong
		["gossips"] = {
			L["Asha Ravensong 1"],
		},
	},
	[94976] = { -- Cassiel Nightthorn
		["gossips"] = {
			L["Cassiel Nightthorn 1"],
		},
	},
	[104739] = { -- Tyrande Whisperwind
		["gossips"] = {
			L["Tyrande Whisperwind 1"],
			L["Tyrande Whisperwind 2"],
		},
	},
	[108642] = { -- Keeper Remulos
		["gossips"] = {
			L["Keeper Remulos 1"],
		},
	},
	-- Kul Tiras: Drustvar
	[137613] = { -- Hobart Grapplehammer
		["gossips"] = {
			L["Hobart Grapplehammer 1"],
			L["Hobart Grapplehammer 2"],
		},
	},
	-- Kul Tiras: Stormsong Valley
	[138137] = { -- Huelo
		["gossips"] = {
			L["Huelo 1"],
		},
	},
	-- Kul Tiras: Tiragarde Sound
	[137675] = { -- Shadow Hunter Ty'jin
		["gossips"] = {
			L["Shadow Hunter Ty'jin 1"],
		},
	},
	[137798] = { -- Boatswain Taryn
		["gossips"] = {
			L["Boatswain Taryn 1"],
		},
	},
	[137800] = { -- Quartermaster Killian
		["gossips"] = {
			L["Quartermaster Killian 1"],
		},
	},
	[137807] = { -- Navigator Swink
		["gossips"] = {
			L["Navigator Swink 1"],
		},
	},
	-- Zandalar: Zuldazar
	[135440] = { -- Princess Talanji
		["gossips"] = {
			L["Princess Talanji 1"],
		},
	},
	[135690] = { -- Dread-Admiral Tattersail
		["gossips"] = {
			L["Quest"],
		},
	},
	-- Shadowlands: The Maw
	[165918] = { -- Highlord Darion Mograine
		["gossips"] = {
			L["Highlord Darion Mograine 1"],
		},
	},
	[166980] = { -- Lady Jaina Proudmoore
		["gossips"] = {
			L["Lady Jaina Proudmoore 1"],
			L["Lady Jaina Proudmoore 2"],
			L["Lady Jaina Proudmoore 3"],
			L["Lady Jaina Proudmoore 4"],
		}
	},
	-- Shadowlands: Oribos
	[159478] = { -- Tal-Inara
		["gossips"] = {
			L["Tal-Inara 1"],
		},
	},
	[164079] = { -- Highlord Bolvar Fordragon
		["gossips"] = {
			L["Highlord Bolvar Fordragon 1"],
			L["Highlord Bolvar Fordragon 2"],
		},
	},
	[177136] = { -- Polemarch Adrestes
		["gossips"] = {
			L["Polemarch Adrestes 1"],
		},
	},
	-- Shadowlands: Bastion
	[156327] = { -- Voitha
		["gossips"] = {
			L["Voitha 1"],
		},
	},
	[157696] = { -- Nemea
		["gossips"] = {
			L["Nemea 1"],
		},
	},
	[158765] = { -- Pelodis
		["gossips"] = {
			L["Pelodis 1"],
		},
	},
	[169027] = { -- Helpful Steward (for the fixes)
		["gossips"] = {
			L["Helpful Steward 1"],
		},
	},
	[169078] = { -- Helpful Steward (to get them to follow you)
		["gossips"] = {
			L["Helpful Steward 2"],
		},
	},
	[172714] = { -- Trapped Caretaker
		["gossips"] = {
			L["Trapped Caretaker 1"],
		},
	},
	-- Shadowlands: Maldraxxus
	[159696] = { -- Rencissa the Dynamo
		["gossips"] = {
			L["Rencissa the Dynamo 1"],
		},
	},
	[159827] = { -- Scrapper Minoire
		["gossips"] = {
			L["Scrapper Minoire 1"],
		},
	},
	[160917] = { -- Grimshadow
		["gossips"] = {
			L["Grimshadow 1"],
		},
	},
	[161710] = { -- Marcel Mullby
		["gossips"] = {
			L["Marcel Mullby 1"],
		},
	},
	[164492] = { -- Arena Spectator
		["gossips"] = {
			L["Arena Spectator 1"],
		},
	},
	[165966] = { -- Khaliiq
		["gossips"] = {
			L["Khaliiq 1"],
		},
	},
	[166129] = { -- Specialist Entra
		["gossips"] = {
			L["Specialist Entra 1"],
		},
	},
	[166657] = { -- Ta'eran
		["gossips"] = {
			L["Ta'eran 1"],
		},
	},
	-- Shadowlands: Ardenweald
	[158543] = { -- Attendant Sparkledew
		["gossips"] = {
			L["Attendant Sparkledew 1"],
		},
	},
	[160121] = { -- Master Sha'lor
		["gossips"] = {
			L["Master Sha'lor 1"],
		},
	},
	[165550] = { -- Attendant Shimmerwing
		["gossips"] = {
			L["Attendant Shimmerwing 1"],
		},
	},
	[169273] = { -- Silkstrider Caretaker
		["gossips"] = {
			L["Silkstrider Caretaker 1"],
		},
	},
	[172431] = { -- Lady Moonberry
		["gossips"] = {
			L["Lady Moonberry 1"],
		},
	},
	-- Shadowlands: Revendreth
	[159883] = { -- Chancellor Codrin
		["gossips"] = {
			L["Chancellor Codrin 1"],
		},
	},
	[159946] = { -- The Countess
		["gossips"] = {
			L["The Countess 1"],
		},
	},
	[160941] = { -- The Curator
		["gossips"] = {
			L["The Curator 1"],
		},
	},
	[161056] = { -- Guard Captain Elizabeta
		["gossips"] = {
			L["Guard Captain Elizabeta 1"],
		},
	},
	[165662] = { -- The Countess
		["gossips"] = {
			L["The Countess 2"],
		},
	},
	[166541] = { -- Cobwobble
		["gossips"] = {
			L["Cobwobble 1"],
		},
	},
	[166542] = { -- Slobwobble
		["gossips"] = {
			L["Slobwobble 1"],
		},
	},
	[166543] = { -- Dobwobble
		["gossips"] = {
			L["Dobwobble 1"],
		},
	},
	[169238] = { -- Courier Araak
		["gossips"] = {
			L["Courier Araak 1"],
		},
	},
	[169917] = { -- Avowed Ritualist
		["gossips"] = {
			L["Avowed Ritualist 1"],
		},
	},
	-- Instance: Mogu'shan Vaults
	[61348] = { -- Lorewalker Cho
		["gossips"] = {
			L["Lorewalker Cho 1"],
			L["Lorewalker Cho 2"],
		},
	},
	-- Instance: Isle of Thunder (Scenario)
	[69565] = { -- Scout Captain Elsia
		["gossips"] = {
			L["Scout Captain Elsia 1"],
		},
	},
	[69810] = { -- Taoshi
		["gossips"] = {
			L["Taoshi 1"],
		},
	},
	[70297] = { -- Taoshi
		["gossips"] = {
			L["Taoshi 2"],
		},
	},
	-- Instance: Horrific Visions
	[152993] = { -- Garona Halforcen (Vision of Orgrimmar)
		["gossips"] = {
			L["Garona Halforcen 1"],
		},
	},
	[160998] = { -- Altar of the Daredevil
		["gossips"] = {
			L["Altar of the Daredevil 1"],
		},
	},
	[160961] = { -- Altar of the Dark Imagination
		["gossips"] = {
			L["Altar of the Dark Imagination 1"],
		},
	},
	[161000] = { -- Altar of the Pained
		["gossips"] = {
			L["Altar of the Pained 1"],
		},
	},
	[160967] = { -- Altar of the Burned Bridge
		["gossips"] = {
			L["Altar of the Burned Bridge 1"],
		},
	},
	[160999] = { -- Altar of the Long Night
		["gossips"] = {
			L["Altar of the Long Night 1"],
		},
	},
}

e:SetScript("OnEvent", function(self, event, ...)
	if event == "GOSSIP_CONFIRM" then
		local _, message = ...
		if IsModifierKeyDown() then return end
		local index = 1
		local unitGUID = UnitGUID("target") or UnitGUID("mouseover")
		if unitGUID then
			local _, _, _, _, _, npcID = strsplit("-", unitGUID); npcID = tonumber(npcID)
			for id, _ in pairs(creatures) do
				if id == npcID then
					for i = 1, #creatures[id]["confirms"] do
						if string.find(string.lower(message), string.lower(creatures[id]["confirms"][i])) then
							StaticPopup1Button1:Click()
						end
					end
				end
			end
		end
	end
	if event == "GOSSIP_SHOW" then
		if IsModifierKeyDown() then return end
		local numActiveQuests = C_GossipInfo.GetNumActiveQuests()
		if numActiveQuests > 0 then
			local activeQuests = C_GossipInfo.GetActiveQuests()
			for i = 1, numActiveQuests do
				if activeQuests[i].isComplete then
					C_Timer.After(0, function()
						C_Timer.After(0.1, function()
							-- Do nothing here, we just want a slight delay to let active quests be handled first.
						end)
					end)
				end
			end
		end
		local index = 1
		local unitGUID = UnitGUID("target") or UnitGUID("mouseover")
		local gossipOptions = C_GossipInfo.GetOptions()
		if unitGUID then
			local _, _, _, _, _, npcID = strsplit("-", unitGUID); npcID = tonumber(npcID)
			for index, gossipOptionsSubTable in ipairs(gossipOptions) do
				for i = 1, 2 do
					for j = 1, #creatures[i]["gossips"] do
						if string.find(string.lower(gossipOptionsSubTable["name"]), string.lower(creatures[i]["gossips"][j])) then
							C_GossipInfo.SelectOption(index)
						end
					end
				end
				for id, _ in pairs(creatures) do
					if id == npcID then -- The target's ID is in the table, so use its configuration.
						for i = 1, #creatures[id]["gossips"] do
							if string.find(string.lower(gossipOptionsSubTable["name"]), string.lower(creatures[id]["gossips"][i])) then
								C_GossipInfo.SelectOption(index)
							end
						end
					end
				end
			end
		else
			for index, gossipOptionsSubTable in ipairs(gossipOptions) do
				for i = 1, 2 do
					for j = 1, #creatures[i]["gossips"] do
						if string.find(string.lower(gossipOptionsSubTable["name"]), string.lower(creatures[i]["gossips"][j])) then
							C_GossipInfo.SelectOption(index)
						end
					end
				end
			end
		end
	end
end)