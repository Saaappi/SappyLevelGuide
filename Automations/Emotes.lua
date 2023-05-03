local name, addon = ...
local e = CreateFrame("Frame")

--[[
	Description:
		The addon.EMOTES table holds key-value pairs
		associated with an NPC ID.
		
		If gossip in the table is TRUE for a given NPC, then
		we want to process the GOSSIP_SHOW event. Otherwise,
		just ignore it.
		
		As a shortcut, we use the PLAYER_TARGET_CHANGED event
		to quickly emote at targets. This is used in Dun Morogh
		on the Stolen Rams, as well as in Maldraxxus on the
		Runestones for the "Repeat After Me" quest.
]]--
e:RegisterEvent("GOSSIP_SHOW")
e:RegisterEvent("PLAYER_TARGET_CHANGED")
e:SetScript("OnEvent", function(self, event, ...)
	if event == "GOSSIP_SHOW" then
		if HelpMePlayDB.Enabled == false or HelpMePlayDB.Enabled == nil then return false end
		if HelpMePlayDB.EmotesEnabled == false or HelpMePlayDB.EmotesEnabled == nil then return false end
		local guid = UnitGUID("target")
		if guid then
			local _, _, _, _, _, npcId = strsplit("-", guid); npcId = tonumber(npcId)
			for id, t in pairs(addon.EMOTES) do
				if t.gossip then
					if id == npcId then
						DoEmote(t.emote, nil)
						GossipFrame:Hide()
					end
				end
			end
		end
	end
	if event == "PLAYER_TARGET_CHANGED" then
		if HelpMePlayDB.Enabled == false or HelpMePlayDB.Enabled == nil then return false end
		if HelpMePlayDB.EmotesEnabled == false or HelpMePlayDB.EmotesEnabled == nil then return false end
		local guid = UnitGUID("target")
		if guid then
			local _, _, _, _, _, npcId = strsplit("-", guid); npcId = tonumber(npcId)
			for id, t in pairs(addon.EMOTES) do
				if id == npcId then
					if t.emote == "dismount" then
						Dismount()
					else
						DoEmote(t.emote, nil)
					end
					break
				end
			end
		end
	end
end)