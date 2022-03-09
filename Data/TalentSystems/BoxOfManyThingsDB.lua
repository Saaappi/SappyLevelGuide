local addonName, addonTable = ...
local e = CreateFrame("Frame")
local L_DIALOG = addonTable.L_DIALOG
local L_NOTES = addonTable.L_NOTES
local L_GLOBALSTRINGS = addonTable.L_GLOBALSTRINGS
local BOXOFMANYTHINGS = {
	-- Tower Knowledge: 1904
	1783, -- Blessing of the Ancients (Rank 1) (20 TK)
	1783, -- Blessing of the Ancients (Rank 2) (80 TK)
	1784, -- Freed from Torment (Rank 1) (40 TK)
	1794, -- Efficient Looter (Rank 1) (60 TK)
	1785, -- Empowered Perseverence (Rank 1) (40 TK)
	1787, -- Empowered Swiftness (Rank 1) (20 TK)
	1788, -- The Adamant Vaults (Rank 1) (100 TK)
	1783, -- Blessing of the Ancients (Rank 3) (200 TK)
	1789, -- Enduring Souls (Rank 1) (50 TK)
	1784, -- Freed from Torment (Rank 2) (200 TK)
	1785, -- Empowered Perseverence (Rank 2) (100 TK)
	1787, -- Empowered Swiftness (Rank 2) (60 TK)
	1790, -- Good Reflexes (Rank 1) (30 TK)
	1863, -- Elite Slayer (Rank 1) (40 TK)
	1861, -- Unflinching (Rank 1) (20 TK)
	1865, -- Anima Plunderer (Rank 1) (50 TK)
	1861, -- Unflinching (Rank 2) (100 TK)
	1861, -- Unflinching (Rank 3) (150 TK)
	1790, -- Good Reflexes (Rank 2) (80 TK)
	1786, -- Inexplicable Power (Rank 1) (20 TK)
	1786, -- Inexplicable Power (Rank 2) (40 TK)
	1865, -- Anima Plunderer (Rank 2) (200 TK)
	1864, -- Meddle With Fate (Rank 1) (40 TK)
	1878, -- Empowered Nova (Rank 1) (250 TK)
	1864, -- Meddle With Fate (Rank 2) (80 TK)
	1864, -- Meddle With Fate (Rank 3) (150 TK)
	1786, -- Inexplicable Power (Rank 3) (70 TK)
	1786, -- Inexplicable Power (Rank 4) (100 TK)
	1786, -- Inexplicable Power (Rank 5) (150 TK)
	1792, -- Discovered Cache (Rank 1) (20 TK)
	1792, -- Discovered Cache (Rank 2) (50 TK)
	1792, -- Discovered Cache (Rank 3) (80 TK)
	1793, -- Undeterred (Rank 1) (20 TK)
	1793, -- Undeterred (Rank 2) (40 TK)
	1793, -- Undeterred (Rank 3) (70 TK)
	1791, -- Death Denied (Rank 1) (20 TK)
	1791, -- Death Denied (Rank 2) (40 TK)
	1791, -- Death Denied (Rank 2) (70 TK)
	1793, -- Undeterred (Rank 4) (100 TK)
	1793, -- Undeterred (Rank 5) (150 TK)
}

addonTable.BOXOFMANYTHINGS = BOXOFMANYTHINGS