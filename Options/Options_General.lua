local addonName, addonTable = ...
local e = CreateFrame("Frame")
local L_DIALOG = addonTable.L_DIALOG
local L_NOTES = addonTable.L_NOTES
local L_GLOBALSTRINGS = addonTable.L_GLOBALSTRINGS
local numTabs = 4
local icon = ""

function HelpMePlay:MinimapIcon(bool)
	if bool then
		if icon ~= "" then
			icon:Show(addonName)
		else
			icon = LibStub("LibDBIcon-1.0")
			-- Create a Lib DB first to hold all the
			-- information for the minimap icon.
			local iconLDB = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject(addonName, {
				type = "launcher",
				icon = "Interface\\Icons\\achievement_reputation_08",
				OnTooltipShow = function(tooltip)
					tooltip:SetText(L_GLOBALSTRINGS["Colored Addon Name"] .. " |cffFFFFFFv" .. GetAddOnMetadata(addonName, "Version") .. "|r")
					tooltip:AddLine(L_GLOBALSTRINGS["Minimap Icon Subtext"])
					tooltip:Show()
				end,
				OnClick = function() HelpMePlay:SlashCommandHandler("") end,
			})
			
			-- Register the minimap button with the
			-- LDB.
			icon:Register(addonName, iconLDB, HelpMePlayOptionsDB)
			icon:Show(addonName)
		end
	else
		icon:Hide(addonName)
	end
end

local generalOptions = {
	name = L_GLOBALSTRINGS["Tabs.General"],
	handler = HelpMePlay,
	type = "group",
	args = {
		enable = {
			name = L_GLOBALSTRINGS["General.Toggle.Enable"],
			order = 1,
			desc = L_GLOBALSTRINGS["General.Toggle.EnableDesc"],
			type = "toggle",
			set = function(info, val) HelpMePlayDB.Enabled = val end,
			get = function(info) return HelpMePlayDB.Enabled end
		},
		minimapIcon = {
			name = L_GLOBALSTRINGS["General.Toggle.MinimapIcon"],
			order = 2,
			desc = L_GLOBALSTRINGS["General.Toggle.MinimapIconDesc"],
			type = "toggle",
			set = function(info, val) HelpMePlayDB.MinimapIconEnabled = val; HelpMePlay:MinimapIcon(val) end,
			get = function(info) return HelpMePlayDB.MinimapIconEnabled end
		},
	},
}
addonTable.generalOptions = generalOptions