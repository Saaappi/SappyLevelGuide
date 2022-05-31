local addonName, addonTable = ...
local e = CreateFrame("Frame")
local L_DIALOG = addonTable.L_DIALOG
local L_NOTES = addonTable.L_NOTES
local L_GLOBALSTRINGS = addonTable.L_GLOBALSTRINGS
local glowDuration = 1.5

--[[
	Description:
		Adds the action button glow effect to the vehicle
		button that should be used, depending on what
		speech was used by the NPC.
]]--
local function AddGlowToActionBarButton(button, glowTimer)
	ActionButton_ShowOverlayGlow(button)
	button:SetScript("OnClick", function()
		ActionButton_HideOverlayGlow(button)
	end)
	C_Timer.After(glowTimer, function()
		ActionButton_HideOverlayGlow(button)
	end)
end

e:RegisterEvent("CHAT_MSG_MONSTER_SAY")
e:RegisterEvent("RAID_BOSS_EMOTE")
e:RegisterEvent("RAID_BOSS_WHISPER")
e:SetScript("OnEvent", function(self, event, ...)
	if event == "CHAT_MSG_MONSTER_SAY" then
		if HelpMePlayOptionsDB.Speech == false or HelpMePlayOptionsDB.Speech == nil then return end
		local msg = ...
		for k,v in pairs(addonTable.SPEECH) do
			if string.find(string.lower(msg), string.lower(k)) then
				if v.type == "emote" then
					DoEmote(v.emote, nil)
				elseif v.type == "glow" then
					if v.button == 1 then
						AddGlowToActionBarButton(OverrideActionBarButton1, glowDuration)
					elseif v.button == 2 then
						AddGlowToActionBarButton(OverrideActionBarButton2, glowDuration)
					elseif v.button == 3 then
						AddGlowToActionBarButton(OverrideActionBarButton3, glowDuration)
					end
				end
				
				break
			end
		end
	end
	if event == "RAID_BOSS_WHISPER" then
		if HelpMePlayOptionsDB.Speech == false or HelpMePlayOptionsDB.Speech == nil then return end
		local msg = ...
		for k,v in pairs(addonTable.SPEECH) do
			if string.find(string.lower(msg), string.lower(k)) then
				if v.type == "glow" then
					if v.button == 1 then
						AddGlowToActionBarButton(OverrideActionBarButton1, glowDuration)
					elseif v.button == 2 then
						AddGlowToActionBarButton(OverrideActionBarButton2, glowDuration)
					elseif v.button == 3 then
						AddGlowToActionBarButton(OverrideActionBarButton3, glowDuration)
					end
				end
				break
			end
		end
	end
	if event == "RAID_BOSS_EMOTE" then
		if HelpMePlayOptionsDB.Speech == false or HelpMePlayOptionsDB.Speech == nil then return end
		local msg = ...
		for k,v in pairs(addonTable.SPEECH) do
			if string.find(string.lower(msg), string.lower(k)) then
				if v.type == "glow" then
					if v.button == 1 then
						AddGlowToActionBarButton(OverrideActionBarButton1, glowDuration)
					elseif v.button == 2 then
						AddGlowToActionBarButton(OverrideActionBarButton2, glowDuration)
					elseif v.button == 3 then
						AddGlowToActionBarButton(OverrideActionBarButton3, glowDuration)
					end
				end
				break
			end
		end
	end
end)