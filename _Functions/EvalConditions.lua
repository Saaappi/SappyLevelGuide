local addonName, addon = ...
local eventHandler = CreateFrame("Frame")

local function CheckQuests(cond, string, numConditions)
    local quests = {}
    for questID in string:gmatch("%d+") do
        table.insert(quests, tonumber(questID))
    end

    local conjunction = string:match("%s(OR|AND)%s")
    local numQuests = #quests
    if conjunction == "AND" then
        -- If all the quests are active, then return true.
        for _, questID in ipairs(quests) do
            if cond == "QUEST_ACTIVE" then
                if C_QuestLog.IsOnQuest(questID) then
                    numQuests = numQuests - 1
                end
            elseif cond == "QUEST_INACTIVE" then
                if not C_QuestLog.IsOnQuest(questID) then
                    numQuests = numQuests - 1
                end
            elseif cond == "QUEST_COMPLETE" then
                if C_QuestLog.IsQuestFlaggedCompleted(questID) then
                    numQuests = numQuests - 1
                end
            elseif cond == "QUEST_INCOMPLETE" then
                if not C_QuestLog.IsQuestFlaggedCompleted(questID) then
                    numQuests = numQuests - 1
                end
            end
            if numQuests == 0 then
                numConditions = numConditions - 1
                break
            end
        end
    else
        -- If any of the quests are active, then return true.
        for _, questID in ipairs(quests) do
            if cond == "QUEST_ACTIVE" then
                if C_QuestLog.IsOnQuest(questID) then
                    numConditions = numConditions - 1
                    break
                end
            elseif cond == "QUEST_INACTIVE" then
                if not C_QuestLog.IsOnQuest(questID) then
                    numConditions = numConditions - 1
                    break
                end
            elseif cond == "QUEST_COMPLETE" then
                if C_QuestLog.IsQuestFlaggedCompleted(questID) then
                    numConditions = numConditions - 1
                    break
                end
            elseif cond == "QUEST_INCOMPLETE" then
                if not C_QuestLog.IsQuestFlaggedCompleted(questID) then
                    numConditions = numConditions - 1
                    break
                end
            end
        end
    end
end

eventHandler:RegisterEvent("ADDON_LOADED")
eventHandler:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonLoaded = ...
        if addonLoaded == addonName then
            function HelpMePlay.EvalConditions(conditions)
                local numConditions = #conditions
                for _, condition in ipairs(conditions) do
                    local cond = condition:match("([%w_]+)")
                    if cond == "NONE" then
                        numConditions = numConditions - 1
                    elseif cond == "QUEST_ACTIVE" or cond == "QUEST_INACTIVE" or cond == "QUEST_COMPLETE" or cond == "QUEST_INCOMPLETE" then
                        local string = condition:match("= (.+)")
                        local numConditionsMet = CheckQuests(cond, string, numConditions)
                        if numConditionsMet == 0 then
                            numConditions = numConditions - 1
                        end
                    elseif cond == "QUEST_OBJECTIVES_COMPLETE" or cond == "QUEST_OBJECTIVES_INCOMPLETE" then
                        local string = condition:match("= (.+)")
                        local quests = {}
                        for questID in string:gmatch("%d%d+") do
                            table.insert(quests, tonumber(questID))
                        end
                        local conjunction = string:match("%s(OR|AND)%s"); print(conjunction)
                        local numQuests = #quests
                        if conjunction == "AND" then
                            for questID, objectiveIndex in string:gmatch("(%d+),(%w+)") do
                                print(objectiveIndex)
                                if tonumber(objectiveIndex) then
                                    objectiveIndex = tonumber(objectiveIndex)
                                end
                                local objectives = C_QuestLog.GetQuestObjectives(questID)
                                if cond == "QUEST_OBJECTIVES_COMPLETE" then
                                    if objectiveIndex == "*" then
                                        for _, objective in ipairs(objectives) do
                                            if objective.finished then
                                                numQuests = numQuests - 1
                                            end
                                        end
                                        if numQuests == 0 then
                                            numConditions = numConditions - 1
                                        end
                                    else
                                        for _, objective in ipairs(objectives) do
                                            if objective.finished then
                                                numQuests = numQuests - 1
                                            end
                                        end
                                        if numQuests == 0 then
                                            numConditions = numConditions - 1
                                        end
                                    end
                                elseif cond == "QUEST_OBJECTIVES_INCOMPLETE" then
                                    if objectiveIndex == "*" then
                                        for _, objective in ipairs(objectives) do
                                            if not objective.finished then
                                                numQuests = numQuests - 1
                                            end
                                        end
                                        if numQuests == 0 then
                                            numConditions = numConditions - 1
                                        end
                                    else
                                        for _, objective in ipairs(objectives) do
                                            if not objective.finished then
                                                numQuests = numQuests - 1
                                            end
                                        end
                                        if numQuests == 0 then
                                            numConditions = numConditions - 1
                                        end
                                    end
                                end
                            end
                        else
                            for questID, objectiveIndex in string:gmatch("(%d+),(%w+)") do
                                if tonumber(objectiveIndex) then
                                    objectiveIndex = tonumber(objectiveIndex)
                                end
                                local objectives = C_QuestLog.GetQuestObjectives(questID)
                                if cond == "QUEST_OBJECTIVES_COMPLETE" then
                                    if objectiveIndex == "*" then
                                        for _, objective in ipairs(objectives) do
                                            if objective.finished then
                                                numConditions = numConditions - 1
                                                break
                                            end
                                        end
                                    else
                                        if objectives[objectiveIndex].finished then
                                            numConditions = numConditions - 1
                                            break
                                        end
                                    end
                                elseif cond == "QUEST_OBJECTIVES_INCOMPLETE" then
                                    if objectiveIndex == "*" then
                                        for _, objective in ipairs(objectives) do
                                            if not objective.finished then
                                                numConditions = numConditions - 1
                                                break
                                            end
                                        end
                                    else
                                        if not objectives[objectiveIndex].finished then
                                            numConditions = numConditions - 1
                                        end
                                    end
                                end
                            end
                        end
                    --[[local operator, operand = condition:match("([%w_]+)%s*=%s*([%w_,]+)")
                    if tonumber(operand) then
                        operand = tonumber(operand, 10)
                    end
                    if operator == "LEVEL_LOWER" then
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
                    end]]
                end
                if numConditions == 0 then
                    return true
                end
                return false
            end
        end
    end
    -- Unload the event for performance.
    eventHandler:UnregisterEvent("ADDON_LOADED")
    end
end)