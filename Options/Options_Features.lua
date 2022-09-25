local addonName, addonTable = ...
local L_DIALOG = addonTable.L_DIALOG
local L_NOTES = addonTable.L_NOTES
local L_GLOBALSTRINGS = addonTable.L_GLOBALSTRINGS

local featureOptions = {
	name = L_GLOBALSTRINGS["Tabs.Features"],
	handler = HelpMePlay,
	type = "group",
	args = {
	},
}
addonTable.featureOptions = featureOptions