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
	L["Dialog Command"]															= "dialog"
	L["Quest Command"]															= "quest"
	-- Command Shortcuts
	L["Q"]																		= "q"
	-- Addon Messages															
	L["Locale Not Supported"]													= addonName .. " does NOT support " .. locale .. "! Please consider aiding in updating the addon to work for your language."
	-- Strings																	
	L["Abandon Command Description"]											= "Abandons all quests in the zone specified by the player."
	L["Colored Addon Name"]														= "|cff00FFFF"..addonName.."|r"
	L["Available Commands"]														= "|cffFFFFFFAvailable Commands|r"
	L["Discord"]																= "Lightsky#0658"
	L["Red WARNING"]															= "|cffFF0000WARNING:|r "
	L["Open Settings"]															= "Open Settings"
	L["Do you really want to abandon all quests?"]								= "|cff00FFFF"..addonName.."|r\n".."Do you really want to abandon all quests?"
	L["Yes"]																	= "Yes"
	L["No"]																		= "No"
	L["Box Of Many Things Purchase Text"]										= "Purchase the following talent: "
	L["Box Of Many Things Not Enough Text"]										= "You need more |cff0070ddTower Knowledge|r! Amount Needed: "
	L["Level Congrats Text"]													= "Congratulations on reaching level %c! Suggested talent: %s"
	-- Symbols
	L["Red X Raid Target"]														= "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_7:0|t"
	-- Options Panel Text
	L["CR Text"]																= "Crafted with |T135451:0|t by Lightsky"
	L["Adventure Maps"]															= "Adventure Maps"
	L["Dialog"]																	= "Dialog"
	L["Emotes"]																	= "Emotes"
	L["Garrison Tables"]														= "Garrison Tables"
	L["Mail"]																	= "Mail"
	L["Merchants"]																= "Merchants"
	L["Mount Training"]															= "Trainers"
	L["Speech"]																	= "Speech"
	L["War Mode"]																= "War Mode"
	L["Accept/Complete Quests"]													= "Quests"
	L["Quest Rewards"]															= "Quest Rewards"
	L["Threads of Fate"]														= "Threads of Fate"
	L["Chromie Time"]															= "Chromie Time"
	L["Current Expansion"]														= "Current Expansion"
	L["Torghast Powers"]														= "Torghast Powers"
	L["Notes"]																	= "Notes"
	-- Options Panel Descriptions
	L["Adventure Maps Check Button"]											= "Automates the Hero's Call Board and the selection of zones and footholds\nfor the Battle for Azeroth and Shadowlands adventure maps.\n\n|cffFFFFFFHero's Call Board|r: Tanaan Jungle\n\n|cffFFFFFFAlliance|r:\n|TInterface\\Buttons\\UI-SpellbookIcon-NextPage-Up:12|t |cffFFFFFFZones|r: Tiragarde Sound, Stormsong Valley, Drustvar\n|TInterface\\Buttons\\UI-SpellbookIcon-NextPage-Up:12|t |cffFFFFFFFootholds|r: Zuldazar, Nazmir, Vol'dun\n|cffFFFFFFHorde|r:\n|TInterface\\Buttons\\UI-SpellbookIcon-NextPage-Up:12|t |cffFFFFFFZones|r: Zuldazar, Nazmir, Vol'dun\n|TInterface\\Buttons\\UI-SpellbookIcon-NextPage-Up:12|t |cffFFFFFFFootholds|r: Stormsong Valley, Tiragarde Sound, Drustvar\n\n|cffFFFFFFShadowlands|r: Bastion, Maldraxxus, Ardenweald, Revendreth"
	L["Dialog Check Button"]													= "Automates the selection of dialog options when speaking with NPCs.\nThis does |cffFFFFFFNOT|r apply to all dialogs.\nUse the |cffFFFFFF/dialog|r command to add your own automation."
	L["Emotes Check Button"]													= "Automates emoting at specific NPCs."
	L["Garrison Tables Check Button"]											= "Automates the start of the first Garrison mission for both factions, as well as\nthe plotting of the Barracks building for Level 1 Garrisons.\nGorgrond, Talador, and Spires of Arak outposts are auto selected.\n\nIf checked:\n\n|cffFFFFFFGorgrond|r: Sparring Arena\n|cffFFFFFFTalador|r: Arsenal\n|cffFFFFFFSpires of Arak|r: Brewery"
	L["Mail Check Button"]														= "Automates the collection of ONLY gold from your mailbox."
	L["Merchants Check Button"]													= "Automates the purchase of specific items from merchants, as well\nas automatic repairs."
	L["Trainers Check Button"]													= "Automates the purchase of skills from trainers.\nThe player must have either double the cost of the\nskill OR at least 300 more gold than the cost of the\nskill."
	L["Speech Check Button"]													= "Automates interacting with specific NPC speech.\nThis setting controls the glow effect on vehicle quests\nlike \"We'll Make an Aspirant Out of You\" in Bastion."
	L["War Mode Check Button"]													= "Automates opting the player into War Mode when entering Orgrimmar or Stormwind City.\nThis only applies to players above level 20, but below 50."
	L["Accept/Complete Quests Check Button"]									= "Automates accepting and completing quests."
	L["Quest Rewards Check Button"]												= "Automates the selection of quest rewards.\nThe selection is based on what sells for the most."
	L["Threads of Fate Check Button"]											= "Automates the selection of Threads of Fate.\nChecking the box will opt the player into Threads of Fate,\nbut leaving it unchecked will opt the player into Story Mode."
	L["Chromie Time EditBox"]													= "Enter one of the numeric values to automate the\nexpansion to select for Chromie Time.\n\n|cffFFFFFF0|r: Battle for Azeroth (Current Timeline)\n|cffFFFFFF5|r: The Cataclysm (Classic)\n|cffFFFFFF6|r: The Burning Crusade\n|cffFFFFFF7|r: Wrath of the Lich King\n|cffFFFFFF8|r: Mists of Pandaria\n|cffFFFFFF9|r: Warlords of Draenor\n|cffFFFFFF10|r: Legion"
	L["Torghast Powers Check Button"]											= "Automates the selection of Torghast Powers. The powers are based\non a priority list.\nThe chosen power is recorded to the chat window."
	L["Notes Check Button"]														= "Adds notes to select creatures and objects.\nThis setting also controls achievement criteria in tooltips."
	-- Speech Monsters
	L["Al'dalil"]																= "Al'dalil"
	L["Playful Trickster"]														= "Playful Trickster"
	L["Trainer Ikaros"]															= "Trainer Ikaros"
	-- Speech																	
	L["Playful Trickster: Praise"]												= "Not so much as a word of praise!"
	L["Playful Trickster: Cheer"]												= "The other spriggans were all cheering my name for days!"
	L["Playful Trickster: Dance"]												= "Dance with me!"
	L["Playful Trickster: Introduce"]											= "Introductions are an important part of first impressions!"
	L["Playful Trickster: Thank"]												= "Some ask permission, and always thank us for our trouble."
	L["Playful Trickster: Flex"]												= "How strong he must have been!"
	L["Al'dalil: Buttons 1"]													= "Buttons! Quickly, the buttons!"
	L["Al'dalil: Buttons 2"]													= "Start pressing buttons!"
	L["Al'dalil: Lever 1"]														= "Use the lever, Maw Walker!"
	L["Al'dalil: Lever 2"]														= "Pull on one of the levers!"
	L["Al'dalil: Bonk 1"]														= "A sharp strike to the head always works!"
	L["Al'dalil: Bonk 2"]														= "There are no operating instructions! Try hitting it!"
	L["Trainer Ikaros: Dodge"]													= "Dodge"
	L["Trainer Ikaros: Strike"]													= "Strike"
	L["Trainer Ikaros: Jab"]													= "Jab"
	L["Trainer Ikaros: Sweep"]													= "Sweep"
	L["Trainer Ikaros: Kick"]													= "Kick"
	L["Trainer Ikaros: Parry"]													= "Parry"
	-- Raid Boss Whispers (Event)
	L["Taloned Flayedwing: Praise"]												= "The flayedwing is flying smoothly, praise them!"
	L["Taloned Flayedwing: Scared"]												= "The flayedwing is scared, soothe it with gentle pats!"
	L["Taloned Flayedwing: Shake"]												= "The flayedwing is trying to shake you off, hold on tight!"
	-- Map Names
	L["Torghast"]																= "Torghast"
	-- Mouseover Target Notes
	L["Note: Exposed Boggart"]													= "This is a BOGGART!"
	L["Note: Gatamatos"]														= "CLICK ME!"
	L["Note: Torghast Lever"]													= "From left to right, click in this order:\n|cffFFFFFF1, 2, 1, 3, 1, 2, 1, 4, 1, 2, 1, 3, 1, 2, 1|r"
	-- Dialog
	L["Are you enjoying yourself?"]												= "Are you enjoying yourself?"
	L["Go hunt somewhere else!"]												= "Go hunt somewhere else!"
	L["There is no time left. Run!"]											= "There is no time left. Run!"
	L["Let's go!"]																= "Let's go!"
	L["I'm ready."]																= "I'm ready."
	L["Let's duel."]															= "Let's duel."
	L["I am ready."]															= "I am ready."
	L["I am ready to go."]														= "I am ready to go."
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
	L["The Lady of the Falls wanted to make sure you were safe."]				= "The Lady of the Falls wanted to make sure you were safe."
	L["<Request tithe>"]														= "<Request tithe>"
	L["<Present Lajos's invitation>"]											= "<Present Lajos's invitation>"
	L["I know my way around the Sanctum."]										= "I know my way around the Sanctum."
	L["Are you sure?"]															= "Are you sure?"
	L["What can you tell me about Cartel So?"]									= "What can you tell me about Cartel So?"
	L["Begin pet battle."]														= "Begin pet battle."
	L["Let's do battle!"]														= "Let's do battle!"
	L["Let's do it!"]															= "Let's do it!"
	L["Let's rumble!"]															= "Let's rumble!"
	L["Come at me!"]															= "Come at me!"
	L["You're going down!"]														= "You're going down!"
	L["Prepare yourself!"]														= "Prepare yourself!"
	L["Think you can take me in a pet battle?"]									= "Think you can take me in a pet battle?"
	L["I'd like to heal and revive my battle pets."] 							= "I'd like to heal and revive my battle pets."
	L["A small fee for supplies is required."] 									= "A small fee for supplies is required."
	L["Let's do this!"]															= "Let's do this!"
	L["Another challenge?"]														= "Another challenge?"
	L["Yes, I will help."]														= "Yes, I will help."
	L["I will free you."]														= "I will free you."
	L["I will assist you."]														= "I will assist you."
	L["Let's ride."]															= "Let's ride."
	L["The forces of Mueh'zala have invaded Ardenweald."]						= "The forces of Mueh'zala have invaded Ardenweald."
	L["Evacuate, now!"]															= "Evacuate, now!"
	L["Yes!"]																	= "Yes!"
	L["Quest"]																	= "Quest"
	L["Show me my Renown."]														= "Show me my Renown."
	L["Show me the Sanctum."]													= "Show me the Sanctum."
	L["Very well. Let us fight."]												= "Very well. Let us fight."
	L["Maldraxxus needs your service. Will you fight?"]							= "Maldraxxus needs your service. Will you fight?"
	L["I have heard this tale before."]											= "I have heard this tale before."
	L["I've heard this tale before..."]											= "I've heard this tale before..."
	L["Are you sure you want to skip the Broken Shore introduction?"]			= "Are you sure you want to skip the Broken Shore introduction?"
	L["I would like you to have the supplies."]									= "I would like you to have the supplies."
	L["Maybe a couple copper will loosen your tongue."]							= "Maybe a couple copper will loosen your tongue."
	L["Are you sure you want to give this hobo money?"]							= "Are you sure you want to give this hobo money?"
	L["I need a ride."]															= "I need a ride."
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
	L["Zidormi 2"]																= "Can you show me what Darkshore was like before the battle?"
	L["Zidormi 3"]																= "Can you return me to the present time?"
	L["Zidormi 4"]																= "Show me the Blasted Lands before the invasion."
	L["Zidormi 5"]																= "Take me back to the present."
	L["Zidormi 6"]																= "Can you show me what Silithus was like before the Wound in the World?"
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
	L["Highlord Darion Mograine 1"]												= "Make it talk."
	L["Lady Jaina Proudmoore 1"]												= "Tell me about this place."
	L["Lady Jaina Proudmoore 2"]												= "Tell me more of the Jailer."
	L["Lady Jaina Proudmoore 3"]												= "What about the others who were taken?"
	L["Lady Jaina Proudmoore 4"]												= "<Lie low and observe.>"
	L["Shandris Feathermoon 1"]													= "We should be able to find Tyrande if we follow the trail of corpses."
	L["Shandris Feathermoon 2"]													= "I can bring you and these souls to Ardenweald."
	L["Tal-Inara 1"]															= "Show me how I can help the Shadowlands."
	L["Highlord Bolvar Fordragon 1"]											= "Skip ahead to finish the Torghast chapter and have Torghast, Ve'nari, and the Runecarver unlocked."
	L["Highlord Bolvar Fordragon 2"]											= "Skip ahead to Korthia."
	L["Ve'rayn 1"]																= "Yes, the Jailer's forces have grown more powerful since Denathrius's betrayal."
	L["Ve'rayn 2"]																= "I'm sorry, what did you say this was for?"
	L["Ve'rayn 3"]																= "Who is Ve'nari?"
	L["Ve'rayn 4"]																= "I have never met anyone named Ve'nari."
	L["Ve'nari 1"]																= "What are your ground rules for working together?"
	L["Ve'nari 2"]																= "Deal. I will tell no one about you in exchange for the Soulkeeper."
	L["Ve'nari 3"]																= "How do I enter Torghast?"
	L["Runecarver 1"]															= "Who are you?"
	L["Runecarver 2"]															= "Let's get you free!"
	L["Wayfinder 1"]															= "Wayfinder"
	L["Polemarch Adrestes 1"]													= "<Ask Adrestes what happened in Elysian Hold.>"
	L["Voitha 1"]																= "I will retrieve the scrolls."
	L["Nemea 1"]																= "I choose the larion."
	L["Nemea 2"]																= "You will not be able to change your decision on this character."
	L["Pelodis 1"]																= "Everything is in place for the repair."
	L["Helpful Steward 1"]														= "Can you help with this problem?"
	L["Helpful Steward 2"]														= "Can you help me with something?"
	L["Ysera 1"]																= "Let us hear Thiernax's plan."
	L["Aspirant Leda 1"]														= "Do you have \"Worlds Beyond Counting\"?"
	L["Aspirant Ikaran 1"]														= "Do you have \"The Infinite Treatises\"?"
	L["Trapped Caretaker 1"]													= "I've cleared a path for you. You should leave."
	L["Rencissa the Dynamo 1"]													= "biggest rock"
	L["Scrapper Minoire 1"]														= "Here are the enhancers you wanted."
	L["Grimshadow 1"]															= "<Ride Grimshadow.>"
	L["Marcel Mullby 1"]														= "I have some bloodtusk skulls for you."
	L["Khaliiq 1"]																= "Hide me in the shadows, Khaliiq."
	L["Specialist Entra 1"]														= "What should I do?"
	L["Ta'eran 1"]																= "Tell me about this opportunity."
	L["Attendant Sparkledew 1"]													= "Take me to the Queen's audience chamber, please."
	L["Master Sha'lor 1"]														= "I need a flute."
	L["Attendant Shimmerwing 1"]												= "I would like to leave the Queen's audience chamber, please."
	L["Silkstrider Caretaker 1"]												= "You're safe now."
	L["Lady Moonberry 1"]														= "Lead on."
	L["Lady Moonberry 2"]														= "Keep us hidden while we search for our friends."
	L["Lady Moonberry 3"]														= "Do you know anything about curses?"
	L["Lady Moonberry 4"]														= "Let's get out of here."
	L["Lady Moonberry 5"]														= "I am ready, Lady Moonberry."
	L["Ara'lon 1"]																= "I am looking for Kivarr."
	L["Vesperbloom 1"]															= "<Explain why Lady Moonberry sent you to get a Secret Never Spoken.>"
	L["Vesperbloom 2"]															= "I was able to recover your book."
	L["Dapperdew 1"]															= "If you insist. The show must go on!"
	L["Cortinarius 1"]															= "Then let us face them."
	L["Chancellor Codrin 1"]													= "You stand accused of conspiring to overthrow The Countess."
	L["The Countess 1"]															= "House Darkvein"
	L["The Countess 2"]															= "<Deliver Prince Renathal's invitation.>"
	L["The Curator 1"]															= "What happened to the Medallion of Avarice?"
	L["The Accuser 1"]															= "I'm ready. Begin the ritual."
	L["Guard Captain Elizabeta 1"]												= "The Curator sent me. I'm looking for Watcher Emil."
	L["Where does the Taskmaster keep the sinstones?"]							= "Where does the Taskmaster keep the sinstones?"
	L["What are you all doing?"]												= "What are you all doing?"
	L["Why are the ones with scribbles interesting?"]							= "Why are the ones with scribbles interesting?"
	L["Courier Araak 1"]														= "Dimwiddle sent me."
	L["Courier Araak 2"]														= "We are ready. Please tell the Taskmaster the Maw Walker is here."
	L["Avowed Ritualist 1"]														= "I have a soul for you."
	L["Partially-Infused Soul Remnant 1"]										= "Free the Soul Remnant."
	L["Project Lead Allen 1"]													= "I will assist you."
	L["Fatescribe Roh-Tahl 1"]													= "I am ready to choose my fate in the Shadowlands."
	L["Sparring Aspirant 1"]													= "Will you spar with me?"
	L["Sparring Aspirant 2"]													= "I would like to challenge both of you to a spar."
	L["Lord Herne 1"]															= "I will join the hunt, Lord Herne."
	L["Lord Herne 2"]															= "<Explain what happened in the Gardens of Night and the spriggan's curse.>"
	L["Lord Herne 3"]															= "Is there such a tracker among the Wild Hunt?"
	L["Bwonsamdi 1"]															= "Return me to Ardenweald."
	L["Bwonsamdi 2"]															= "I'm ready to begin the ritual to find out what Mueh'zala was hiding."
	L["Spirit of Vol'jin 1"]													= "Let's head to the Maw and find these missing spirits."
	L["Spirit of Vol'jin 2"]													= "I'm ready to receive your anima to protect myself from the death barrier."
	L["Ashamane 1"]																= "I will slay the monsters that have been torturing you."
	L["Ashamane 2"]																= "I can take you back to Ardenweald if you go inside the soulkeeper crystal."
	L["Winter Queen 1"]															= "I am here on behalf of Bwonsamdi. He needs our help."
	L["Winter Queen 2"]															= "Winter Queen, I bring missing spirits to return to Ardenweald."
	L["Winter Queen 3"]															= "Ara'lon has fallen. The Drust march on the Grove of Awakening."
	L["Winter Queen 4"]															= "What are your orders?"
	L["Mask of Bwonsamdi 1"]													= "What will you do about Mueh'zala?"
	L["Zayhad, The Builder 1"]													= "I'll take this acorn and recover memories within Heartwood Grove."
	L["Zayhad, The Builder 2"]													= "Here are the joyful memories I collected from Heartwood Grove."
	L["Taloned Flayedwing 1"]													= "<Ride the flayedwing back to the Wrangler Pit.>"
	L["Treasure Guardian 1"]													= "How can I prove to you that I'm in House Grinchin?"
	L["Treasure Guardian 2"]													= "<Show the House Grinchin Ring.>"
	L["Orator Kloe 1"]															= "I will find the missing Vulpin."
	L["Gubbins 1"]																= "I will take a parasol."
	L["Xandria 1"]																= "Let's fly, Xandria."
	L["Prince Renathal 1"]														= "How can I help the assault, Prince Renathal?"
	L["Thiernax 1"]																= "<Explain the situation and request help.>"
	L["Thiernax 2"]																= "I do hear something..."
	L["Aspirant Thetes 1"]														= "I will accompany you."
	L["Alexstrasza, the Life-Binder 1"]											= "<Explain the situation to Alexstrasza and request a Token of Lost Love.>"
	L["Archivist Roh-Suir 1"]													= "I found more relics we can use for our cataloged research."
	L["Grand Artificer Romuul 1"]												= "Take me to the surface."
	L["Little Tommy Newcomer 1"]												= "Think you can take me in a pet battle?"
	L["Master Li 1"]															= "I'd like to enter the Celestial Tournament."
	L["Marcus \"Bagman\" Brown 1"]												= "Take me into the Deadmines."
	L["Muyani 1"]																= "Take me into the Wailing Caverns."
	L["Micro Zoox 1"]															= "I'm ready, send me into Gnomeregan!"
	L["Sean Wilkers 1"]															= "I'm ready, send me into Stratholme!"
	L["Plagued Critters 1"]														= "Extermination Time!"
	L["Door Control Console 1"]													= "<Pull Random Levers>"
	L["Torben Zapblast 1"]														= "Send me to the surface, Torben."
	L["Mountaineer Dunstan 1"]													= "Captain Tharran wants you to deploy your remote observation bots and withdraw to Kharanos."
	L["Mountaineer Lewin 1"]													= "Captain Tharran wants you to deploy your remote observation bots and withdraw to Kharanos."
	L["Mountaineer Valgrum 1"]													= "Captain Tharran wants you to deploy your remote observation bots and withdraw to Kharanos."
	L["Gryth Thurden 1"]														= "Mountaineer Barleybrew said you could help me get to Loch Modan."
	L["Madari 1"]																= "You look like an able fisherman, do you think you can help us out?"
	L["Marshal Dughan 1"]														= "I wish to ride the Stormwind charger, sir."
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
	-- Creature Names
	L["Sylla"]																	= "Sylla"
	L["Thenia"]																	= "Thenia"
	L["Stratios"]																= "Stratios"
	L["Zolla"]																	= "Zolla"
	L["Rotgut"]																	= "Rotgut"
	L["Dundley Stickyfingers"]													= "Dundley Stickyfingers"
	L["Caregiver Maximillian"]													= "Caregiver Maximillian"
	L["Faryl"]																	= "Faryl"
	L["Glitterdust"]															= "Glitterdust"
	L["Addius the Tormentor"]													= "Addius the Tormentor"
	L["Eyegor"]																	= "Eyegor"
	L["Lady of the Falls"]														= "Lady of the Falls"
	L["Elder Gwenna"]															= "Elder Gwenna"
	L["Sorcha"]																	= "Sorcha"
	L["Gormsmith Cavina"]														= "Gormsmith Cavina"
	L["Groonoomcrooek"]															= "Groonoomcrooek"
	L["Elder Finnan"]															= "Elder Finnan"
	L["Lady of the Falls"]														= "Lady of the Falls"
	L["Lady of the Falls"]														= "Lady of the Falls"
	L["Lady of the Falls"]														= "Lady of the Falls"
end

if (isLocaleSupported == false) then
	print(L["Red WARNING"] .. L["Locale Not Supported"] .. " @" .. L["Discord"])
end

addonTable.L = L