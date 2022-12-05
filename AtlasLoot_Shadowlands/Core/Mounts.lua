-- $Id: Mounts.lua 14 2022-12-04 07:47:36Z arithmandar $
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
				{   7, 180582, "mount" }, -- Endmire Flyer Tether
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
				{ 107, 181818, "mount" }, -- Chewed Reins of the Callow Flayedwing
				{ 108, 181819, "mount"}, -- Marrowfang's Reins
				{ 109, 181820, "mount" }, -- Armored Chosen Tauralus
				{ 110, 181821, "mount" }, -- Armored Plaguerot Tauralus
				{ 111, 181822, "mount" }, -- Armored War-Bred Tauralus
				{ 112, 182074, "mount" }, -- Chosen Tauralus
				{ 113, 182075, "mount" }, -- Bonehoof Tauralus
				{ 114, 182076, "mount" }, -- Plaguerot Tauralus
				{ 115, 182077, "mount" }, -- War-Bred Tauralus
				{ 116, 182078, "mount" }, -- Bonesewn Fleshroc
				{ 117, 182079, "mount" }, -- Slime-Covered Reins of the Hulking Deathroc
				{ 118, 182080, "mount" }, -- Predatory Plagueroc
				{ 119, 182081, "mount" }, -- Reins of the Colossal Slaughterclaw
				{ 120, 182082, "mount" }, -- Lurid Bloodtusk
				{ 121, 182083 }, -- Bonecleaver's Skullboar
				{ 122, 182084, "mount" }, -- Gorespine
				{ 123, 182085, "mount" }, -- Blisterback Bloodtusk
				{ 124, 182209, "mount" }, -- Desire's Battle Gargon
				{ 125, 182332, "mount" }, -- Gravestone Battle Armor
				{ 126, 182589, "mount" }, -- Loyal Gorger
				{ 127, 182596, "mount" }, -- Rampart Screecher
				{ 128, 182614, "mount" }, -- Blanchy's Reins
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
				{ 211, 183798, "mount" }, -- Silessa's Battle Harness
				{ 212, 183800, "mount" }, -- Amber Ardenmoth
				{ 213, 183801, "mount" }, -- Vibrant Flutterwing
				{ 214, 183937, "mount" }, -- Sinful Gladiator's Soul Eater
				{ 215, 184013, "mount" }, -- Vicious War Spider
				{ 216, 184014, "mount" }, -- Vicious War Spider
				{ 217, 184062, "mount" }, -- Gnawed Reins of the Battle-Bound Warhound
				{ 218, 184160, "mount" }, -- Bulbous Necroray
				{ 219, 184161, "mount" }, -- Infested Necroray
				{ 220, 184162, "mount" }, -- Pestilent Necroray
				{ 221, 184166, "mount" }, -- Corridor Creeper
				{ 222, 184167, "mount" }, -- Mawsworn Soulhunter
				{ 223, 184168, "mount" }, -- Bound Shadehound
				{ 224, 184183, "mount" }, -- Voracious Gorger
				{ 225, 185973 }, -- Chain of Bahmethra
				{ 226, 185996, "mount" }, -- Harvester's Dredwing Saddle
				{ 227, 186000, "mount" }, -- Legsplitter War Harness
				{ 228, 186103, "mount" }, -- Undying Darkhound's Harness
				{ 229, 186177, "mount" }, -- Unchained Gladiator's Soul Eater
				{ 230, 186178, "mount" }, -- Vicious War Gorm
				{ 301, 186179, "mount" }, -- Vicious War Gorm
				{ 302, 186469, "mount" }, -- Illidari Doomhawk
				{ 303, 186476, "mount" }, -- Sinfall Gravewing
				{ 304, 186477, "mount" }, -- Pale Gravewing
				{ 305, 186478, "mount" }, -- Obsidian Gravewing
				{ 306, 186479, "mount" }, -- Mastercraft Gravewing
				{ 307, 186480, "mount" }, -- Battle-Hardened Aquilon
				{ 308, 186482, "mount" }, -- Elysian Aquilon
				{ 309, 186483, "mount" }, -- Forsworn Aquilon
				{ 310, 186485, "mount" }, -- Ascendant's Aquilon
				{ 311, 186487, "mount" }, -- Maldraxxian Corpsefly Harness
				{ 312, 186488, "mount" }, -- Regal Corpsefly Harness
				{ 313, 186489, "mount" }, -- Lord of the Corpseflies
				{ 314, 186490, "mount" }, -- Battlefield Swarmer Harness
				{ 315, 186491 }, -- Spring Wilderling Harness
				{ 316, 186492, "mount" }, -- Summer Wilderling Harness
				{ 317, 186493, "mount" }, -- Ardenweald Wilderling Harness
				{ 318, 186494, "mount" }, -- Autumnal Wilderling Harness
				{ 319, 186495, "mount" }, -- Winter Wilderling Harness
				{ 320, 186637, "mount" }, -- Tazavesh Gearglider
				{ 321, 186638, "mount" }, -- Cartel Master's Gearglider
				{ 322, 186639 }, -- Pilfered Gearglider
				{ 323, 186640 }, -- Silver Gearglider
				{ 324, 186641 }, -- Tamed Mauler Harness
				{ 325, 186642 }, -- Vengeance's Reins
				{ 326, 186643 }, -- Reins of the Wanderer
				{ 327, 186644, "mount" }, -- Beryl Shardhide
				{ 328, 186645, "mount" }, -- Crimson Shardhide
				{ 329, 186646, "mount" }, -- Darkmaul
				{ 330, 186647, "mount" }, -- Amber Shardhide
				{ 401, 186648, "mount" }, -- Soaring Razorwing
				{ 402, 186649, "mount" }, -- Fierce Razorwing
				{ 403, 186651, "mount" }, -- Dusklight Razorwing
				{ 404, 186652, "mount" }, -- Garnet Razorwing
				{ 405, 186653, "mount" }, -- Bracer of Hrestimorak
				{ 406, 186654, "mount" }, -- Bracelet of Salaranga
				{ 407, 186655, "mount" }, -- Mawsworn Charger's Reins
				{ 408, 186656, "mount" }, -- Sanctum Gloomcharger's Reins
				{ 409, 186657, "mount" }, -- Soulbound Gloomcharger's Reins
				{ 410, 186659, "mount" }, -- Fallen Charger's Reins
				{ 411, 186713, "mount" }, -- Nilganihmaht Control Ring
				{ 412, 187183, "mount" }, -- Rampaging Mauler
				{ 413, 187525, "mount" }, -- Soultwisted Deathwalker
				{ 414, 187595, "mount" }, -- Favor of the Val'sharah Hippogryph
				{ 415, 187629, "mount" }, -- Heartlight Stone
				{ 416, 187630, "mount" }, -- Curious Crystalsniffer
				{ 417, 187631, "mount" }, -- Darkened Vombata
				{ 418, 187632, "mount" }, -- Adorned Vombata
				{ 419, 187638, "mount" }, -- Deathrunner
				{ 420, 187639, "mount" }, -- Pale Regal Cervid
				{ 421, 187640, "mount" }, -- Anointed Protostag Reins
				{ 422, 187641, "mount" }, -- Reins of the Sundered Zerethsteed
				{ 423, 187642, "mount" }, -- Vicious Warstalker
				{ 424, 187644, "mount" }, -- Vicious Warstalker
				{ 425, 187660, "mount" }, -- Vespoid Flutterer
				{ 426, 187663, "mount" }, -- Bronzewing Vespoid
				{ 427, 187664, "mount" }, -- Forged Spiteflyer
				{ 428, 187665, "mount" }, -- Buzz
				{ 429, 187666, "mount" }, -- Desertwing Hunter
				{ 430, 187667, "mount" }, -- Mawdapted Raptora
				{ 501, 187668, "mount" }, -- Raptora Swooper
				{ 502, 187669, "mount" }, -- Serenade
				{ 503, 187670, "mount" }, -- Bronze Helicid
				{ 504, 187671, "mount" }, -- Unsuccessful Prototype Fleetpod
				{ 505, 187672, "mount" }, -- Scarlet Helicid
				{ 506, 187673, "mount" }, -- Cryptic Aurelid
				{ 507, 187675, "mount" }, -- Shimmering Aurelid
				{ 508, 187676, "mount" }, -- Deepstar Polyp
				{ 509, 187677, "mount" }, -- Genesis Crawler
				{ 510, 187678, "mount" }, -- Tarachnid Creeper
				{ 511, 187679, "mount" }, -- Ineffable Skitterer
				{ 512, 187680, "mount" }, -- Vicious War Croaker
				{ 513, 187681, "mount" }, -- Vicious War Croaker
				{ 514, 187682, "mount" }, -- Wastewarped Deathwalker
				{ 515, 187683, "mount" }, -- Goldplate Bufonid
				{ 516, 188674, "mount" }, -- Mage-Bound Spelltome
				{ 517, 188696, "mount" }, -- Sturdy Soulsteel Mawrat Harness
				{ 518, 188700, "mount" }, -- Sturdy Silver Mawrat Harness
				{ 519, 188736, "mount" }, -- Sturdy Gilded Mawrat Harness
				{ 520, 188808, "mount" }, -- Patient Bufonid
				{ 521, 188809, "mount" }, -- Prototype Leaper
				{ 522, 188810, "mount" }, -- Russet Bufonid
				{ 523, 189507, "mount" }, -- Cosmic Gladiator's Soul Eater
				{ 524, 190170, "mount" }, -- Jigglesworth, Sr.
				{ 525, 190580, "mount" }, -- Heartbond Lupine
				{ 526, 190581, "mount" }, -- Nether-Gorged Greatwyrm
				{ 527, 190765, "mount" }, -- Iska's Mawrat Leash
				{ 528, 190766, "mount" }, -- Spectral Mawrat's Tail
				{ 529, 190768, "mount" }, -- Fractal Cypher of the Zereth Overseer
				{ 530, 190771, "mount" }, -- Fractal Cypher of the Carcinized Zerethsteed
				{ 601, 191123, "mount" }, -- Grimhowl's Face Axe
				{ 602, 191290, "mount" }, -- Eternal Gladiator's Soul Eater
				{ 603, 191566, "mount" }, -- Elusive Emerald Hawkstrider
				{ 604, 192557, "mount" }, -- Restoration Deathwalker
			},
		},
	},
}
