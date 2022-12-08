-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select, type = select, type
local string = _G.string
local format = string.format

-- WoW
local UnitFactionGroup = UnitFactionGroup
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local _, private = ...
local AtlasLoot = _G.AtlasLoot
local data = private.data

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

-- change sortorder for factions
local ALLIANCE_DIFF, HORDE_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)
end

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")

local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
