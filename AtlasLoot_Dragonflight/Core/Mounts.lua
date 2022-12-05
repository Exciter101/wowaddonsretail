-- $Id: Mounts.lua 9 2022-12-04 07:48:23Z arithmandar $
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
				{  1, 192601, "mount" }, -- Loyal Magmammoth
				{  2, 192761, "mount" }, -- Tamed Skitterfly
				{  3, 192762, "mount" }, -- Azure Skitterfly
				{  4, 192764, "mount" }, -- Verdant Skitterfly
				{  5, 192775, "mount" }, -- Stormhide Salamanther
				{  6, 192777, "mount" }, -- Magmashell
				{  7, 192779 }, -- Scorchpath
				{  8, 192784, "mount" }, -- Shellack
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
				{ 14, 192806, "mount" }, -- Raging Magmammoth
--				{ 22, 192807 }, -- PH Lava Mammoth Yellow
				{ 15, 194034, "mount" }, -- Renewed Proto-Drake
				{ 16, 194106, "mount" }, -- Highland Drake
				{ 17, 194521, "mount" }, -- Cliffside Wylderdrake
				{ 18, 194549, "mount" }, -- Windborne Velocidrake
				{ 19, 194705, "mount" }, -- Highland Drake
				{ 20, 198654, "mount" }, -- Otterworldly Ottuk Carrier
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
		},
	},
}
