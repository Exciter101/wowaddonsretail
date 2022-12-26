-- $Id: Collections.lua 23 2022-12-26 15:34:39Z arithmandar $
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
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", {
	Item = {
		item1bonus = "Scaling",
		addDifficultyBonus = true,
	},
}, 1)
local ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
local HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local I_A_ITTYPE  = data:AddItemTableType("Item", "Achievement")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")

local COLLECTION_CONTENT = data:AddContentType(AL["Collections"], ATLASLOOT_COLLECTION_COLOR)
--local FACTION_CONTENT = data:AddContentType(AL["Factions"], ATLASLOOT_FACTION_COLOR)
--local MOUNT_CONTENT = data:AddContentType(AL["Mounts"], ATLASLOOT_COLLECTION_COLOR)

-- /////////////////////////////////
-- Faction
-- /////////////////////////////////
--[[
	-- rep info ("f1435rep3" = Unfriendly rep @ Shado-Pan Assault)
	1. Hated
	2. Hostile
	3. Unfriendly
	4. Neutral
	5. Friendly
	6. Honored
	7. Revered
	8. Exalted
	-- if rep index is in between 11 and 16, means it has friendship reputation
]]
--[[
data["DRAGONFACTIONS"] = {
	name = FACTION ,
	ContentType = FACTION_CONTENT,
	items = { 
		{ -- The Ascended
			FactionID = 2407,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f2407rep5" }, -- Friendly
				{ 2, 173051, }, -- Contract: The Ascended
				{ 3, 183098, [PRICE_EXTRA_ITTYPE] = "money:760" }, -- Technique: Codex of the Still Mind
				
				{ 5, "f2407rep6" }, -- Honored
				{ 6, 184756, [PRICE_EXTRA_ITTYPE] = "money:1816968" }, -- Smoothed Loop of Contemplation
				{ 7, 183094, [PRICE_EXTRA_ITTYPE] = "money:199500" }, -- Plans: Shadowsteel Helm
				
				{ 9, "f2407rep7" }, -- Revered
				{ 10, 183103, [PRICE_EXTRA_ITTYPE] = "money:17650000" }, -- Technique: Contract: The Ascended
				{ 11, 184732, [PRICE_EXTRA_ITTYPE] = "money:1556738" }, -- Manacles of Burden
				{ 12, 184734, [PRICE_EXTRA_ITTYPE] = "money:1567831" }, -- Bracers of Regret
				{ 13, 184735, [PRICE_EXTRA_ITTYPE] = "money:1573227" }, -- Wristclasps of Shame
				{ 14, 184733, [PRICE_EXTRA_ITTYPE] = "money:1562284" }, -- Wristclamps of Remorse
				
				{ 16, "f2407rep8" }, -- Exalted
				{ 17, 184351, [PRICE_EXTRA_ITTYPE] = "money:12500000" }, -- Illusion: Devoted Spirit
				{ 18, 183097, [PRICE_EXTRA_ITTYPE] = "money:38" }, -- Schematic: PHA7-YNX
				{ 19, 184729, [PRICE_EXTRA_ITTYPE] = "money:3091417" }, -- Masque of the Path
				{ 20, 184728, [PRICE_EXTRA_ITTYPE] = "money:3080285" }, -- Casque of the Path
				{ 21, 184730, [PRICE_EXTRA_ITTYPE] = "money:3102549" }, -- Cowl of the Path
				{ 22, 184731, [PRICE_EXTRA_ITTYPE] = "money:3113380" }, -- Gorget of the Path
				{ 23, 178991, [PRICE_EXTRA_ITTYPE] = "money:95000" }, -- Tabard of the Ascended
			},
		},
	}
}
]]

