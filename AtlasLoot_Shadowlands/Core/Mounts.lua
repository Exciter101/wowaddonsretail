-- $Id: Mounts.lua 12 2022-12-03 14:48:53Z arithmandar $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local _, private = ...
local AtlasLoot = _G.AtlasLoot
local data = private.data
local AL = AtlasLoot.Locales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", {
	Item = {
		item1bonus = "Scaling",
		addDifficultyBonus = true,
	},
}, 1)
local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
local HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)

local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")

local MOUNT_CONTENT = data:AddContentType(AL["Mounts"], ATLASLOOT_COLLECTION_COLOR)

data["MOUNTS"] = {
	name = AL["Mounts"],
	ContentType = MOUNT_CONTENT,
	TableType = NORMAL_ITTYPE,
	items = 
	{
		{
			name = AL["Mounts"],
			[NORMAL_DIFF] = {
				{   1, 180263, "mount" }, -- Dreamlight Runestag
				{   2, 180413, "mount" }, -- Shadeleaf Runestag
				{   3, 180414, "mount" }, -- Wakener's Runestag
				{   4, 180415, "mount" }, -- Winterborn Runestag
				{   5, 180461, "mount" }, -- Horrid Dredwing
				{   6, 180581, "mount" }, -- Hopecrusher Gargon
				{   7, 180582, }, -- Endmire Flyer Tether
				{   8, 180721, "mount" }, -- Enchanted Dreamlight Runestag
				{   9, 180722, "mount" }, -- Enchanted Shadeleaf Runestag
				{  10, 180723, "mount" }, -- Enchanted Wakener's Runestag
				{  11, 180724, "mount" }, -- Enchanted Winterborn Runestag
				{  12, 180725, "mount" }, -- Spinemaw Gladechewer
				{  13, 180726, "mount" }, -- Pale Acidmaw
				{  14, 180727, "mount" }, -- Shimmermist Runner
				{  15, 180728, "mount" }, -- Swift Gloomhoof
				{  16, 180729, "mount" }, -- Duskflutter Ardenmoth
				{  17, 180730, "mount" }, -- Wild Glimmerfur Prowler
				{  18, 180731, "mount" }, -- Wildseed Cradle
				{  19, 180748, "mount" }, -- Silky Shimmermoth
				{  20, 180761, "mount" }, -- Phalynx of Loyalty
				{  21, 180762, "mount" }, -- Phalynx of Humility
				{  22, 180763, "mount" }, -- Phalynx of Courage
				{  23, 180764, "mount" }, -- Phalynx of Purity
				{  24, 180765, "mount" }, -- Eternal Phalynx of Purity
				{  25, 180766, "mount" }, -- Eternal Phalynx of Courage
				{  26, 180767, "mount" }, -- Eternal Phalynx of Loyalty
				{  27, 180768, "mount" }, -- Eternal Phalynx of Humility
				{  28, 180772, "mount" }, -- Silverwind Larion
				{  29, 180773, "mount" }, -- Sundancer
				{  30, 180945, "mount" }, -- Crypt Gargon
				{ 101, 180948, "mount" }, -- Battle Gargon Vrednic
				{ 102, 181300, "mount" }, -- Gruesome Flayedwing
				{ 103, 181316, "mount" }, -- Silvertip Dredwing
				{ 104, 181317, "mount" }, -- Dauntless Duskrunner
				{ 105, 181815, "mount" }, -- Armored Bonehoof Tauralus
				{ 106, 181817 }, -- Deathbringer's Flayedwing
				{ 107, 181818 }, -- Chewed Reins of the Callow Flayedwing
				{ 108, 181819 }, -- Marrowfang's Reins
				{ 109, 181820, "mount" }, -- Armored Chosen Tauralus
				{ 110, 181821, "mount" }, -- Armored Plaguerot Tauralus
				{ 111, 181822, "mount" }, -- Armored War-Bred Tauralus
				{ 112, 182074, "mount" }, -- Chosen Tauralus
				{ 113, 182075, "mount" }, -- Bonehoof Tauralus
				{ 114, 182076, "mount" }, -- Plaguerot Tauralus
				{ 115, 182077, "mount" }, -- War-Bred Tauralus
				{ 116, 182078, "mount" }, -- Bonesewn Fleshroc
				{ 117, 182079 }, -- Slime-Covered Reins of the Hulking Deathroc
				{ 118, 182080, "mount" }, -- Predatory Plagueroc
				{ 119, 182081, "mount" }, -- Reins of the Colossal Slaughterclaw
				{ 120, 182082, "mount" }, -- Lurid Bloodtusk
				{ 121, 182083 }, -- Bonecleaver's Skullboar
				{ 122, 182084, "mount" }, -- Gorespine
				{ 123, 182085, "mount" }, -- Blisterback Bloodtusk
				{ 124, 182209, "mount" }, -- Desire's Battle Gargon
				{ 125, 182332 }, -- Gravestone Battle Armor
				{ 126, 182589, "mount" }, -- Loyal Gorger
				{ 127, 182596, "mount" }, -- Rampart Screecher
				{ 128, 182614 }, -- Blanchy's Reins
				{ 129, 182650, "mount" }, -- Arboreal Gulper
				{ 130, 182717, "mount" }, -- Sintouched Deathwalker
				{ 201, 182954, "mount" }, -- Inquisition Gargon
				{ 202, 183052, "mount" }, -- Darkwarren Hardshell
				{ 203, 183053, "mount" }, -- Umbral Scythehorn
				{ 204, 183518, "mount" }, -- Court Sinrunner
				{ 205, 183615, "mount" }, -- Warstitched Darkhound
				{ 206, 183617, "mount" }, -- Chittering Animite
				{ 207, 183618, "mount" }, -- Highwind Darkmane
				{ 208, 183715, "mount" }, -- Sinfall Gargon
				{ 209, 183740, "mount" }, -- Gilded Prowler
				{ 210, 183741, "mount" }, -- Ascended Skymane
				{ 211, 183798 }, -- Silessa's Battle Harness
				{ 212, 183800, "mount" }, -- Amber Ardenmoth
				{ 213, 183801, "mount" }, -- Vibrant Flutterwing
				{ 214, 183937, "mount" }, -- Sinful Gladiator's Soul Eater
				{ 215, 184013, "mount" }, -- Vicious War Spider
				{ 216, 184014 }, -- Vicious War Spider
				{ 217, 184062 }, -- Gnawed Reins of the Battle-Bound Warhound
				{ 218, 184160, "mount" }, -- Bulbous Necroray
				{ 219, 184161, "mount" }, -- Infested Necroray
				{ 220, 184162, "mount" }, -- Pestilent Necroray
				{ 221, 184166, "mount" }, -- Corridor Creeper
				{ 222, 184167, "mount" }, -- Mawsworn Soulhunter
				{ 223, 184168, "mount" }, -- Bound Shadehound
				{ 224, 184183, "mount" }, -- Voracious Gorger
				{ 225, 185965 }, -- Memories of Sunless Skies
				{ 226, 185973 }, -- Chain of Bahmethra
				{ 227, 185996 }, -- Harvester's Dredwing Saddle
				{ 228, 186000 }, -- Legsplitter War Harness
				{ 229, 186103 }, -- Undying Darkhound's Harness
				{ 230, 186177, "mount" }, -- Unchained Gladiator's Soul Eater
				{ 301, 186178, "mount" }, -- Vicious War Gorm
				{ 302, 186179 }, -- Vicious War Gorm
				{ 303, 186469 }, -- Illidari Doomhawk
				{ 304, 186476, "mount" }, -- Sinfall Gravewing
				{ 305, 186477, "mount" }, -- Pale Gravewing
				{ 306, 186478, "mount" }, -- Obsidian Gravewing
				{ 307, 186479 }, -- Mastercraft Gravewing
				{ 308, 186480, "mount" }, -- Battle-Hardened Aquilon
				{ 309, 186482, "mount" }, -- Elysian Aquilon
				{ 310, 186483, "mount" }, -- Forsworn Aquilon
				{ 311, 186485, "mount" }, -- Ascendant's Aquilon
				{ 312, 186487 }, -- Maldraxxian Corpsefly Harness
				{ 313, 186488 }, -- Regal Corpsefly Harness
				{ 314, 186489, "mount" }, -- Lord of the Corpseflies
				{ 315, 186490 }, -- Battlefield Swarmer Harness
				{ 316, 186491 }, -- Spring Wilderling Harness
				{ 317, 186492 }, -- Summer Wilderling Harness
				{ 318, 186493 }, -- Ardenweald Wilderling Harness
				{ 319, 186494 }, -- Autumnal Wilderling Harness
				{ 320, 186495 }, -- Winter Wilderling Harness
				{ 321, 186637, "mount" }, -- Tazavesh Gearglider
				{ 322, 186638, "mount" }, -- Cartel Master's Gearglider
				{ 323, 186639 }, -- Pilfered Gearglider
				{ 324, 186640 }, -- Silver Gearglider
				{ 325, 186641 }, -- Tamed Mauler Harness
				{ 326, 186642 }, -- Vengeance's Reins
				{ 327, 186643 }, -- Reins of the Wanderer
				{ 328, 186644, "mount" }, -- Beryl Shardhide
				{ 329, 186645, "mount" }, -- Crimson Shardhide
				{ 330, 186646, "mount" }, -- Darkmaul
				{ 401, 186647, "mount" }, -- Amber Shardhide
				{ 402, 186648, "mount" }, -- Soaring Razorwing
				{ 403, 186649, "mount" }, -- Fierce Razorwing
				{ 404, 186651, "mount" }, -- Dusklight Razorwing
				{ 405, 186652, "mount" }, -- Garnet Razorwing
				{ 406, 186653 }, -- Bracer of Hrestimorak
				{ 407, 186654 }, -- Bracelet of Salaranga
				{ 408, 186655 }, -- Mawsworn Charger's Reins
				{ 409, 186656 }, -- Sanctum Gloomcharger's Reins
				{ 410, 186657 }, -- Soulbound Gloomcharger's Reins
				{ 411, 186659 }, -- Fallen Charger's Reins
				{ 412, 186713 }, -- Nilganihmaht Control Ring
				{ 413, 187183, "mount" }, -- Rampaging Mauler
				{ 414, 187412 }, -- Shardhide Ka-Sha
				{ 415, 187525, "mount" }, -- Soultwisted Deathwalker
				{ 416, 187595 }, -- Favor of the Val'sharah Hippogryph
				{ 417, 187629 }, -- Heartlight Stone
				{ 418, 187630, "mount" }, -- Curious Crystalsniffer
				{ 419, 187631, "mount" }, -- Darkened Vombata
				{ 420, 187632, "mount" }, -- Adorned Vombata
				{ 421, 187638, "mount" }, -- Deathrunner
				{ 422, 187639, "mount" }, -- Pale Regal Cervid
				{ 423, 187640 }, -- Anointed Protostag Reins
				{ 424, 187641, "mount" }, -- Reins of the Sundered Zerethsteed
				{ 425, 187642, "mount" }, -- Vicious Warstalker
				{ 426, 187644 }, -- Vicious Warstalker
				{ 427, 187660, "mount" }, -- Vespoid Flutterer
				{ 428, 187663, "mount" }, -- Bronzewing Vespoid
				{ 429, 187664, "mount" }, -- Forged Spiteflyer
				{ 430, 187665, "mount" }, -- Buzz
				{ 501, 187666, "mount" }, -- Desertwing Hunter
				{ 502, 187667, "mount" }, -- Mawdapted Raptora
				{ 503, 187668, "mount" }, -- Raptora Swooper
				{ 504, 187669, "mount" }, -- Serenade
				{ 505, 187670, "mount" }, -- Bronze Helicid
				{ 506, 187671, "mount" }, -- Unsuccessful Prototype Fleetpod
				{ 507, 187672, "mount" }, -- Scarlet Helicid
				{ 508, 187673, "mount" }, -- Cryptic Aurelid
				{ 509, 187675, "mount" }, -- Shimmering Aurelid
				{ 510, 187676 }, -- Deepstar Polyp
				{ 511, 187677, "mount" }, -- Genesis Crawler
				{ 512, 187678, "mount" }, -- Tarachnid Creeper
				{ 513, 187679, "mount" }, -- Ineffable Skitterer
				{ 514, 187680, "mount" }, -- Vicious War Croaker
				{ 515, 187681 }, -- Vicious War Croaker
				{ 516, 187682, "mount" }, -- Wastewarped Deathwalker
				{ 517, 187683, "mount" }, -- Goldplate Bufonid
				{ 518, 188674 }, -- Mage-Bound Spelltome
				{ 519, 188696 }, -- Sturdy Soulsteel Mawrat Harness
				{ 520, 188700 }, -- Sturdy Silver Mawrat Harness
				{ 521, 188736 }, -- Sturdy Gilded Mawrat Harness
				{ 522, 188808, "mount" }, -- Patient Bufonid
				{ 523, 188809, "mount" }, -- Prototype Leaper
				{ 524, 188810, "mount" }, -- Russet Bufonid
				{ 525, 189507, "mount" }, -- Cosmic Gladiator's Soul Eater
				{ 526, 190170 }, -- Jigglesworth, Sr.
				{ 527, 190580, "mount" }, -- Heartbond Lupine
				{ 528, 190581, "mount" }, -- Nether-Gorged Greatwyrm
				{ 529, 190765 }, -- Iska's Mawrat Leash
				{ 530, 190766 }, -- Spectral Mawrat's Tail
				{ 601, 190768 }, -- Fractal Cypher of the Zereth Overseer
				{ 602, 190771 }, -- Fractal Cypher of the Carcinized Zerethsteed
				{ 603, 191123 }, -- Grimhowl's Face Axe
				{ 604, 191290, "mount" }, -- Eternal Gladiator's Soul Eater
				{ 605, 191566, "mount" }, -- Elusive Emerald Hawkstrider
				{ 606, 192557, "mount" }, -- Restoration Deathwalker
			},
		},
	},
}
