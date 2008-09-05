--[[------------------------------------------------------------
	xxXX Translations for Diplomancer
	Contributed by YOURNAME < CONTACT INFO >
	Last updated DD/MM/YY
--------------------------------------------------------------]]

if GetLocale() ~= "xxXX" then return end

--[[-- General translations ----------------------------------]]

local L = {}

L["Automatic zone-based faction watch"] = ""
L["Now watching %s."] = ""

L["/dm"] = ""
L["Use /diplomancer or /dm with the following commands:"] = ""

L["default"] = ""
L["reset"] = ""
L["none"] = ""
L["set your default faction"] = ""
L["Default faction reset to racial faction"] = ""
L["Default faction set to \"%s\"."] = ""
L["Could not find a faction matching \"%s\"."] = ""
L["Default faction currently set to \"%s\"."] = ""

L["exalted"] = ""
L["ignore factions you're already Exalted with"] = ""
L["Now ignoring factions you're already Exalted with."] = ""
L["No longer ignoring factions you're already Exalted with."] = ""

L["verbose"] = ""
L["print a message when changing watched factions"] = ""
L["Now printing messages when changing watched factions."] = ""
L["No longer printing messages when changing watched factions."] = ""

--[[-- Subzone translations ---------------------------------]]

local Z = {}

-- Azshara
Z["Bay of Storms"] = ""
Z["Timbermaw Hold"] = ""
Z["Ursolan"] = ""

-- Blade's Edge Mountains
Z["Evergrove"] = ""
Z["Forge Camp: Terror"] = ""
Z["Forge Camp: Wrath"] = ""
Z["Ogri'la"] = ""
Z["Shartuul's Transporter"] = ""
Z["Vortex Pinnacle"] = ""

-- Borean Tundra
Z["Amber Ledge"] = ""
Z["D.E.H.T.A. Encampment"] = ""
Z["Tauna'le Village"] = ""
Z["Transitus Shield"] = ""
Z["Unu'pe"] = ""
Z["Valiance Keep"] = ""

-- Crystalsong Forest
Z["Dalaran"] = ""

-- Dalaran
Z["Sunreaver's Sanctuary"] = ""
Z["The Silver Enclave"] = ""

-- Dragonblight
Z["Agmar's Hammer"] = ""
Z["Dragon's Fall"] = ""
Z["Moa'ki Harbor"] = ""
Z["Venomspite"] = ""

-- Durotar
Z["Sen'jin Village"] = ""

-- Eastern Plaguelands
Z["Acherus: The Ebon Hold"] = ""

-- Felwood
Z["Deadwood Village"] = ""
Z["Felpaw Village"] = ""

-- Hellfire Peninsula
Z["Cenarion Post"] = ""
Z["Mag'har Grounds"] = ""
Z["Mag'har Post"] = ""
Z["Temple of Telhamat"]	= ""
Z["Throne of Kil'jaeden"] = ""

-- Howling Fjord
Z["Camp Winterhoof"] = ""
Z["Kamagua"] = ""

-- Nagrand
Z["Aeris Landing"] = ""
Z["Oshu'gun"] = ""
Z["Spirit Fields"] = ""

-- Netherstorm
Z["Netherwing Ledge"] = ""
Z["Tempest Keep"] = ""

-- Searing Gorge
Z["Thorium Point"] = ""

-- Shadowmoon Valley
Z["Altar of Sha'tar"] = ""
Z["Netherwing Field"] = ""
Z["Sanctum of the Stars"] = ""
Z["Warden's Cage"] = ""

-- Shattrath City
Z["Aldor Rise"] = ""
Z["Lower City"] = ""
Z["Scryer's Tier"] = ""
Z["Shrine of Unending Light"] = ""
Z["The Seer's Library"] = ""

-- Stranglethorn Vale
Z["Booty Bay"] = ""
Z["Salty Sailor Tavern"] = ""
Z["Yojamba Isle"] = ""
Z["Zul'Gurub"] = ""

-- Tanaris
Z["Caverns of Time"] = ""

-- The Barrens
Z["Ratchet"] = ""

-- Terrokar Forest
Z["Blackwind Lake"] = ""
Z["Blackwind Landing"] = ""
Z["Blackwind Valley"] = ""
Z["Lake Ere'nom"] = ""
Z["Lower Veil Shil'ak"] = ""
Z["Mana Tombs"] = ""
Z["Skettis"] = ""
Z["Terokk's Rest"] = ""
Z["Upper Veil Shil'ak"] = ""
Z["Veil Ala'rak"] = ""
Z["Veil Harr'ik"] = ""

-- Tirisfal Glades
Z["The Bulwark"] = ""

-- Winterspring
Z["Frostfire Hot Springs"] = ""
Z["Frostsaber Rock"] = ""
Z["Timbermaw Post"] = ""
Z["Winterfall Village"] = ""

-- Zangarmarsh
Z["Funggor Cavern"] = ""
Z["Quagg Ridge"] = ""
Z["Sporeggar"] = ""
Z["Swamprat Post"] = ""
Z["Telredor"] = ""
Z["The Spawning Glen"] = ""
Z["Zabra'jin"] = ""

--[[-- Account for missing translations --------------------------------]]

for k, v in pairs(Z) do
	if v == "" then
		Z[k] = k
	end
end
DiplomancerLocals = L
DiplomancerSubzones = Z