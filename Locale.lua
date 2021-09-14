local addonName, addonTable = ...
local locale = GAME_LOCALE or GetLocale()

-- Identifies if the addon supports the player's language. If not, let's print a message to their chat box and give them a way to contact me.
local supportedLocales = {
	"enGB",
	"enUS",
}
local isLocaleSupported = false
for i = 1, #supportedLocales do
	if (supportedLocales[i] == locale) then
		isLocaleSupported = true
	end
end

-- The localized strings used by the addon.
local L = setmetatable({}, { __index = function(t, k)
	local v = tostring(k)
	rawset(t, k, v)
	return v
end })
if (locale == "enGB" or locale == "enUS") then
	-- Commands
	L["Slash HMP"]																= "/hmp"
	L["Abandon Command"]														= "abandon"
	-- Addon Messages															
	L["Locale Not Supported"]													= addonName .. " does NOT support " .. locale .. "! Please consider aiding in updating the addon to work for your language."
	-- Strings																	
	L["Abandon Command Description"]											= "Abandons all quests in the zone specified by the player."
	L["Available Commands"]														= "|cffFFFFFFAvailable Commands|r"
	L["Discord"]																= "Lightsky#0658"
	L["Red WARNING"]															= "|cffFF0000WARNING:|r "
	-- Options Panel Text
	L["CR Text"]																= "Crafted with |T135451:0|t by Lightsky"
	L["Adventure Maps"]															= "Adventure Maps"
	L["Dialog"]																	= "Dialog"
	L["Emotes"]																	= "Emotes"
	L["Garrison Tables"]														= "Garrison Tables"
	L["Mail"]																	= "Mail"
	L["Merchants"]																= "Merchants"
	L["Mount Training"]															= "Mount Training"
	L["Speech"]																	= "Speech"
	L["War Mode"]																= "War Mode"
	L["Accept/Complete Quests"]													= "Accept/Complete Quests"
	L["Threads of Fate"]														= "Threads of Fate"
	-- Options Panel Descriptions
	L["Adventure Maps Check Button"]											= "Automates the selection of zones and footholds for the Battle for Azeroth and Shadowlands adventure maps.\n\n|cffFFFFFFAlliance|r:\n|TInterface\\Buttons\\UI-SpellbookIcon-NextPage-Up:12|t |cffFFFFFFZones|r: Tiragarde Sound, Stormsong Valley, Drustvar\n|TInterface\\Buttons\\UI-SpellbookIcon-NextPage-Up:12|t |cffFFFFFFFootholds|r: Zuldazar, Nazmir, Vol'dun\n|cffFFFFFFHorde|r:\n|TInterface\\Buttons\\UI-SpellbookIcon-NextPage-Up:12|t |cffFFFFFFZones|r: Zuldazar, Nazmir, Vol'dun\n|TInterface\\Buttons\\UI-SpellbookIcon-NextPage-Up:12|t |cffFFFFFFFootholds|r: Stormsong Valley, Tiragarde Sound, Drustvar\n\n|cffFFFFFFShadowlands|r: Bastion, Maldraxxus, Ardenweald, Revendreth"
	L["Dialog Check Button"]													= "Automates the selection of dialog options when speaking with NPCs. This does NOT apply to all dialogs."
	L["Emotes Check Button"]													= "Automates emoting at specific NPCs.\n|cffFFFFFFExample|r: The runestones during the \"Repeat After Me\" quest in Maldraxxus."
	L["Garrison Tables Check Button"]											= "Automates the start of the first Garrison mission for both factions, as well as the plotting of the Barracks building for Level 1 Garrisons."
	L["Mail Check Button"]														= "Automates the collection of ONLY gold from your mailbox."
	L["Merchants Check Button"]													= "Automates the purchase of specific items from specific merchants.\n|cffFFFFFFExample|r: The [Bottle of Airspark] from Lanna Skyspark in Highmountain."
	L["Mount Training Check Button"]											= "Automates the purchase of mount training from trainers.\nThe player must have either double the cost of the training OR at least 300 more gold than the cost of the training."
	L["Speech Check Button"]													= "Automates interacting with specific NPC speech.\n|cffFFFFFFExample|r: The Playful Trickster during \"The Games We Play\" quest in Ardenweald."
	L["War Mode Check Button"]													= "Automates opting the player into War Mode when entering Orgrimmar or Stormwind City.\nThis only applies to players above level 20, but below 50."
	L["Accept/Complete Quests Check Button"]									= "Automates accepting and completing all quests in the game.\n|cffFFFFFFNote|r: This setting does NOT affect the automation for quest rewards."
	L["Threads of Fate Check Button"]											= "Automates the selection of Threads of Fate.\nChecking the box will opt the player into Threads of Fate, but leaving it unchecked will opt the player into Story Mode."
	-- Skill Lines																
	L["Riding"]																	= "Riding"
	-- Speech																	
	L["Playful Trickster: Praise"]												= "Not so much as a word of praise!"
	L["Playful Trickster: Cheer"]												= "The other spriggans were all cheering my name for days!"
	L["Playful Trickster: Dance"]												= "Dance with me!"
	L["Playful Trickster: Introduce"]											= "Introductions are an important part of first impressions!"
	L["Playful Trickster: Thank"]												= "Some ask permission, and always thank us for our trouble."
	L["Playful Trickster: Flex"]												= "How strong he must have been!"
	-- Map Names																
		-- Eastern Kingdoms														
	L["ARATHI HIGHLANDS"]														= "ARATHI HIGHLANDS"
	L["BADLANDS"] 																= "BADLANDS"
	L["BLASTED LANDS"]  														= "BLASTED LANDS"
	L["BURNING STEPPES"]  			            								= "BURNING STEPPES"
	L["DUN MOROGH"]  				            								= "DUN MOROGH"
	L["DUSKWOOD"] 					            								= "DUSKWOOD"
	L["EASTERN PLAGUELANDS"]  		            								= "EASTERN PLAGUELANDS"
	L["ELWYNN FOREST"] 				            								= "ELWYNN FOREST"
	L["EVERSONG WOODS"] 			            								= "EVERSONG WOODS"
	L["GHOSTLANDS"] 				            								= "GHOSTLANDS"
	L["HILLSBRAD FOOTHILLS"] 		            								= "HILLSBRAD FOOTHILLS"
	L["LOCH MODAN"] 				            								= "LOCH MODAN"
	L["NORTHERN STRANGLETHORN"] 	            								= "NORTHERN STRANGLETHORN"
	L["REDRIDGE MOUNTAINS"] 		            								= "REDRIDGE MOUNTAINS"
	L["SEARING GORGE"] 				            								= "SEARING GORGE"
	L["SILVERPINE FOREST"] 			            								= "SILVERPINE FOREST"
	L["THE CAPE OF STRANGLETHORN"] 	            								= "THE CAPE OF STRANGLETHORN"
	L["TIRISFAL GLADES"] 			            								= "TIRISFAL GLADES"
	L["WESTERN PLAGUELANDS"] 		            								= "WESTERN PLAGUELANDS"
	L["WESTFALL"] 					            								= "WESTFALL"
	L["WETLANDS"] 					            								= "WETLANDS"
		-- Kalimdor								
	L["ASHENVALE"]					            								= "ASHENVALE"
	L["AZSHARA"]					            								= "AZSHARA"
	L["DARKSHORE"]					            								= "DARKSHORE"
	L["DESOLACE"]					            								= "DESOLACE"
	L["DUROTAR"]					            								= "DUROTAR"
	L["DUSTWALLOW MARSH"]			            								= "DUSTWALLOW MARSH"
	L["FELWOOD"]					            								= "FELWOOD"
	L["FERALAS"]					            								= "FERALAS"
	L["MULGORE"]					            								= "MULGORE"
	L["NORTHERN BARRENS"]			            								= "NORTHERN BARRENS"
	L["SOUTHERN BARRENS"]			            								= "SOUTHERN BARRENS"
	L["STONETALON MOUNTAINS"] 		            								= "STONETALON MOUNTAINS"
	L["UN'GORO CRATER"]				            								= "UN'GORO CRATER"
	L["WINTERSPRING"]				            								= "WINTERSPRING"
		-- Outlands																
	L["BLADE'S EDGE MOUNTAINS"] 	            								= "BLADE'S EDGE MOUNTAINS"
	L["HELLFIRE PENINSULA"] 		            								= "HELLFIRE PENINSULA"
	L["NAGRAND (OUTLAND)"] 			            								= "NAGRAND (OUTLAND)"
	L["NETHERSTORM"] 				            								= "NETHERSTORM"
	L["SHADOWMOON VALLEY (OUTLAND)"]            								= "SHADOWMOON VALLEY (OUTLAND)"
	L["TEROKKAR FOREST"] 			            								= "TEROKKAR FOREST"
	L["ZANGARMARSH"] 				            								= "ZANGARMARSH"
		-- Northrend															
	L["BOREAN TUNDRA"]				            								= "BOREAN TUNDRA"
	L["DRAGONBLIGHT"]				            								= "DRAGONBLIGHT"
	L["GRIZZLY HILLS"]				            								= "GRIZZLY HILLS"
	L["HOWLING FJORD"]				            								= "HOWLING FJORD"
	L["ICECROWN"]					            								= "ICECROWN"
	L["SHOLAZAR BASIN"]				            								= "SHOLAZAR BASIN"
	L["THE STORM PEAKS"]			            								= "THE STORM PEAKS"
	L["ZUL'DRAK"]					            								= "ZUL'DRAK"
		-- Pandaria																
	L["DREAD WASTES"]				            								= "DREAD WASTES"
	L["KRASARANG WILDS"]			            								= "KRASARANG WILDS"
	L["KUN-LAI SUMMIT"]				            								= "KUN-LAI SUMMIT"
	L["THE JADE FOREST"]			            								= "THE JADE FOREST"
	L["TOWNLONG STEPPES"]			            								= "TOWNLONG STEPPES"
	L["VALE OF ETERNAL BLOSSOMS"] 	            								= "VALE OF ETERNAL BLOSSOMS"
	L["VALLEY OF THE FOUR WINDS"] 	            								= "VALLEY OF THE FOUR WINDS"
		-- Draenor  								
	L["FROSTFIRE RIDGE"]			            								= "FROSTFIRE RIDGE"
	L["GORGROND"]					            								= "GORGROND"
	L["NAGRAND"]					            								= "NAGRAND"
	L["SHADOWMOON VALLEY"]			            								= "SHADOWMOON VALLEY"
	L["SPIRES OF ARAK"]				            								= "SPIRES OF ARAK"
	L["TALADOR"]					            								= "TALADOR"
		-- Broken Isles															
	L["AZSUNA"]						            								= "AZSUNA"
	L["HELHEIM"]					            								= "HELHEIM"
	L["HIGHMOUNTAIN"] 				            								= "HIGHMOUNTAIN"
	L["STORMHEIM"]					            								= "STORMHEIM"
	L["SURAMAR"]					            								= "SURAMAR"
	L["VAL'SHARAH"]					            								= "VAL'SHARAH"
		-- Kul Tiras															
	L["DRUSTVAR"] 					            								= "DRUSTVAR"
	L["MECHAGON"] 					            								= "MECHAGON"
	L["NAZJATAR"] 					            								= "NAZJATAR"
	L["STORMSONG VALLEY"] 			            								= "STORMSONG VALLEY"
	L["TIRAGARDE SOUND"] 			            								= "TIRAGARDE SOUND"
		-- Zandalar																
	L["NAZMIR"] 					            								= "NAZMIR"
	L["VOL'DUN"] 					            								= "VOL'DUN"
	L["ZULDAZAR"] 					            								= "ZULDAZAR"
		-- Shadowlands															
	L["ARDENWEALD"] 				            								= "ARDENWEALD"
	L["BASTION"] 					            								= "BASTION"
	L["MALDRAXXUS"] 				            								= "MALDRAXXUS"
	L["REVENDRETH"] 				            								= "REVENDRETH"
	L["THE MAW"]                                								= "THE MAW"      
	-- Dialog
	L["Are you enjoying yourself?"]												= "Are you enjoying yourself?"
	L["Go hunt somewhere else!"]												= "Go hunt somewhere else!"
	L["There is no time left. Run!"]											= "There is no time left. Run!"
	L["Let's go!"]																= "Let's go!"
	L["I'm ready."]																= "I'm ready."
	L["Let's duel."]															= "Let's duel."
	L["I am ready."]															= "I am ready."
	L["Leave the Darkpens."]													= "Leave the Darkpens."
	L["Take us back to Boralus."]												= "Take us back to Boralus."
	L["Take us back to Zuldazar."]												= "Take us back to Zuldazar."
	L["<Reach inside and pull something out.>"] 								= "<Reach inside and pull something out.>"
	L["<Reach inside and pull out something that feels more like a building.>"] = "<Reach inside and pull out something that feels more like a building.>"
	L["Is there any way I can help?"]											= "Is there any way I can help?"
	L["O.K."]																	= "O.K."
	L["Is there anything you need?"]											= "Is there anything you need?"
	L["Very well. Let us fight."]												= "Very well. Let us fight."
	L["Au'narim claims you owe her anima."]										= "Au'narim claims you owe her anima."
	L["Begin pet battle."]														= "Begin pet battle."
	L["Let's do battle!"]														= "Let's do battle!"
	L["I'd like to heal and revive my battle pets."] 							= "I'd like to heal and revive my battle pets."
	L["Yes!"]																	= "Yes!"
	L["Quest"]																	= "Quest"
	L["I've heard this tale before..."]											= "I've heard this tale before..."
	L["Are you sure you want to skip the Broken Shore introduction?"]			= "Are you sure you want to skip the Broken Shore introduction?"
	L["D'kaan is coming with help."]											= "D'kaan is coming with help."
	L["Daelya Twilightsbane 1"]													= "What does the Light wish of me?"
	L["Daelya Twilightsbane 2"]													= "I will do my best to serve the Light. I swear to it."
	L["Herbert Gloomburst 1"]													= "I'll fight the harpies that come."
	L["Herbert Gloomburst 2"]													= "Herbert, do you have an ice mote I can use?"
	L["Warlord Breka Grimaxe 1"]												= "Let's get out of the citadel and figure out how to get back home."
	L["Warlord Breka Grimaxe 2"]												= "I know my way around Orgrimmar."
	L["Archmage Khadgar 1"]														= "FOR AZEROTH!"
	L["Archmage Khadgar 2"]														= "You are about to embark on a dangerous mission, and you may not be able to return immediately."
	L["Johnny Awesome 1"] 														= "Well, we are having some problems at the Sludge Fields, located northeast of here. Warden Stillwater could use your help."
	L["Johnny Awesome 2"]														= "That's all."
	L["Johnny Awesome 3"]														= "THAT'S ALL, JOHNNY AWESOME. TAKE IT OR LEAVE IT!"
	L["Kingslayer Orkus 1"] 													= "Um... Apparently there is some trouble at Southshore. Something about worgen insurgents. Maybe you could help with them?"
	L["Kingslayer Orkus 2"]														= "None."
	L["Kingslayer Orkus 3"]														= "Right, thanks. Just go ahead and head southeast. More south than east. Probably off the coast."
	L["Kingslayer Orkus 4"]														= "Your feet are touching the ground, Orkus."
	L["Dumass 1"] 																= "Maybe you should go take a nap or something."
	L["Dumass 2"] 																= "Wait a minute. It looks like something just came up."
	L["Bat Handler Maggotbreath 1"]												= "I need to take a bat to the Dawning Isles."
	L["Ambermill Dimensional Portal 1"]											= "<Use the Ambermill Dimensional Portal.>"
	L["Vanguard Battlemage 1"]													= "I must help Khadgar. Send me to the Blasted Lands!"
	L["Thaelin Darkanvil 1"]													= "Yes. I need you to help me operate that enormous tank."
	L["Zidormi 1"]																= "Can you show me what Tirisfal Glades was like before the Battle for Lordaeron?"
	L["Nathanos Blightcaller 1"]												= "I have heard this story before."
	L["Chromie 1"]																= "Select a timeline."
	L["Chromie 2"]																= "Select a different timeline."
	L["Nazgrim 1"]																= "Tell me what happened."
	L["Baros Alexston 1"]														= "We have everything we need. It's time to build the garrison."
	L["Assistant Brightstone 1"]												= "Time to get back to work."
	L["Shelly Hamby 1"]															= "Gather Shelly's report."
	L["Skaggit 1"]																= "Get the peons back to work."
	L["Senior Peon II 1"]														= "Gazlowe needs you."
	L["Sergeant Grimjaw 1"]														= "Prepare to battle the Gorens."
	L["All-Seeing Eye 1"]														= "Begin the compulsion of the All-Seeing Eye."
	L["Ariok 1"]																= "Khadgar has asked us to go distract the Eye of Kilrogg."
	L["Spiritwalker Ebonhorn 1"]												= "Tell me the Story of Huln."
	L["Spiritwalker Ebonhorn 2"]												= "Tell me more of Huln Highmountain."
	L["Snazzle Shinyfinder 1"]													= "Go find shiny!"
	L["Snazzle Shinyfinder 2"]													= "You keep one. I keep rest."
	L["Trytooth Hardchisel 1"]													= "You kill basilisk!"
	L["Trytooth Hardchisel 2"]													= "Best kill job me seen!"
	L["Trytooth Hardchisel 3"]													= "Give Trytooth the boot."
	L["Kindle Candlecrafter 1"]													= "Make big candle! Lots of wax!"
	L["Kindle Candlecrafter 2"]													= "Me think me have just the right touch..."
	L["Dug Digger 1"]															= "Dig rocks, find pretties!"
	L["Windmaster Julan 1"]														= "Take the Windmaster's Totem."
	L["Navarrogg 1"]															= "Let's get out of here!"
	L["Addie Fizzlebog 1"]														= "Let's go hunting!"
	L["Penelope Heathrow 1"]													= "It's safe now."
	L["Sirius Ebonwing 1"]														= "Excuse me..."
	L["Asha Ravensong 1"]														= "Arduen sent me. You're free."
	L["Cassiel Nightthorn 1"]													= "Be at peace."
	L["Tyrande Whisperwind 1"]													= "By my honor you will come to no harm, priestess."
	L["Tyrande Whisperwind 2"]													= "Yes, Tyrande."
	L["Keeper Remulos 1"]														= "Free Remulos from captivity."
	L["Hobart Grapplehammer 1"]													= "Your friends were all tortured and killed by witches."
	L["Hobart Grapplehammer 2"]													= "Sure."
	L["Huelo 1"]																= "Pull the harpoon free."
	L["Shadow Hunter Ty'jin 1"]													= "I'm ready to parley, Ty'jin."
	L["Boatswain Taryn 1"]														= "Got some new orders from the captain for you, boatswain."
	L["Quartermaster Killian 1"]												= "We're saying no to the Ashvane."
	L["Navigator Swink 1"]														= "Orders from the captain, sir."
	L["Princess Talanji 1"]														= "Take me to King Rastakhan."
	L["Cyrus Crestfall 1"]														= "<Shake his hand.>"
	L["7th Legion Magus 1"]														= "The local authority has given us permission to open portals here."
	L["Halford Wyrmbane 1"]														= "What's your plan, High Commander?"
	L["Captured Zandalari Troll 1"]												= "Tell us everything, Zandalari."
	L["Private James 1"]														= "Is there anything in your pockets?"
	L["Dungar Longdrink 1"]														= "Take me to Stormshield in Ashran."
	L["High Inquisitor Whitemane 1"]											= "Tell me what happened."
	L["Highlord Darion Mograine 1"]												= "Make it talk."
	L["Lady Jaina Proudmoore 1"]												= "Tell me about this place."
	L["Lady Jaina Proudmoore 2"]												= "Tell me more of the Jailer."
	L["Lady Jaina Proudmoore 3"]												= "What about the others who were taken?"
	L["Lady Jaina Proudmoore 4"]												= "<Lie low and observe.>"
	L["Tal-Inara 1"]															= "Show me how I can help the Shadowlands."
	L["Highlord Bolvar Fordragon 1"]											= "Skip ahead to finish the Torghast chapter and have Torghast, Ve'nari, and the Runecarver unlocked."
	L["Highlord Bolvar Fordragon 2"]											= "Skip ahead to Korthia."
	L["Polemarch Adrestes 1"]													= "<Ask Adrestes what happened in Elysian Hold.>"
	L["Voitha 1"]																= "I will retrieve the scrolls."
	L["Nemea 1"]																= "I choose the larion."
	L["Nemea 2"]																= "You will not be able to change your decision on this character."
	L["Pelodis 1"]																= "Everything is in place for the repair."
	L["Helpful Steward 1"]														= "Can you help with this problem?"
	L["Helpful Steward 2"]														= "Can you help me with something?"
	L["Aspirant Leda 1"]														= "Do you have \"Worlds Beyond Counting\"?"
	L["Aspirant Ikaran 1"]														= "Do you have \"The Infinite Treatises\"?"
	L["Trapped Caretaker 1"]													= "I've cleared a path for you. You should leave."
	L["Rencissa the Dynamo 1"]													= "biggest rock"
	L["Scrapper Minoire 1"]														= "Here are the enhancers you wanted."
	L["Grimshadow 1"]															= "<Ride Grimshadow.>"
	L["Marcel Mullby 1"]														= "I have some bloodtusk skulls for you."
	L["Arena Spectator 1"]														= "Au'narim claims you owe her anima."
	L["Khaliiq 1"]																= "Hide me in the shadows, Khaliiq."
	L["Specialist Entra 1"]														= "What should I do?"
	L["Ta'eran 1"]																= "Tell me about this opportunity."
	L["Attendant Sparkledew 1"]													= "Take me to the Queen's audience chamber, please."
	L["Master Sha'lor 1"]														= "I need a flute."
	L["Attendant Shimmerwing 1"]												= "I would like to leave the Queen's audience chamber, please."
	L["Silkstrider Caretaker 1"]												= "You're safe now."
	L["Lady Moonberry 1"]														= "Lead on."
	L["Chancellor Codrin 1"]													= "You stand accused of conspiring to overthrow The Countess."
	L["The Countess 1"]															= "House Darkvein"
	L["The Countess 2"]															= "<Deliver Prince Renathal's invitation.>"
	L["The Curator 1"]															= "What happened to the Medallion of Avarice?"
	L["Guard Captain Elizabeta 1"]												= "The Curator sent me. I'm looking for Watcher Emil."
	L["Cobwobble 1"]															= "What are you all doing?"
	L["Slobwobble 1"]															= "Where does the Taskmaster keep the sinstones?"
	L["Dobwobble 1"]															= "Why are the ones with scribbles interesting?"
	L["Courier Araak 1"]														= "Dimwiddle sent me."
	L["Avowed Ritualist 1"]														= "I have a soul for you."
	L["Lorewalker Cho 1"]														= "What are you waiting for? Let's go investigate!"
	L["Lorewalker Cho 2"]														= "Go ahead and turn this thing on."
	L["Scout Captain Elsia 1"]													= "Here are the explosives, Elsia."
	L["Taoshi 1"]																= "Alright. Let's go."
	L["Taoshi 2"]																= "I'm with you. Let's break into that shipyard!"
	L["Garona Halforcen 1"]														= "You have my aid. <Help Garona up>"
	L["Altar of the Daredevil 1"]												= "Put on the Faceless Mask of the Daredevil."
	L["Altar of the Dark Imagination 1"]										= "Put on the Faceless Mask of the Dark Imagination."
	L["Altar of the Pained 1"]													= "Put on the Faceless Mask of the Pained."
	L["Altar of the Burned Bridge 1"]											= "Put on the Faceless Mask of the Burned Bridge."
	L["Altar of the Long Night 1"]												= "Put on the Faceless Mask of the Long Night."
end

if (isLocaleSupported == false) then
	print(L["Red WARNING"] .. L["Locale Not Supported"] .. " @" .. L["Discord"])
end

addonTable.L = L