data["FACTIONS"] = {
	name = FACTION ,
	ContentType = COLLECTION_CONTENT,
	items = { 
		{ -- Dragonscale Expedition
			FactionID = 2507,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f2507rep33" },
                { 2, 198387, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:ResilientLeather:3" }, -- Excavator's Mallet
                { 3, 198717, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:ResilientLeather:3" }, -- Excavator's Punch
                { 4, 198718, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:193214:3" }, -- Excavator's Chisel
                { 5, 199746, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:193214:3" }, -- Excavator's Trowel
				{ 7, "f2507rep34" },
    			{ 8, 199873, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:75:193050:10" }, -- Renowned Expeditioner's Cape
    			{ 9, 199874, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:75:193050:10" }, -- Renowned Expeditioner's Cloak
    			{ 10, 199875, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:75:193050:10" }, -- Renowned Expeditioner's Drape
    			{ 11, 199876, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:75:193050:10" }, -- Renowned Expeditioner's Armored Shawl
				{ 13, "f2507rep35" },
                { 14, 191294, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:15" }, -- Small Expedition Shovel
                { 15, 198719, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:15" }, -- Plans: Sturdy Expedition Shovel
				{ 16, "f2507rep36" },
    			{ 17, 198083, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:75" }, -- Expedition Supply Kit
				{ 19, "f2507rep37" },
                { 20, 194102, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:5" }, -- Expedition Excavator
                { 21, 194325, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:201404:5" }, -- Researcher's Magnifier
                { 22, 194326, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:201405:3" }, -- Trusty Sweeper
				{ 101, "f2507rep39" },
				{ 102, 197360, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Renewed Proto-Drake: Spined Brow
                { 103, 197363, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Renewed Proto-Drake: Maned Crest
                { 104, 197386, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Renewed Proto-Drake: Spiked Jaw
                { 105, 198781, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Schematic: Gravitational Displacer
                { 106, 198784, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Schematic: Primal Deconstruction Charge
                { 107, 194605, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Design: Radiant Malygite
                { 108, 194606, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Design: Energized Malygite
                { 109, 194613, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Design: Sensei's 192863
                { 110, 194614, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Design: Keen 192863
                { 111, 199811, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Formula: Enchant Cloak - Graceful Avoidance
                { 112, 199812, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Formula: Enchant Boots - Rider's Reassurance
				{ 116, "f2507rep41" },
				{ 117, 198725, "pet3381", [PRICE_EXTRA_ITTYPE] = "201401:3:201404:5:dragonSupplies:150" }, -- Gray Marmoni
				{ 118, 198726, "pet3380", [PRICE_EXTRA_ITTYPE] = "201401:3:201404:5:dragonSupplies:150" }, -- Black Skitterbug
				{ 120, "f2507rep42" },
    			{ 121, 198734, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Relic Handler's Gloves
    			{ 122, 198735, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Relic Handler's Gloves
    			{ 123, 198736, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Relic Handler's Grips
    			{ 124, 198737, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Relic Handler's Gauntlets
				{ 126, "f2507rep43" },
                { 127, 198101, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400" }, -- Recipe: Salad on the Side
                { 128, 194632, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400" }, -- Design: Idol of the Lifebinder
                { 129, 194635, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400" }, -- Design: Idol of the Earth Warder
				{ 201, "f2507rep44" },
    			{ 202, 198775, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:193050:40" }, -- Ensemble: Renowned Expeditioner's Cloth Armor
    			{ 203, 198776, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:ResilientLeather:20" }, -- Ensemble: Renowned Expeditioner's Leather Armor
    			{ 204, 198777, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:193214:20" }, -- Ensemble: Renowned Expeditioner's Mail Armor
    			{ 205, 198778, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:190396:20" }, -- Ensemble: Renowned Expeditioner's Plate Armor
				{ 207, "f2507rep45" },
                { 208, 197402, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:100" }, -- Renewed Proto-Drake: Spiked Club Tail
                { 209, 197374, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:100" }, -- Renewed Proto-Drake: Swept Horns
                { 210, 197395, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:100" }, -- Renewed Proto-Drake: Harrier Pattern
                { 211, 198783, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Schematic: Spring-Loaded Khaz'gorite Fabric Cutters
                { 212, 198782, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Schematic: Bottomless Mireslush Ore Satchel
                { 213, 194661, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Design: Magnificent Margin Magnifier
                { 214, 194291, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Pattern: Master's Wildercloth Fishing Cap
                { 215, 194289, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Pattern: Master's Wildercloth Chef's Hat
                { 216, 194295, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750" }, -- Pattern: Explorer's Banner of Geology
                { 217, 194294, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750" }, -- Pattern: Explorer's Banner of Herbology
                { 218, 198901, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:25" }, -- Technique: Renewed Proto-Drake: Spined Crest
				{ 220, "f2507rep47" },
                { 221, 198720, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:100:193050:20:192096:2" }, -- Soft Purple Pillow
                { 222, 198721, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:100:193050:20:192096:2" }, -- Skinny Reliquary Pillow
                { 223, 198722, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:100:193050:20:192096:2" }, -- Small Triangular Pillow
                { 224, 194281, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750" }, -- Pattern: Cold Cushion
                { 225, 194268, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750" }, -- Pattern: Dragonscale Expedition's Expedition Tent
				{ 301, "f2507rep48" },
    			{ 302, 198738, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Dragonscale Expedition Leggings
    			{ 303, 198739, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Dragonscale Expedition Breeches
    			{ 304, 198740, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Dragonscale Expedition Greaves
    			{ 305, 198741, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Dragonscale Expedition Legguards
				{ 307, "f2507rep49" },
                { 308, 198728, [PRICE_EXTRA_ITTYPE] = "193050:20:dragonSupplies:150" }, -- Explorer's League Banner
                { 309, 198729, [PRICE_EXTRA_ITTYPE] = "193050:20:dragonSupplies:150" }, -- Reliquary Banner
				{ 310, 198730 }, -- Dragonscale Expedition Tabard
                { 311, 194285, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750" }, -- Pattern: Azureweave Expedition Pack
                { 312, 198788, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:200" }, -- Technique: Contract: Dragonscale Expedition
				{ 314, "f2507rep50" },
                { 315, 198727, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:15" }, -- Expedition Explosives
				{ 316, "f2507rep51" },
    			{ 317, 199062, }, -- Ruby Gem Cluster Map
    			{ 318, 200738, [PRICE_EXTRA_ITTYPE] = "192863:3:dragonSupplies:100" }, -- Onyx Gem Cluster Map
                { 319, 198796, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:1000" }, -- Quack-E Quack Modulator
                { 320, 198785, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750" }, -- Schematic: Quack-E
                { 321, 194283, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750" }, -- Pattern: Duck-Stuffed Duck Lovie
                { 322, 198909, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750" }, -- Technique: Illusion Parchment: Magma Missile
--                { 323, 198780,  }, -- Schematic: Expedition Multi-Toolbox
				{ 324, "f2507rep52" },
                { 325, 197010, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400:190321:1" }, -- Cliffside Wylderdrake: Red Scales
                { 326, 197144, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400:190321:1" }, -- Highland Drake: Red Scales
                { 327, 197614, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400:190321:1" }, -- Windborne Velocidrake: Red Scales
				{ 401, "f2507rep55" },
				{ 402, 197921,  }, -- Primal Infusion
				{ 403, 192761, "mount", [PRICE_EXTRA_ITTYPE] = "193053:20:201401:5:dragonSupplies:750" }, -- Tamed Skitterfly
				{ 404, 192762, "mount", [PRICE_EXTRA_ITTYPE] = "193053:20:201401:5:dragonSupplies:750" }, -- Azure Skitterfly
				{ 405, 192764, "mount" }, -- Verdant Skitterfly

			},
		},
		{ -- Valdrakken Accord
			FactionID = 2510,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1, "f2510rep32" },
				{ 2, 199906,  }, -- Titan Relic
				{ 4 , "f2510rep33" },
				{ 5 , 199649, [PRICE_EXTRA_ITTYPE] = "190396:3:dragonSupplies:50" }, -- Dragon Tea Set
				{ 6 , 199648, [PRICE_EXTRA_ITTYPE] = "193214:3:dragonSupplies:150" }, -- Dragon Dinner Fork
				{ 7 , 200750, [PRICE_EXTRA_ITTYPE] = "193214:3:dragonSupplies:150" }, -- Dragon Dinner Knife
				{ 8 , 200751, [PRICE_EXTRA_ITTYPE] = "188658:5:dragonSupplies:150" }, -- Simple Silver Dragon Goblet
				{ 9 , 200752, [PRICE_EXTRA_ITTYPE] = "188658:3:192838:2:dragonSupplies:150" }, -- Jeweled Silver Dragon Goblet
				{ 10, 200753, [PRICE_EXTRA_ITTYPE] = "190396:5:dragonSupplies:150" }, -- Simple Gold Dragon Goblet
				{ 11, 200754, [PRICE_EXTRA_ITTYPE] = "190396:5:192838:2:dragonSupplies:150" }, -- Jeweled Gold Dragon Goblet
				{ 12, 200752, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:188658:3:192838:2" }, -- Jeweled Silver Dragon Goblet
				{ 13, 200754, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:190396:5:192838:2" }, -- Jeweled Gold Dragon Goblet
				{ 16, "f2510rep36" },
				{ 17, 199647, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:198397" }, -- Dragon Garden Fork
				{ 18, 199651, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:198397" }, -- Dragon Garden Hoe
				{ 19, 199652, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:198397" }, -- Dragon Garden Rake
				{ 20, 199653, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:198397" }, -- Dragon Garden Hand Shovel
				{ 21, 199654, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:198397" }, -- Dragon Garden Shovel
				{ 23, "f2510rep39" },
				{ 24, 196972, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50:" }, -- Cliffside Wylderdrake: Plated Brow
				{ 25, 196977, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50:" }, -- Cliffside Wylderdrake: Split Head Horns
				{ 26, 197003, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50:" }, -- Cliffside Wylderdrake: Spiked Cheek
				{ 101, "f2510rep40" },
				{ 102, 199655, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:193050:20" }, -- Black Dragonspawn Shoulderpads
				{ 103, 199656, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:193050:20" }, -- Blue Dragonspawn Shoulderpads
				{ 104, 199657, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:193050:20" }, -- Bronze Dragonspawn Shoulderpads
				{ 105, 199658, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:193050:20" }, -- Green Dragonspawn Shoulderpads
				{ 106, 199659, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:193050:20" }, -- Red Dragonspawn Shoulderpads
				{ 108, "f2510rep41" },
				{ 109, 199817, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Formula: Enchant Cloak - Homebound Speed
				{ 110, 199818, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Formula: Enchant Boots - Watcher's Loam
				{ 111, 199246, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:50" }, -- Schematic: Tinker: Grounded Circuitry
				{ 116, "f2510rep43" },
				{ 117, 199772, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:201406:1" }, -- Titan Gatekeeper's Shield
				{ 118, 199773, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:192850:1:201406:1" }, -- Titan Watcher's Scepter
				{ 119, 199774, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:201406:1" }, -- Ancient Titan Blunderbuss
				{ 120, 199775, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:201406:1" }, -- Titan Keeper's Gladius
				{ 121, 199776, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:193050:20:192850:1" }, -- Titan Watcher's Broadsword
				{ 123, "f2510rep44" },
				{ 124, 191545, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400" }, -- Recipe: Sustaining Alchemist's Stone
				{ 125, 194479, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400" }, -- Plans: Obsidian Seared Claymore
				{ 126, 194482, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400" }, -- Plans: Obsidian Seared Invoker
				{ 127, 194279, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400" }, -- Pattern: Azureweave Slippers
				{ 128, 194280, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400" }, -- Pattern: Chronocloth Sash
				{ 201, "f2510rep45" },
				{ 202, 196998, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:100:" }, -- Cliffside Wylderdrake: Hook Horns
				{ 203, 197009, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:100:" }, -- Cliffside Wylderdrake: Scaled Pattern
				{ 204, 197020, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:100:" }, -- Cliffside Wylderdrake: Spear Tail
				{ 205, 198892, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:25" }, -- Technique: Cliffside Wylderdrake: Red Hair
				{ 207, "f2510rep46" },
				{ 208, 199759, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Valdrakken Plate Girdle
				{ 209, 199760, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Valdrakken Spellweaver's Cord
				{ 210, 199761, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Valdrakken Dragonspawn Waistguard
				{ 211, 199762, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Valdrakken Guards Belt
				{ 216, "f2510rep47" },
				{ 217, 199680, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:200:190396:10" }, -- Obsidian Drakonid Helmet
				{ 218, 199681, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:200:190396:10" }, -- Cobalt Drakonid Helmet
				{ 219, 199682, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:200:190396:10" }, -- Bronze Drakonid Helmet
				{ 220, 199683, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:200:190396:10" }, -- Verdant Drakonid Helmet
				{ 221, 199684, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:200:190396:10" }, -- Crimson Drakonid Helmet
				{ 223, "f2510rep48" },
				{ 224, 199757, "pet3378", [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:201399:3:201402:1" }, -- Magic Nibbler
				{ 225, 199758, "pet3379", [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:201399:3:201402:1" }, -- Crimson Proto-Whelp
				{ 301, "f2510rep49" },
				{ 302, 194288, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Pattern: Master's Wildercloth Alchemist's Robe
				{ 303, 194290, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Pattern: Master's Wildercloth Enchanter's Hat
				{ 304, 194292, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Pattern: Master's Wildercloth Gardening Hat
				{ 305, 194495, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Plans: Khaz'gorite Sickle
				{ 306, 194498, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Plans: Khaz'gorite Needle Set
				{ 307, 194500, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Plans: Khaz'gorite Leatherworker's Toolset
				{ 308, 199244, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Schematic: Khaz'gorite Delver's Helmet
				{ 309, 199245, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:500" }, -- Schematic: Lapidary's Khaz'gorite Clamps
				{ 316, "f2510rep50" },
				{ 317, 199752, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:192838:1:193050:25" }, -- Ensemble: Crimson Valdrakken Clothing
				{ 318, 199753, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:192847:1:193050:25" }, -- Ensemble: Black Valdrakken Clothing
				{ 319, 199754, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:192841:1:193050:25" }, -- Ensemble: Azure Valdrakken Clothing
				{ 320, 199755, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:192844:1:193050:25" }, -- Ensemble: Green Valdrakken Clothing
				{ 321, 199756, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:192850:1:193050:25" }, -- Ensemble: Bronze Valdrakken Clothing
				{ 323, "f2510rep51" },
				{ 324, 196989, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:100:" }, -- Cliffside Wylderdrake: White Hair
				{ 325, 197145, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400:190324:1" }, -- Highland Drake: Bronze Scales
				{ 326, 197391, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400:190324:1" }, -- Renewed Proto-Drake: Bronze Scales
				{ 327, 197613, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:400:190324:1" }, -- Windborne Velocidrake: Bronze Scales
				{ 401, "f2510rep52" },
				{ 402, 199763, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Expedition Researcher's Hood
				{ 403, 199764, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Expedition Mercenary's Helm
				{ 404, 199765, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Field Scout's Helmet
				{ 405, 199766, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150" }, -- Expedition Guard's Helm
				{ 407, "f2510rep53" },
				{ 408, 198732 }, -- Valdrakken Accord Tabard
				{ 409, 198941, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:200" }, -- Technique: Contract: Valdrakken Accord
				{ 410, 194287, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750" }, -- Pattern: Chronocloth Reagent Bag
				{ 416, "f2510rep55" },
				{ 417, 194320, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:193210:10" }, -- Reinforced Lavender Bottle
				{ 418, 198388, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:198397:2" }, -- Swirling Draconian Concoction
				{ 419, 198389, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:5" }, -- Weighted Potion Cylinder
				{ 420, 199741, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:198397:2" }, -- Compendium of Advanced Spells
				{ 421, 199742, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:198397:2" }, -- A Mender's Mentality
				{ 422, 199743, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:188658:5" }, -- Runic Symbols and their Meaning
				{ 423, 199744, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:5" }, -- Academy Student's Journal
				{ 424, 199745, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:190321:1" }, -- Everflame Night Torch
				{ 501, "f2510rep56" },
				{ 502, 196962, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:188658:20:201404:10" }, -- Cliffside Wylderdrake: Silver and Purple Armor
				{ 503, 197093, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:188658:20:201404:10" }, -- Highland Drake: Silver and Purple Armor
				{ 504, 197350, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:188658:20:201404:10" }, -- Renewed Proto-Drake: Silver and Purple Armor
				{ 505, 197581, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750:188658:20:201404:10" }, -- Windborne Velocidrake: Silver and Purple Armor
				{ 507, "f2510rep57" },
				{ 508, 199767, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:192838:1:193050:20" }, -- Red Dragon Banner
				{ 509, 199768, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:192847:1:193050:20" }, -- Black Dragon Banner
				{ 510, 199769, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:192841:1:193050:20" }, -- Blue Dragon Banner
				{ 511, 199770, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:192850:1:193050:20" }, -- Bronze Dragon Banner
				{ 512, 199771, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:150:192844:1:193050:20" }, -- Green Dragon Banner
				{ 516, "f2510rep58" },
				{ 517, 199660, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:190396:10:192847:1" }, -- Obsidian Jeweled Shoulderpads
				{ 518, 199661, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:190396:10:192841:1" }, -- Azure Jeweled Shoulderpads
				{ 519, 199662, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:190396:10:192850:1" }, -- Amber Jeweled Shoulderpads
				{ 520, 199663, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:190396:10:192844:1" }, -- Emerald Jeweled Shoulderpads
				{ 521, 199664, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:190396:10:192838:1" }, -- Ruby Jeweled Shoulderpads
				{ 522, 199670, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:190396:10:192847:1" }, -- Black Drakonid Shoulderplates
				{ 523, 199671, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:190396:10:192841:1" }, -- Cobalt Drakonid Shoulderplates
				{ 524, 199672, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:190396:10:192850:1" }, -- Bronze Drakonid Shoulderplates
				{ 525, 199673, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:190396:10:192844:1" }, -- Verdant Drakonid Shoulderplates
				{ 526, 199674, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:250:190396:10:192838:1" }, -- Crimson Drakonid Shoulderplates
				{ 527, 194282, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750" }, -- Pattern: Cushion of Time Travel
				{ 528, 198912, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:750" }, -- Technique: Illusion Parchment: Whirling Breeze
				{ 601, "f2510rep59" },
				{ 602, 199700, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:198397:1:193214:10" }, -- Valdrakken Bladewing Decapitator
				{ 603, 199702, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:198397:1:193214:10" }, -- Valdrakken Guard's Barrier
				{ 604, 199705, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:193214:10" }, -- Valdrakken Guard's Spear
				{ 605, 199707, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:201404:5" }, -- Valdrakken Wingguard Polearm
				{ 606, 199726, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:201404:5" }, -- Valdrakken Spellweaver's Scepter
				{ 607, 199728, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:201404:5" }, -- Valdrakken Spellweaver's Stave
				{ 608, 199730, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:201404:5" }, -- Valdrakken Bladewing Staff
				{ 609, 199732, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:201404:5" }, -- Valdrakken Wing Glaive
				{ 610, 199734, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:192850:1" }, -- Valdrakken Guard's Cutlass
				{ 611, 199806, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:201404:5" }, -- Valdrakken Drakeclaw Barrier
				{ 612, 199820, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:188658:5:201404:5" }, -- Valdrakken Guard's Skullsplitter
				{ 613, 199821, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:188658:5:201404:5" }, -- Valdrakken Serrated Shortsword
				{ 614, 199823, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:193050:20" }, -- Valdrakken Gatekeeper's Polearm
				{ 615, 199825, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:201404:5" }, -- Valdrakken Belt Knife
				{ 616, 200456, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:188658:5:201404:5" }, -- Valdrakken Armor Opener
				{ 617, 201795, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:201404:5" }, -- Valdrakken Guard's Claw
				{ 618, 201796, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:190396:10:201404:5" }, -- Valdrakken Drakonid's Claw
				{ 619, 199736, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:200863:1:201404:5" }, -- Amber Dragonflame Blade
				{ 620, 199738, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:200864:1:201404:5" }, -- Ruby Dragonflame Blade
				{ 621, 199739, [PRICE_EXTRA_ITTYPE] = "dragonSupplies:600:200865:1:201404:5" }, -- Emerald Dragonflame Blade
			},
		},
	}
}

data["MOUNTS"] = {
	name = AL["Mounts"],
	ContentType = COLLECTION_CONTENT,
	TableType = NORMAL_ITTYPE,
	items = 
	{
		{
			name = AL["Mounts"],
			[ALLIANCE_DIFF] = {
				{  1, 192601, "mount" }, -- Loyal Magmammoth
				{  2, 192761, "mount" }, -- Tamed Skitterfly
				{  3, 192762, "mount" }, -- Azure Skitterfly
				{  4, 192764, "mount" }, -- Verdant Skitterfly
				{  5, 192775, "mount" }, -- Stormhide Salamanther
				{  6, 192777, "mount" }, -- Magmashell
				{  7, 192779 }, -- Scorchpath
				{  8, 192784, "ac16295" }, -- Shellack
				{  9, 192786, [PRICE_EXTRA_ITTYPE] = "magmote:1000" }, -- Slumbering Worldsnail Shell
				{ 10, 192791, "mount" }, -- Plainswalker Bearer
--				{ 11, 192792 }, -- PH Thunder Lizard Green
--				{ 12, 192793 }, -- PH Thunder Lizard Black
--				{ 13, 192794 }, -- PH Thunder Lizard Blue
--				{ 14, 192796 }, -- PH Thunder Lizard Light
				{ 11, 192799, "mount" }, -- Lizi's Reins
				{ 12, 192800 }, -- Skyskin Hornstrider
--				{ 17, 192801 }, -- PH Primal Tallstrider White
--				{ 18, 192802 }, -- PH Primal Tallstrider Black
--				{ 19, 192803 }, -- PH Primal Tallstrider Red
				{ 13, 192804 }, -- Restless Hornstrider
				{ 14, 192806, "ac16355" }, -- Raging Magmammoth
--				{ 22, 192807 }, -- PH Lava Mammoth Yellow
				{ 15, 194034, "mount" }, -- Renewed Proto-Drake
				{ 16, 194106, "mount" }, -- Highland Drake
				{ 17, 194521, "mount" }, -- Cliffside Wylderdrake
				{ 18, 194549, "mount" }, -- Windborne Velocidrake
				{ 19, 194705, "mount" }, -- Highland Drake
				{ 20, 198654, "ac15834" }, -- Otterworldly Ottuk Carrier
				{ 21, 198808, "mount" }, -- Guardian Vorquin
				{ 22, 198809, "mount" }, -- Armored Vorquin Leystrider
				{ 23, 198810, "mount" }, -- Swift Armored Vorquin
				{ 24, 198811, "mount" }, -- Majestic Armored Vorquin
				{ 25, 198821, "mount" }, -- Divine Kiss of Ohn'ahra
				{ 26, 198825, "mount" }, -- Zenet Hatchling
				{ 27, 198870, "mount" }, -- Otto
				{ 28, 198871, "mount" }, -- Iskaara Trader's Ottuk
				{ 29, 198872, "mount" }, -- Brown Scouting Ottuk
				{ 30, 198873, "mount" }, -- Ivory Trader's Ottuk
				{ 101, 199412, "mount" }, -- Hailstorm Armoredon
				{ 102, 200118, "mount" }, -- Yellow Scouting Ottuk
				{ 103, 201425, "mount" }, -- Yellow War Ottuk
				{ 104, 201426, "mount" }, -- Brown War Ottuk
				{ 105, 201440, "mount" }, -- Reins of the Liberated Slyvern
				{ 106, 201454, "mount" }, -- Temperamental Skyclaw
				{ 107, 201702, "mount" }, -- Crimson Vorquin
				{ 108, 201704, "mount" }, -- Sapphire Vorquin
				{ 109, 201719, "mount" }, -- Obsidian Vorquin
				{ 110, 201720, "mount" }, -- Bronze Vorquin
				{ 111, 201788, "mount" }, -- Vicious Sabertooth
				{ 112, 201789, "mount" }, -- Vicious Sabertooth
				{ 113, 202086, "mount" }, -- Crimson Gladiator's Drake
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 20, 198654, "ac15833" }, -- Otterworldly Ottuk Carrier
			},
		},
	},
}

data["TABARDS"] = {
	name = AL["Tabards"],
	ContentType = COLLECTION_CONTENT,
	TableType = I_A_ITTYPE,
	items = {
		{ 
			name = AL["Tabards"],
			--CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = {
				{ 1, 194675 }, -- Gilded Dracthyr's Tabard
				{ 2, 198802, [PRICE_EXTRA_ITTYPE] = "money:10526315" }, -- Artisan's Consortium Tabard
				{ 3, 198730 }, -- Dragonscale Expedition Tabard
				{ 4, 198731 }, -- Iskaara Tuskarr Tabard
				{ 5, 198732 }, -- Valdrakken Accord Tabard
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 1, 202197 }, -- Emboldened Dracthyr's Tabard
			},
		},
	},
}

data["COMPANIONS"] = {
	name = COMPANIONS ,
	ContentType = COLLECTION_CONTENT,
	TableType = I_A_ITTYPE,
	items = {
		{ 
			name = COMPANIONS,
			--CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{  1, 190583 }, -- Ichabod
				{  2, 191126 }, -- Obsidian Whelpling
				{  3, 191886, "pet3274" }, -- Alvin the Anvil
				{  4, 191915 }, -- Time-Lost Feral Rabbit
				{  5, 191930 }, -- Blue Phoenix Hatchling
				{  6, 191932, "pet3262" }, -- Violet Violence
				{  7, 191936, "pet3263" }, -- Secretive Frogduck
				{  8, 191941, "pet3264" }, -- Crystalline Mini-Monster
				{  9, 191946, "pet3265" }, -- Mister Muskoxeles
				{ 10, 192459, "pet3270" }, -- Jean's Lucky Fish
				{ 11, 193066, "pet3275" }, -- Chestnut
				{ 12, 193068 }, -- Time-Lost Treeflitter
				{ 13, 193071, "pet3278" }, -- Pistachio
				{ 14, 193225, "pet3284" }, -- Whiskuk
				{ 15, 193235 }, -- Scarlet Ottuk Pup
				{ 16, 193363 }, -- Auburntusk Calf
				{ 17, 193364 }, -- Time-Lost Baby Mammoth
				{ 18, 193373 }, -- Phoenix Wishwing
				{ 19, 193374 }, -- Crimson Phoenix Hatchling
				{ 20, 193377 }, -- Time-Lost Phoenix Hatchling
				{ 21, 193380 }, -- Pink Salamanther
				{ 22, 193429 }, -- Time-Lost Salamanther
				{ 23, 193484, "pet3302" }, -- Pilot
				{ 24, 193571, "pet3303" }, -- Mallard Duckling
				{ 25, 193572, "pet3306" }, -- Quack-E
				{ 26, 193587 }, -- Time-Lost Duck
				{ 27, 193614 }, -- Groundshaker
				{ 28, 193618, "pet3317" }, -- Hoofhelper
				{ 29, 193619, "pet3319" }, -- Yipper
				{ 30, 193620 }, -- Time-Lost Slyvern
				{ 101, 193834, "pet3321" }, -- Blackfeather Nester
				{ 102, 193835 }, -- Brightfeather
				{ 103, 193837, "pet3326" }, -- Backswimmer Timbertooth
				{ 104, 193850 }, -- Time-Lost Timbertooth
				{ 105, 193851 }, -- Purple Frillfish
				{ 106, 193852, "pet3269" }, -- Azure Frillfish
				{ 107, 193853 }, -- Emerald Frillfish
				{ 108, 193854 }, -- Blue Vorquin Foal
				{ 109, 193855 }, -- Time-Lost Vorquin Foal
				{ 110, 193885, "pet3345" }, -- Jeweled Amber Whelpling
				{ 111, 193886, "pet3344" }, -- Jeweled Sapphire Whelpling
				{ 112, 193887, "pet3346" }, -- Jeweled Ruby Whelpling
				{ 113, 193888, "pet3347" }, -- Jeweled Emerald Whelpling
				{ 114, 193889, "pet3256" }, -- Jeweled Onyx Whelpling
				{ 115, 193908 }, -- Sapphire Crystalspine
				{ 116, 194098, "pet3350" }, -- Lord Basilton
				{ 117, 198353 }, -- Shiverweb Egg
				{ 118, 198622 }, -- Spyragos
				{ 119, 198725, "pet3381" }, -- Gray Marmoni
				{ 120, 198726, "pet3380" }, -- Black Skitterbug
				{ 121, 199109, "pet3348" }, -- Primal Stormling
				{ 122, 199172, "pet3309" }, -- Viridescent Duck
				{ 123, 199175, "pet3316" }, -- Lubbins
				{ 124, 199326, "pet3376" }, -- Chip
				{ 125, 199688, "pet3279" }, -- Bronze Racing Enthusiast
				{ 126, 199757, "pet3378" }, -- Magic Nibbler
				{ 127, 199758, "pet3379" }, -- Crimson Proto-Whelp
				{ 128, 199916, "pet3365" }, -- Roseate Hopper
				{ 129, 200114, "pet3382" }, -- Stormie
				{ 130, 200173, "pet3287" }, -- Ghostflame
				{ 201, 200183, "pet3355" }, -- Echo of the Cave
				{ 202, 200255, "pet3289" }, -- Echo of the Inferno
				{ 203, 200260, "pet3299" }, -- Echo of the Depths
				{ 204, 200263, "pet3310" }, -- Echo of the Heights
				{ 205, 200276, "pet3311" }, -- Ohuna Companion
				{ 206, 200290, "pet3325" }, -- Bakar Companion
				{ 207, 200479, "pet3390" }, -- Sophic Amalgamation
				{ 208, 200519, "pet3286" }, -- Mister Toots
				{ 209, 200872, "pet3405" }, -- Living Mud Mask
				{ 210, 200874, "pet3406" }, -- Lady Feathersworth
				{ 211, 200927, "pet3408" }, -- Petal
				{ 212, 200930, "pet3414" }, -- Obsidian Proto-Whelp
				{ 213, 201260, "pet3410" }, -- Dust Spirit
				{ 214, 201261, "pet3411" }, -- Blaze Spirit
				{ 215, 201262, "pet3412" }, -- Gale Spirit
				{ 216, 201265, "pet3409" }, -- Tide Spirit
				{ 217, 201441, "pet3407" }, -- Scout
				{ 218, 201463, "pet3415" }, -- Cubbly
				{ 219, 201703, "pet3417" }, -- Pinkie
				{ 220, 201707, "pet3416" }, -- Troubled Tome
				{ 221, 201838 }, -- Snowclaw Cub
				{ 222, 202085 }, -- Bugbiter Tortoise
			},
		},
	},
}

data["TOYS"] = {
	name = TOY,
	ContentType = COLLECTION_CONTENT,
	TableType = I_A_ITTYPE,
	items = {
		{ 
			name = TOY,
			--CoinTexture = "Reputation",
			[NORMAL_DIFF] = {
				{ 1 , 191891 }, -- Professor Chirpsnide's Im-PECK-able Harpy Disguise
				{ 2 , 192443 }, -- Element-Infused Rocket Helmet
				{ 3 , 192495 }, -- Malfunctioning Stealthman 54
				{ 4 , 193032 }, -- Jeweled Offering
				{ 5 , 193033 }, -- Convergent Prism
				{ 6 , 193476 }, -- Gnoll Tent
				{ 7 , 193478 }, -- Tuskarr Beanbag
				{ 8 , 194052 }, -- Forlorn Funeral Pall
				{ 9 , 194056 }, -- Duck-Stuffed Duck Lovie
				{ 10, 194057 }, -- Cushion of Time Travel
				{ 11, 194058 }, -- Cold Cushion
				{ 12, 194059 }, -- Market Tent
				{ 13, 194060 }, -- Dragonscale Expedition's Expedition Tent
				{ 14, 194885 }, -- Ohuna Perch
				{ 15, 197719 }, -- Artisan's Sign
				{ 16, 197961 }, -- Whelps on Strings
				{ 17, 197986 }, -- Murglasses
				{ 18, 198039 }, -- Rock of Appreciation
				{ 19, 198090 }, -- Jar of Excess Slime
				{ 20, 198156 }, -- Wyrmhole Generator
				{ 21, 198173 }, -- Atomic Recalibrator
				{ 22, 198206 }, -- Environmental Emulator
				{ 23, 198227 }, -- Giggle Goggles
				{ 24, 198264 }, -- Centralized Precipitation Emitter
				{ 25, 198402 }, -- Maruuk Cooking Pot
				{ 26, 198409 }, -- Personal Shell
				{ 27, 198428 }, -- Tuskarr Dinghy
				{ 28, 198474 }, -- Artist's Easel
				{ 29, 198537 }, -- Taivan's Trumpet
				{ 30, 198646 }, -- Ornate Dragon Statue
				{ 101, 198720 }, -- Soft Purple Pillow
				{ 102, 198721 }, -- Skinny Reliquary Pillow
				{ 103, 198722 }, -- Small Triangular Pillow
				{ 104, 198728 }, -- Explorer's League Banner
				{ 105, 198729 }, -- Reliquary Banner
				{ 106, 198827 }, -- Magical Snow Sled
				{ 107, 198857 }, -- Lucky Duck
				{ 108, 199337 }, -- Bag of Furious Winds
				{ 109, 199554 }, -- S.E.A.T.
				{ 110, 199649 }, -- Dragon Tea Set
				{ 111, 199650 }, -- Whale Bone Tea Set
				{ 112, 199767 }, -- Red Dragon Banner
				{ 113, 199768 }, -- Black Dragon Banner
				{ 114, 199769 }, -- Blue Dragon Banner
				{ 115, 199770 }, -- Bronze Dragon Banner
				{ 116, 199771 }, -- Green Dragon Banner
				{ 117, 199892 }, -- Tuskarr Traveling Soup Pot
				{ 118, 199894 }, -- Fisherman's Folly
				{ 119, 199896 }, -- Rubbery Fish Head
				{ 120, 199897 }, -- Blue-Covered Beanbag
				{ 121, 199899 }, -- Iskaara Tug Sled
				{ 122, 199902 }, -- Wayfinder's Compass
				{ 123, 200116 }, -- Everlasting Horn of Lavaswimming
				{ 124, 200142 }, -- Generous Goblin Grenade
				{ 125, 200148 }, -- A Collection Of Me
				{ 126, 200160 }, -- Notfar's Favorite Food
				{ 127, 200178 }, -- Infected Ichor
				{ 128, 200198 }, -- Primalist Prison
				{ 129, 200249 }, -- Mage's Chewed Wand
				{ 130, 200469 }, -- Khadgar's Disenchanting Rod
				{ 201, 200550 }, -- Very Comfortable Pelt
				{ 202, 200551 }, -- Comfortable Pile of Pelts
				{ 203, 200597 }, -- Lover's Bouquet
				{ 204, 200628 }, -- Somewhat-Stabilized Arcana
				{ 205, 200630 }, -- Ohn'ir Windsage's Hearthstone
				{ 206, 200631 }, -- Happy Tuskarr Palooza
				{ 207, 200636 }, -- Primal Invocation Quintessence
				{ 208, 200640 }, -- Obsidian Egg Clutch
				{ 209, 200707 }, -- Armoire of Endless Cloaks
				{ 210, 200857 }, -- Talisman of Sargha
				{ 211, 200869 }, -- Ohn Lite Branded Horn
				{ 212, 200878 }, -- Wheeled Floaty Boaty Controller
				{ 213, 200926 }, -- Compendium of Love
				{ 214, 200960 }, -- Seed of Renewed Souls
				{ 215, 200999 }, -- The Super Shellkhan Gang
				{ 216, 201435 }, -- Shuffling Sands
				{ 217, 201815 }, -- Cloak of Many Faces
				{ 218, 201927 }, -- Gleaming Arcanocrystal
				{ 219, 201933 }, -- Black Dragon's Challenge Dummy
				{ 220, 202019 }, -- Golden Dragon Goblet
				{ 221, 202021 }, -- Breaker's Flag of Victory
				{ 222, 202022 }, -- Yennu's Kite
				{ 223, 202042 }, -- Aquatic Shades
				{ 224, 202711 }, -- Lost Compass
			},
		},
	},
}

data["TIERSETS"] = {
	name = AL["Tier Sets"],
	ContentType = COLLECTION_CONTENT,
	items = {
		{	-- EVOKER
			name = "|c"..RAID_CLASS_COLORS["EVOKER"]["colorStr"]..ALIL["EVOKER"],
			[NORMAL_DIFF] = {
				{ 1, 200378 }, -- Hauberk of the Awakened
				{ 2, 200379 }, -- Treads of the Awakened
				{ 3, 200380 }, -- Gauntlets of the Awakened
				{ 4, 200381 }, -- Crown of the Awakened
				{ 5, 200382 }, -- Legguards of the Awakened
				{ 6, 200383 }, -- Talons of the Awakened
				{ 7, 200384 }, -- Chain of the Awakened
				{ 8, 200385 }, -- Bracers of the Awakened
				{ 9, 200386 }, -- Shroud of the Awakened
			},
		},
		{ -- DEATHKNIGHT
			name = ATLASLOOT_DEATHKNIGHT_COLOR..ALIL["DEATHKNIGHT"],
			[NORMAL_DIFF] = {
				{ 1, 200405 }, -- Breastplate of the Haunted Frostbrood
				{ 2, 200406 }, -- Sabatons of the Haunted Frostbrood
				{ 3, 200407 }, -- Grasps of the Haunted Frostbrood
				{ 4, 200408 }, -- Maw of the Haunted Frostbrood 
				{ 5, 200409 }, -- Greaves of the Haunted Frostbrood
				{ 6, 200410 }, -- Jaws of the Haunted Frostbrood
				{ 7, 200411 }, -- Girdle of the Haunted Frostbrood
				{ 8, 200412 }, -- Vambraces of the Haunted Frostbrood
				{ 9, 200413 }, -- Drape of the Haunted Frostbrood
			},
		},
		{ -- DEMONHUNTER
			name = ATLASLOOT_DEMONHUNTER_COLOR..ALIL["DEMONHUNTER"],
			[NORMAL_DIFF] = {
				{ 1, 200342 }, -- Skybound Avenger's Harness
				{ 2, 200343 }, -- Skybound Avenger's Boots
				{ 3, 200344 }, -- Skybound Avenger's Grips
				{ 4, 200345 }, -- Skybound Avenger's Visor
				{ 5, 200346 }, -- Skybound Avenger's Legguards
				{ 6, 200347 }, -- Skybound Avenger's Ailerons
				{ 7, 200348 }, -- Skybound Avenger's Waistwrap
				{ 8, 200349 }, -- Skybound Avenger's Wristbands
				{ 9, 200350 }, -- Skybound Avenger's Cape
			},
		},
		{ -- DRUID
			name = ATLASLOOT_DRUID_COLOR..ALIL["DRUID"],
			[NORMAL_DIFF] = {
				{ 1, 200351 }, -- Lost Landcaller's Robes
				{ 2, 200352 }, -- Lost Landcaller's Moccasins
				{ 3, 200353 }, -- Lost Landcaller's Claws
				{ 4, 200354 }, -- Lost Landcaller's Antlers
				{ 5, 200355 }, -- Lost Landcaller's Leggings
				{ 6, 200356 }, -- Lost Landcaller's Mantle
				{ 7, 200357 }, -- Lost Landcaller's Sash
				{ 8, 200358 }, -- Lost Landcaller's Bindings
				{ 9, 200359 }, -- Lost Landcaller's Laena
			},
		},
		{ -- HUNTER
			name = ATLASLOOT_HUNTER_COLOR..ALIL["HUNTER"],
			[NORMAL_DIFF] = {
				{ 1, 200387 }, -- Stormwing Harrier's Cuirass
				{ 2, 200388 }, -- Stormwing Harrier's Sabatons
				{ 3, 200389 }, -- Stormwing Harrier's Handguards
				{ 4, 200390 }, -- Stormwing Harrier's Skullmask
				{ 5, 200391 }, -- Stormwing Harrier's Greaves
				{ 6, 200392 }, -- Stormwing Harrier's Pinions
				{ 7, 200393 }, -- Stormwing Harrier's Belt
				{ 8, 200394 }, -- Stormwing Harrier's Wristguards
				{ 9, 200395 }, -- Stormwing Harrier's Plumage
			},
		},
		{ -- MAGE
			name = ATLASLOOT_MAGE_COLOR..ALIL["MAGE"],
			[NORMAL_DIFF] = {
				{ 1, 200315 }, -- Crystal Scholar's Tunic
				{ 2, 200316 }, -- Crystal Scholar's Footwraps
				{ 3, 200317 }, -- Crystal Scholar's Pageturners
				{ 4, 200318 }, -- Crystal Scholar's Cowl
				{ 5, 200319 }, -- Crystal Scholar's Britches
				{ 6, 200320 }, -- Crystal Scholar's Beacons
				{ 7, 200321 }, -- Crystal Scholar's Cinch
				{ 8, 200322 }, -- Crystal Scholar's Cuffs
				{ 9, 200323 }, -- Crystal Scholar's Cape
			},
		},
		{ -- MONK
			name = ATLASLOOT_MONK_COLOR..ALIL["MONK"],
			[NORMAL_DIFF] = {
				{ 1, 200360 }, -- Chestwrap of the Waking Fist
				{ 2, 200361 }, -- Gaiters of the Waking Fist
				{ 3, 200362 }, -- Palms of the Waking Fist
				{ 4, 200363 }, -- Gaze of the Waking Fist
				{ 5, 200364 }, -- Legguards of the Waking Fist
				{ 6, 200365 }, -- Mantle of the Waking Fist
				{ 7, 200366 }, -- Girdle of the Waking Fist
				{ 8, 200367 }, -- Cuffs of the Waking Fist
				{ 9, 200368 }, -- Drape of the Waking Fist
			},
		},
		{ -- PALADIN
			name = ATLASLOOT_PALADIN_COLOR..ALIL["PALADIN"],
			[NORMAL_DIFF] = {
				{ 1, 200414 }, -- Virtuous Silver Breastplate
				{ 2, 200415 }, -- Virtuous Silver Greatboots
				{ 3, 200416 }, -- Virtuous Silver Gauntlets
				{ 4, 200417 }, -- Virtuous Silver Heaume
				{ 5, 200418 }, -- Virtuous Silver Cuisses
				{ 6, 200419 }, -- Virtuous Silver Pauldrons
				{ 7, 200420 }, -- Virtuous Silver Faulds
				{ 8, 200421 }, -- Virtuous Silver Bracers
				{ 9, 200422 }, -- Virtuous Silver Cloak
			},
		},
		{ -- PRIEST
			name = ATLASLOOT_PRIEST_COLOR..ALIL["PRIEST"],
			[NORMAL_DIFF] = {
				{ 1, 200324 }, -- Draconic Hierophant's Vestment
				{ 2, 200325 }, -- Draconic Hierophant's Slippers
				{ 3, 200326 }, -- Draconic Hierophant's Grips
				{ 4, 200327 }, -- Draconic Hierophant's Archcowl
				{ 5, 200328 }, -- Draconic Hierophant's Britches
				{ 6, 200329 }, -- Draconic Hierophant's Wisdom
				{ 7, 200330 }, -- Draconic Hierophant's Sash
				{ 8, 200331 }, -- Draconic Hierophant's Wristbands
				{ 9, 200332 }, -- Draconic Hierophant's Drape
			},
		},
		{ -- ROGUE
			name = ATLASLOOT_ROGUE_COLOR..ALIL["ROGUE"],
			[NORMAL_DIFF] = {
				{ 1, 200369 }, -- Vault Delver's Brigandine
				{ 2, 200370 }, -- Vault Delver's Shinguards
				{ 3, 200371 }, -- Vault Delver's Lockbreakers
				{ 4, 200372 }, -- Vault Delver's Vizard
				{ 5, 200373 }, -- Vault Delver's Pantaloons
				{ 6, 200374 }, -- Vault Delver's Epaulets
				{ 7, 200375 }, -- Vault Delver's Utility Belt
				{ 8, 200376 }, -- Vault Delver's Sweatbands
				{ 9, 200377 }, -- Vault Delver's Camouflage
			},
		},
		{ -- SHAMAN
			name = ATLASLOOT_SHAMAN_COLOR..ALIL["SHAMAN"],
			[NORMAL_DIFF] = {
				{ 1, 200396 }, -- Robe of Infused Earth
				{ 2, 200397 }, -- Treads of Infused Earth
				{ 3, 200398 }, -- Gauntlets of Infused Earth
				{ 4, 200399 }, -- Faceguard of Infused Earth
				{ 5, 200400 }, -- Leggings of Infused Earth
				{ 6, 200401 }, -- Calderas of Infused Earth
				{ 7, 200402 }, -- Faulds of Infused Earth
				{ 8, 200403 }, -- Cuffs of Infused Earth
				{ 9, 200404 }, -- Greatcloak of Infused Earth
			},
		},
		{ -- WARLOCK
			name = ATLASLOOT_WARLOCK_COLOR..ALIL["WARLOCK"],
			[NORMAL_DIFF] = {
				{ 1, 200333 }, -- Scalesworn Cultist's Frock
				{ 2, 200334 }, -- Scalesworn Cultist's Sandals
				{ 3, 200335 }, -- Scalesworn Cultist's Gloves
				{ 4, 200336 }, -- Scalesworn Cultist's Scorn
				{ 5, 200337 }, -- Scalesworn Cultist's Culottes
				{ 6, 200338 }, -- Scalesworn Cultist's Effigy
				{ 7, 200339 }, -- Scalesworn Cultist's Girdle
				{ 8, 200340 }, -- Scalesworn Cultist's Wristwraps
				{ 9, 200341 }, -- Scalesworn Cultist's Runedrape
			},
		},
		{ -- WARRIOR
			name = ATLASLOOT_WARRIOR_COLOR..ALIL["WARRIOR"],
			[NORMAL_DIFF] = {
				{ 1, 200423 }, -- Husk of the Walking Mountain
				{ 2, 200424 }, -- Boots of the Walking Mountain
				{ 3, 200425 }, -- Gauntlets of the Walking Mountain
				{ 4, 200426 }, -- Casque of the Walking Mountain
				{ 5, 200427 }, -- Poleyns of the Walking Mountain
				{ 6, 200428 }, -- Peaks of the Walking Mountain
				{ 7, 200429 }, -- Core of the Walking Mountain
				{ 8, 200430 }, -- Bracers of the Walking Mountain
				{ 9, 200431 }, -- Drape of the Walking Mountain
			},
		},
	},
}
