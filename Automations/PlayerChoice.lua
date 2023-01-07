local addonName, addonTable = ...
local e = CreateFrame("Frame")
local L_GLOBALSTRINGS = addonTable.L_GLOBALSTRINGS

e:RegisterEvent("PLAYER_CHOICE_UPDATE")
e:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_CHOICE_UPDATE" then
		if HelpMePlayDB.Enabled == false or HelpMePlayDB.Enabled == nil then return false end
		if PlayerChoiceFrame:IsVisible() then
			local mapId = C_Map.GetBestMapForUnit("player")
			local choiceInfo = C_PlayerChoice.GetCurrentPlayerChoiceInfo()
			if choiceInfo then
				local _, _, _, _, _, id = string.split("-", choiceInfo.objectGUID)
				if tonumber(id) then
					id = tonumber(id)
				else
					id = choiceInfo.choiceID
				end
				
				if id then
					if id == 164173 or id == 174871 then
						-- Fatescribe Roh-Tahl
						-- Threads of Fate or Story Mode
						if HelpMePlayDB.ThreadsOfFateEnabled then
							C_PlayerChoice.SendPlayerChoiceResponse(choiceInfo.options[1].buttons[1].id)
							HideUIPanel(PlayerChoiceFrame)
						else
							C_PlayerChoice.SendPlayerChoiceResponse(choiceInfo.options[2].buttons[1].id)
							HideUIPanel(PlayerChoiceFrame)
						end
					elseif id == 97644 then
						-- Kor'vas Bloodthorn
						-- Always chooses Kayn Sunfury
						C_PlayerChoice.SendPlayerChoiceResponse(choiceInfo.options[1].buttons[1].id)
						HideUIPanel(PlayerChoiceFrame)
					elseif id == 355352 or id == 357514 then
						if HelpMePlayDB.CovenantId == 0 or HelpMePlayDB.CovenantId == false or HelpMePlayDB.AdventureMapsEnabled == nil then return false end
						if HelpMePlayDB.CovenantId == 1 then
							C_PlayerChoice.SendPlayerChoiceResponse(choiceInfo.options[1].buttons[1].id)
							HideUIPanel(PlayerChoiceFrame)
						elseif HelpMePlayDB.CovenantId == 2 then
							C_PlayerChoice.SendPlayerChoiceResponse(choiceInfo.options[2].buttons[1].id)
							HideUIPanel(PlayerChoiceFrame)
						elseif HelpMePlayDB.CovenantId == 3 then
							C_PlayerChoice.SendPlayerChoiceResponse(choiceInfo.options[3].buttons[1].id)
							HideUIPanel(PlayerChoiceFrame)
						elseif HelpMePlayDB.CovenantId == 4 then
							C_PlayerChoice.SendPlayerChoiceResponse(choiceInfo.options[4].buttons[1].id)
							HideUIPanel(PlayerChoiceFrame)
						elseif HelpMePlayDB.CovenantId == 5 then
							local _, _, classId = UnitClass("player")
							local specIndex = GetSpecialization()
							local specId = GetSpecializationInfo(specIndex)
							
							C_PlayerChoice.SendPlayerChoiceResponse(choiceInfo.options[addonTable.COVENANTS_BY_SPEC[classId][specId]].buttons[1].id)
							HideUIPanel(PlayerChoiceFrame)
						end
					elseif id == 342 or id == 352 then
						-- 342: Warchief's Command Board
						-- 352: Hero's Call Board
						for i = 1, 3 do
							if choiceInfo.options[i].choiceArtID == 1851147 then
								-- Tanaan Jungle
								C_PlayerChoice.SendPlayerChoiceResponse(choiceInfo.options[i].buttons[1].id)
								HideUIPanel(PlayerChoiceFrame)
							end
						end
					end
				end
			end
		end
	end
end)