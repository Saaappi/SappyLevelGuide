local addonName, addon = ...
local eventHandler = CreateFrame("Frame")

eventHandler:RegisterEvent("ADDON_LOADED")
eventHandler:SetScript("OnEvent", function(self, event, addonLoaded)
    if event == "ADDON_LOADED" then
        function HelpMePlay.EvalConditions(conditions)
            local numConditions = #conditions
            for _, condition in ipairs(conditions) do
                local operator, operand = condition:match("([%w_]+)%s*=%s*([%w_,]+)")
                if tonumber(operand) then
                    operand = tonumber(operand, 10)
                end
                if operator == "NONE" then
                    numConditions = numConditions - 1
                elseif operator == "QUEST_ACTIVE" then
                    if C_QuestLog.IsOnQuest(operand) then
                        numConditions = numConditions - 1
                    end
                elseif operator == "QUEST_INACTIVE" then
                    if not C_QuestLog.IsOnQuest(operand) then
                        numConditions = numConditions - 1
                    end
                elseif operator == "QUEST_COMPLETE" then
                    if C_QuestLog.IsQuestFlaggedCompleted(operand) then
                        numConditions = numConditions - 1
                    end
                elseif operator == "QUEST_INCOMPLETE" then
                    if not C_QuestLog.IsQuestFlaggedCompleted(operand) then
                        numConditions = numConditions - 1
                    end
                elseif operator == "QUEST_OBJECTIVE_COMPLETE" then
                    operand = tostring(operand)
                    local questID, index = string.split(",", operand); questID = tonumber(questID, 10); index = tonumber(index, 10)
                    local objectives = C_QuestLog.GetQuestObjectives(questID)
                    if objectives[index].finished then
                        numConditions = numConditions - 1
                    end
                elseif operator == "QUEST_OBJECTIVE_INCOMPLETE" then
                    operand = tostring(operand)
                    local questID, index = string.split(",", operand); questID = tonumber(questID, 10); index = tonumber(index, 10)
                    local objectives = C_QuestLog.GetQuestObjectives(questID)
                    if not objectives[index].finished then
                        numConditions = numConditions - 1
                    end
                elseif operator == "QUEST_OBJECTIVES_COMPLETE" then
                    local numObjectives = C_QuestLog.GetNumQuestObjectives(operand)
                    local objectives = C_QuestLog.GetQuestObjectives(operand)
                    for _, objective in ipairs(objectives) do
                        if objective.finished then
                            numObjectives = numObjectives - 1
                        end
                    end
                    if numObjectives == 0 then
                        numConditions = numConditions - 1
                    end
                elseif operator == "QUEST_OBJECTIVES_INCOMPLETE" then
                    local numObjectives = C_QuestLog.GetNumQuestObjectives(operand)
                    local objectives = C_QuestLog.GetQuestObjectives(operand)
                    for _, objective in ipairs(objectives) do
                        if not objective.finished then
                            numObjectives = numObjectives - 1
                        end
                    end
                    if numObjectives == 0 then
                        numConditions = numConditions - 1
                    end
                elseif operator == "LEVEL_LOWER" then
                    if UnitLevel("player") < operand then
                        numConditions = numConditions - 1
                    end
                elseif operator == "LEVEL_LOWER_OR_EQUAL" then
                    if UnitLevel("player") <= operand then
                        numConditions = numConditions - 1
                    end
                elseif operator == "LEVEL_EQUAL" then
                    if UnitLevel("player") == operand then
                        numConditions = numConditions - 1
                    end
                elseif operator == "LEVEL_GREATER" then
                    if UnitLevel("player") > operand then
                        numConditions = numConditions - 1
                    end
                elseif operator == "LEVEL_GREATER_OR_EQUAL" then
                    if UnitLevel("player") >= operand then
                        numConditions = numConditions - 1
                    end
                elseif operator == "LEVEL_BETWEEN" then
                    operand = tostring(operand)
                    local playerLevel = UnitLevel("player")
                    local lowerLevel, higherLevel = string.split(",", operand); lowerLevel = tonumber(lowerLevel, 10); higherLevel = tonumber(higherLevel, 10)
                    if playerLevel >= lowerLevel and playerLevel <= higherLevel then
                        numConditions = numConditions - 1
                    end
                elseif operator == "CHROMIE_TIME_ACTIVE" then
                    if UnitChromieTimeID("player") == operand then
                        numConditions = numConditions - 1
                    end
                elseif operator == "CHROMIE_TIME_INACTIVE" then
                    if UnitChromieTimeID("player") ~= operand then
                        numConditions = numConditions - 1
                    end
                elseif operator == "WAR_MODE_ACTIVE" then
                    -- Blizzard made me this way...
                    local isEnlisted = false
                    local spellID = C_UnitAuras.GetAuraDataBySpellName("player", "Enlisted", "HELPFUL").spellId
                    if spellID == 269083 or spellID == 282559 then
                        isEnlisted = true
                    end
                    if isEnlisted then
                        numConditions = numConditions - 1
                    end
                elseif operator == "WAR_MODE_INACTIVE" then
                    -- Blizzard made me this way...
                    local isEnlisted = false
                    local spellID = C_UnitAuras.GetAuraDataBySpellName("player", "Enlisted", "HELPFUL").spellId
                    if spellID == 269083 or spellID == 282559 then -- Enlisted
                        isEnlisted = true
                    end
                    if not isEnlisted then
                        numConditions = numConditions - 1
                    end
                end
            end
            if numConditions == 0 then
                return true
            end
            return false
        end

        -- Unload the event for performance.
        eventHandler:UnregisterEvent("ADDON_LOADED")
    end
end)