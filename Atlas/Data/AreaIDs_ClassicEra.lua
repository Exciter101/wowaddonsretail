-- $Id: AreaIDs_ClassicEra.lua 423 2022-11-19 07:32:44Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert at gmail dot com>
	Copyright 2010 - Lothaer <lothayer at gmail dot com>, Atlas Team
	Copyright 2011 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]
-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local _G = getfenv(0)

-- Libraries

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local MapData = {}

MapData.AreaToID = {
	["Dun Morogh"] = 1,
	["Longshore"] = 2,
	["Badlands"] = 3,
	["Blasted Lands"] = 4,
	["Blackwater Cove"] = 7,
	["Swamp of Sorrows"] = 8,
	["Northshire Valley"] = 9,
	["Duskwood"] = 10,
	["Wetlands"] = 11,
	["Elwynn Forest"] = 12,
	["The World Tree"] = 13,
	["Durotar"] = 14,
	["Dustwallow Marsh"] = 15,
	["Azshara"] = 16,
	["The Barrens"] = 17,
	["Crystal Lake"] = 18,
	["Zul'Gurub"] = 19,
	["Moonbrook"] = 20,
	["Kul Tiras"] = 21,
	["Programmer Isle"] = 22,
	["Northshire River"] = 23,
	["Northshire Abbey"] = 24,
	["Blackrock Mountain"] = 25,
	["Lighthouse"] = 26,
	["Western Plaguelands"] = 28,
	["Nine"] = 30,
	["The Cemetary"] = 32,
	["Stranglethorn Vale"] = 33,
	["Echo Ridge Mine"] = 34,
	["Booty Bay"] = 35,
	["Alterac Mountains"] = 36,
	["Lake Nazferiti"] = 37,
	["Loch Modan"] = 38,
	["Westfall"] = 40,
	["Deadwind Pass"] = 41,
	["Darkshire"] = 42,
	["Wild Shore"] = 43,
	["Redridge Mountains"] = 44,
	["Arathi Highlands"] = 45,
	["Burning Steppes"] = 46,
	["The Hinterlands"] = 47,
	["Dead Man's Hole"] = 49,
	["Searing Gorge"] = 51,
	["Thieves Camp"] = 53,
	["Jasperlode Mine"] = 54,
	["Valley of Heroes UNUSED"] = 55,
	["Heroes' Vigil"] = 56,
	["Fargodeep Mine"] = 57,
	["Northshire Vineyards"] = 59,
	["Forest's Edge"] = 60,
	["Thunder Falls"] = 61,
	["Brackwell Pumpkin Patch"] = 62,
	["The Stonefield Farm"] = 63,
	["The Maclure Vineyards"] = 64,
	["***On Map Dungeon***"] = 65,
	["***On Map Dungeon***"] = 66,
	["***On Map Dungeon***"] = 67,
	["Lake Everstill"] = 68,
	["Lakeshire"] = 69,
	["Stonewatch"] = 70,
	["Stonewatch Falls"] = 71,
	["The Dark Portal"] = 72,
	["The Tainted Scar"] = 73,
	["Pool of Tears"] = 74,
	["Stonard"] = 75,
	["Fallow Sanctuary"] = 76,
	["Anvilmar"] = 77,
	["Stormwind Mountains"] = 80,
	["Jeff NE Quadrant Changed"] = 81,
	["Jeff NW Quadrant"] = 82,
	["Jeff SE Quadrant"] = 83,
	["Jeff SW Quadrant"] = 84,
	["Tirisfal Glades"] = 85,
	["Stone Cairn Lake"] = 86,
	["Goldshire"] = 87,
	["Eastvale Logging Camp"] = 88,
	["Mirror Lake Orchard"] = 89,
	["Tower of Azora"] = 91,
	["Mirror Lake"] = 92,
	["Vul'Gol Ogre Mound"] = 93,
	["Raven Hill"] = 94,
	["Redridge Canyons"] = 95,
	["Tower of Ilgalar"] = 96,
	["Alther's Mill"] = 97,
	["Rethban Caverns"] = 98,
	["Rebel Camp"] = 99,
	["Nesingwary's Expedition"] = 100,
	["Kurzen's Compound"] = 101,
	["Ruins of Zul'Kunda"] = 102,
	["Ruins of Zul'Mamwe"] = 103,
	["The Vile Reef"] = 104,
	["Mosh'Ogg Ogre Mound"] = 105,
	["The Stockpile"] = 106,
	["Saldean's Farm"] = 107,
	["Sentinel Hill"] = 108,
	["Furlbrow's Pumpkin Farm"] = 109,
	["Jangolode Mine"] = 111,
	["Gold Coast Quarry"] = 113,
	["Westfall Lighthouse"] = 115,
	["Misty Valley"] = 116,
	["Grom'gol Base Camp"] = 117,
	["Whelgar's Excavation Site"] = 118,
	["Westbrook Garrison"] = 120,
	["Tranquil Gardens Cemetery"] = 121,
	["Zuuldaia Ruins"] = 122,
	["Bal'lal Ruins"] = 123,
	["Kal'ai Ruins"] = 125,
	["Tkashi Ruins"] = 126,
	["Balia'mah Ruins"] = 127,
	["Ziata'jai Ruins"] = 128,
	["Mizjah Ruins"] = 129,
	["Silverpine Forest"] = 130,
	["Kharanos"] = 131,
	["Coldridge Valley"] = 132,
	["Gnomeregan"] = 133,
	["Gol'Bolar Quarry"] = 134,
	["Frostmane Hold"] = 135,
	["The Grizzled Den"] = 136,
	["Brewnall Village"] = 137,
	["Misty Pine Refuge"] = 138,
	["Eastern Plaguelands"] = 139,
	["Teldrassil"] = 141,
	["Ironband's Excavation Site"] = 142,
	["Mo'grosh Stronghold"] = 143,
	["Thelsamar"] = 144,
	["Algaz Gate"] = 145,
	["Stonewrought Dam"] = 146,
	["The Farstrider Lodge"] = 147,
	["Darkshore"] = 148,
	["Silver Stream Mine"] = 149,
	["Menethil Harbor"] = 150,
	["Designer Island"] = 151,
	["The Bulwark"] = 152,
	["Ruins of Lordaeron"] = 153,
	["Deathknell"] = 154,
	["Night Web's Hollow"] = 155,
	["Solliden Farmstead"] = 156,
	["Agamand Mills"] = 157,
	["Agamand Family Crypt"] = 158,
	["Brill"] = 159,
	["Whispering Gardens"] = 160,
	["Terrace of Repose"] = 161,
	["Brightwater Lake"] = 162,
	["Gunther's Retreat"] = 163,
	["Garren's Haunt"] = 164,
	["Balnir Farmstead"] = 165,
	["Cold Hearth Manor"] = 166,
	["Crusader Outpost"] = 167,
	["The North Coast"] = 168,
	["Whispering Shore"] = 169,
	["Lordamere Lake"] = 170,
	["Fenris Isle"] = 172,
	["Faol's Rest"] = 173,
	["Dolanaar"] = 186,
	["Darnassus UNUSED"] = 187,
	["Shadowglen"] = 188,
	["Steelgrill's Depot"] = 189,
	["Hearthglen"] = 190,
	["Northridge Lumber Camp"] = 192,
	["Ruins of Andorhal"] = 193,
	["School of Necromancy"] = 195,
	["Uther's Tomb"] = 196,
	["Sorrow Hill"] = 197,
	["The Weeping Cave"] = 198,
	["Felstone Field"] = 199,
	["Dalson's Tears"] = 200,
	["Gahrron's Withering"] = 201,
	["The Writhing Haunt"] = 202,
	["Mardenholde Keep"] = 203,
	["Pyrewood Village"] = 204,
	["Dun Modr"] = 205,
	["Westfall"] = 206,
	["The Great Sea"] = 207,
	["Unused Ironcladcove"] = 208,
	["Shadowfang Keep"] = 209,
	["***On Map Dungeon***"] = 210,
	["Iceflow Lake"] = 211,
	["Helm's Bed Lake"] = 212,
	["Deep Elem Mine"] = 213,
	["The Great Sea"] = 214,
	["Mulgore"] = 215,
	["Alexston Farmstead"] = 219,
	["Red Cloud Mesa"] = 220,
	["Camp Narache"] = 221,
	["Bloodhoof Village"] = 222,
	["Stonebull Lake"] = 223,
	["Ravaged Caravan"] = 224,
	["Red Rocks"] = 225,
	["The Skittering Dark"] = 226,
	["Valgan's Field"] = 227,
	["The Sepulcher"] = 228,
	["Olsen's Farthing"] = 229,
	["The Greymane Wall"] = 230,
	["Beren's Peril"] = 231,
	["The Dawning Isles"] = 232,
	["Ambermill"] = 233,
	["Fenris Keep"] = 235,
	["Shadowfang Keep"] = 236,
	["The Decrepit Ferry"] = 237,
	["Malden's Orchard"] = 238,
	["The Ivar Patch"] = 239,
	["The Dead Field"] = 240,
	["The Rotting Orchard"] = 241,
	["Brightwood Grove"] = 242,
	["Forlorn Rowe"] = 243,
	["The Whipple Estate"] = 244,
	["The Yorgen Farmstead"] = 245,
	["The Cauldron"] = 246,
	["Grimesilt Dig Site"] = 247,
	["Dreadmaul Rock"] = 249,
	["Ruins of Thaurissan"] = 250,
	["Flame Crest"] = 251,
	["Blackrock Stronghold"] = 252,
	["The Pillar of Ash"] = 253,
	["Blackrock Mountain"] = 254,
	["Altar of Storms"] = 255,
	["Aldrassil"] = 256,
	["Shadowthread Cave"] = 257,
	["Fel Rock"] = 258,
	["Lake Al'Ameth"] = 259,
	["Starbreeze Village"] = 260,
	["Gnarlpine Hold"] = 261,
	["Ban'ethil Barrow Den"] = 262,
	["The Cleft"] = 263,
	["The Oracle Glade"] = 264,
	["Wellspring River"] = 265,
	["Wellspring Lake"] = 266,
	["Hillsbrad Foothills"] = 267,
	["Azshara Crater"] = 268,
	["Dun Algaz"] = 269,
	["Southshore"] = 271,
	["Tarren Mill"] = 272,
	["Durnholde Keep"] = 275,
	["UNUSED Stonewrought Pass"] = 276,
	["The Foothill Caverns"] = 277,
	["Lordamere Internment Camp"] = 278,
	["Dalaran"] = 279,
	["Strahnbrad"] = 280,
	["Ruins of Alterac"] = 281,
	["Crushridge Hold"] = 282,
	["Slaughter Hollow"] = 283,
	["The Uplands"] = 284,
	["Southpoint Tower"] = 285,
	["Hillsbrad Fields"] = 286,
	["Hillsbrad"] = 287,
	["Azurelode Mine"] = 288,
	["Nethander Stead"] = 289,
	["Dun Garok"] = 290,
	["Thoradin's Wall"] = 293,
	["Eastern Strand"] = 294,
	["Western Strand"] = 295,
	["South Seas UNUSED"] = 296,
	["Jaguero Isle"] = 297,
	["Baradin Bay"] = 298,
	["Menethil Bay"] = 299,
	["Misty Reed Strand"] = 300,
	["The Savage Coast"] = 301,
	["The Crystal Shore"] = 302,
	["Shell Beach"] = 303,
	["North Tide's Run"] = 305,
	["South Tide's Run"] = 306,
	["The Overlook Cliffs"] = 307,
	["The Forbidding Sea"] = 308,
	["Ironbeard's Tomb"] = 309,
	["Crystalvein Mine"] = 310,
	["Ruins of Aboraz"] = 311,
	["Janeiro's Point"] = 312,
	["Northfold Manor"] = 313,
	["Go'Shek Farm"] = 314,
	["Dabyrie's Farmstead"] = 315,
	["Boulderfist Hall"] = 316,
	["Witherbark Village"] = 317,
	["Drywhisker Gorge"] = 318,
	["Refuge Pointe"] = 320,
	["Hammerfall"] = 321,
	["Blackwater Shipwrecks"] = 322,
	["O'Breen's Camp"] = 323,
	["Stromgarde Keep"] = 324,
	["The Tower of Arathor"] = 325,
	["The Sanctum"] = 326,
	["Faldir's Cove"] = 327,
	["The Drowned Reef"] = 328,
	["Thandol Span"] = 330,
	["Ashenvale"] = 331,
	["The Great Sea"] = 332,
	["Circle of East Binding"] = 333,
	["Circle of West Binding"] = 334,
	["Circle of Inner Binding"] = 335,
	["Circle of Outer Binding"] = 336,
	["Apocryphan's Rest"] = 337,
	["Angor Fortress"] = 338,
	["Lethlor Ravine"] = 339,
	["Kargath"] = 340,
	["Camp Kosh"] = 341,
	["Camp Boff"] = 342,
	["Camp Wurg"] = 343,
	["Camp Cagg"] = 344,
	["Agmond's End"] = 345,
	["Hammertoe's Digsite"] = 346,
	["Dustbelch Grotto"] = 347,
	["Aerie Peak"] = 348,
	["Wildhammer Keep"] = 349,
	["Quel'Danil Lodge"] = 350,
	["Skulk Rock"] = 351,
	["Zun'watha"] = 352,
	["Shadra'Alor"] = 353,
	["Jintha'Alor"] = 354,
	["The Altar of Zul"] = 355,
	["Seradane"] = 356,
	["Feralas"] = 357,
	["Brambleblade Ravine"] = 358,
	["Bael Modan"] = 359,
	["The Venture Co. Mine"] = 360,
	["Felwood"] = 361,
	["Razor Hill"] = 362,
	["Valley of Trials"] = 363,
	["The Den"] = 364,
	["Burning Blade Coven"] = 365,
	["Kolkar Crag"] = 366,
	["Sen'jin Village"] = 367,
	["Echo Isles"] = 368,
	["Thunder Ridge"] = 369,
	["Drygulch Ravine"] = 370,
	["Dustwind Cave"] = 371,
	["Tiragarde Keep"] = 372,
	["Scuttle Coast"] = 373,
	["Bladefist Bay"] = 374,
	["Deadeye Shore"] = 375,
	["Southfury River"] = 377,
	["Camp Taurajo"] = 378,
	["Far Watch Post"] = 379,
	["The Crossroads"] = 380,
	["Boulder Lode Mine"] = 381,
	["The Sludge Fen"] = 382,
	["The Dry Hills"] = 383,
	["Dreadmist Peak"] = 384,
	["Northwatch Hold"] = 385,
	["The Forgotten Pools"] = 386,
	["Lushwater Oasis"] = 387,
	["The Stagnant Oasis"] = 388,
	["Field of Giants"] = 390,
	["The Merchant Coast"] = 391,
	["Ratchet"] = 392,
	["Darkspear Strand"] = 393,
	["Darrowmere Lake UNUSED"] = 394,
	["Caer Darrow UNUSED"] = 395,
	["Winterhoof Water Well"] = 396,
	["Thunderhorn Water Well"] = 397,
	["Wildmane Water Well"] = 398,
	["Skyline Ridge"] = 399,
	["Thousand Needles"] = 400,
	["The Tidus Stair"] = 401,
	["Shady Rest Inn"] = 403,
	["Bael'dun Digsite"] = 404,
	["Desolace"] = 405,
	["Stonetalon Mountains"] = 406,
	["Orgrimmar UNUSED"] = 407,
	["Gillijim's Isle"] = 408,
	["Island of Doctor Lapidis"] = 409,
	["Razorwind Canyon"] = 410,
	["Bathran's Haunt"] = 411,
	["The Ruins of Ordil'Aran"] = 412,
	["Maestra's Post"] = 413,
	["The Zoram Strand"] = 414,
	["Astranaar"] = 415,
	["The Shrine of Aessina"] = 416,
	["Fire Scar Shrine"] = 417,
	["The Ruins of Stardust"] = 418,
	["The Howling Vale"] = 419,
	["Silverwind Refuge"] = 420,
	["Mystral Lake"] = 421,
	["Fallen Sky Lake"] = 422,
	["Iris Lake"] = 424,
	["Moonwell"] = 425,
	["Raynewood Retreat"] = 426,
	["The Shady Nook"] = 427,
	["Night Run"] = 428,
	["Xavian"] = 429,
	["Satyrnaar"] = 430,
	["Splintertree Post"] = 431,
	["The Dor'Danil Barrow Den"] = 432,
	["Falfarren River"] = 433,
	["Felfire Hill"] = 434,
	["Demon Fall Canyon"] = 435,
	["Demon Fall Ridge"] = 436,
	["Warsong Lumber Camp"] = 437,
	["Bough Shadow"] = 438,
	["The Shimmering Flats"] = 439,
	["Tanaris"] = 440,
	["Lake Falathim"] = 441,
	["Auberdine"] = 442,
	["Ruins of Mathystra"] = 443,
	["Tower of Althalaxx"] = 444,
	["Cliffspring Falls"] = 445,
	["Bashal'Aran"] = 446,
	["Ameth'Aran"] = 447,
	["Grove of the Ancients"] = 448,
	["The Master's Glaive"] = 449,
	["Remtravel's Excavation"] = 450,
	["Mist's Edge"] = 452,
	["The Long Wash"] = 453,
	["Wildbend River"] = 454,
	["Blackwood Den"] = 455,
	["Cliffspring River"] = 456,
	["The Veiled Sea"] = 457,
	["Gold Road"] = 458,
	["Scarlet Watch Post"] = 459,
	["Sun Rock Retreat"] = 460,
	["Windshear Crag"] = 461,
	["Cragpool Lake"] = 463,
	["Mirkfallon Lake"] = 464,
	["The Charred Vale"] = 465,
	["Valley of the Bloodfuries"] = 466,
	["Stonetalon Peak"] = 467,
	["The Talon Den"] = 468,
	["Greatwood Vale"] = 469,
	["Thunder Bluff UNUSED"] = 470,
	["Brave Wind Mesa"] = 471,
	["Fire Stone Mesa"] = 472,
	["Mantle Rock"] = 473,
	["Hunter Rise UNUSED"] = 474,
	["Spirit RiseUNUSED"] = 475,
	["Elder RiseUNUSED"] = 476,
	["Ruins of Jubuwal"] = 477,
	["Pools of Arlithrien"] = 478,
	["The Rustmaul Dig Site"] = 479,
	["Camp E'thok"] = 480,
	["Splithoof Crag"] = 481,
	["Highperch"] = 482,
	["The Screeching Canyon"] = 483,
	["Freewind Post"] = 484,
	["The Great Lift"] = 485,
	["Galak Hold"] = 486,
	["Roguefeather Den"] = 487,
	["The Weathered Nook"] = 488,
	["Thalanaar"] = 489,
	["Un'Goro Crater"] = 490,
	["Razorfen Kraul"] = 491,
	["Raven Hill Cemetery"] = 492,
	["Moonglade"] = 493,
	["DELETE ME"] = 495,
	["Brackenwall Village"] = 496,
	["Swamplight Manor"] = 497,
	["Bloodfen Burrow"] = 498,
	["Darkmist Cavern"] = 499,
	["Moggle Point"] = 500,
	["Beezil's Wreck"] = 501,
	["Witch Hill"] = 502,
	["Sentry Point"] = 503,
	["North Point Tower"] = 504,
	["West Point Tower"] = 505,
	["Lost Point"] = 506,
	["Bluefen"] = 507,
	["Stonemaul Ruins"] = 508,
	["The Den of Flame"] = 509,
	["The Dragonmurk"] = 510,
	["Wyrmbog"] = 511,
	["Onyxia's Lair UNUSED"] = 512,
	["Theramore Isle"] = 513,
	["Foothold Citadel"] = 514,
	["Ironclad Prison"] = 515,
	["Dustwallow Bay"] = 516,
	["Tidefury Cove"] = 517,
	["Dreadmurk Shore"] = 518,
	["Addle's Stead"] = 536,
	["Fire Plume Ridge"] = 537,
	["Lakkari Tar Pits"] = 538,
	["Terror Run"] = 539,
	["The Slithering Scar"] = 540,
	["Marshal's Refuge"] = 541,
	["Fungal Rock"] = 542,
	["Golakka Hot Springs"] = 543,
	["The Loch"] = 556,
	["Beggar's Haunt"] = 576,
	["Kodo Graveyard"] = 596,
	["Ghost Walker Post"] = 597,
	["Sar'theris Strand"] = 598,
	["Thunder Axe Fortress"] = 599,
	["Bolgan's Hole"] = 600,
	["Mannoroc Coven"] = 602,
	["Sargeron"] = 603,
	["Magram Village"] = 604,
	["Gelkis Village"] = 606,
	["Valley of Spears"] = 607,
	["Nijel's Point"] = 608,
	["Kolkar Village"] = 609,
	["Hyjal"] = 616,
	["Winterspring"] = 618,
	["Blackwolf River"] = 636,
	["Kodo Rock"] = 637,
	["Hidden Path"] = 638,
	["Spirit Rock"] = 639,
	["Shrine of the Dormant Flame"] = 640,
	["Lake Elune'ara"] = 656,
	["The Harborage"] = 657,
	["Outland"] = 676,
	["Craftsmen's Terrace UNUSED"] = 696,
	["Tradesmen's Terrace UNUSED"] = 697,
	["The Temple Gardens UNUSED"] = 698,
	["Temple of Elune UNUSED"] = 699,
	["Cenarion Enclave UNUSED"] = 700,
	["Warrior's Terrace UNUSED"] = 701,
	["Rut'theran Village"] = 702,
	["Ironband's Compound"] = 716,
	["The Stockade"] = 717,
	["Wailing Caverns"] = 718,
	["Blackfathom Deeps"] = 719,
	["Fray Island"] = 720,
	["Gnomeregan"] = 721,
	["Razorfen Downs"] = 722,
	["Ban'ethil Hollow"] = 736,
	["Scarlet Monastery"] = 796,
	["Jerod's Landing"] = 797,
	["Ridgepoint Tower"] = 798,
	["The Darkened Bank"] = 799,
	["Coldridge Pass"] = 800,
	["Chill Breeze Valley"] = 801,
	["Shimmer Ridge"] = 802,
	["Amberstill Ranch"] = 803,
	["The Tundrid Hills"] = 804,
	["South Gate Pass"] = 805,
	["South Gate Outpost"] = 806,
	["North Gate Pass"] = 807,
	["North Gate Outpost"] = 808,
	["Gates of Ironforge"] = 809,
	["Stillwater Pond"] = 810,
	["Nightmare Vale"] = 811,
	["Venomweb Vale"] = 812,
	["The Bulwark"] = 813,
	["Southfury River"] = 814,
	["Southfury River"] = 815,
	["Razormane Grounds"] = 816,
	["Skull Rock"] = 817,
	["Palemane Rock"] = 818,
	["Windfury Ridge"] = 819,
	["The Golden Plains"] = 820,
	["The Rolling Plains"] = 821,
	["Dun Algaz"] = 836,
	["Dun Algaz"] = 837,
	["North Gate Pass"] = 838,
	["South Gate Pass"] = 839,
	["Twilight Grove"] = 856,
	["GM Island"] = 876,
	["Delete ME"] = 877,
	["Southfury River"] = 878,
	["Southfury River"] = 879,
	["Thandol Span"] = 880,
	["Thandol Span"] = 881,
	["Purgation Isle"] = 896,
	["The Jansen Stead"] = 916,
	["The Dead Acre"] = 917,
	["The Molsen Farm"] = 918,
	["Stendel's Pond"] = 919,
	["The Dagger Hills"] = 920,
	["Demont's Place"] = 921,
	["The Dust Plains"] = 922,
	["Stonesplinter Valley"] = 923,
	["Valley of Kings"] = 924,
	["Algaz Station"] = 925,
	["Bucklebree Farm"] = 926,
	["The Shining Strand"] = 927,
	["North Tide's Hollow"] = 928,
	["Grizzlepaw Ridge"] = 936,
	["The Verdant Fields"] = 956,
	["Gadgetzan"] = 976,
	["Steamwheedle Port"] = 977,
	["Zul'Farrak"] = 978,
	["Sandsorrow Watch"] = 979,
	["Thistleshrub Valley"] = 980,
	["The Gaping Chasm"] = 981,
	["The Noxious Lair"] = 982,
	["Dunemaul Compound"] = 983,
	["Eastmoon Ruins"] = 984,
	["Waterspring Field"] = 985,
	["Zalashji's Den"] = 986,
	["Land's End Beach"] = 987,
	["Wavestrider Beach"] = 988,
	["Uldum"] = 989,
	["Valley of the Watchers"] = 990,
	["Gunstan's Post"] = 991,
	["Southmoon Ruins"] = 992,
	["Render's Camp"] = 996,
	["Render's Valley"] = 997,
	["Render's Rock"] = 998,
	["Stonewatch Tower"] = 999,
	["Galardell Valley"] = 1000,
	["Lakeridge Highway"] = 1001,
	["Three Corners"] = 1002,
	["Direforge Hill"] = 1016,
	["Raptor Ridge"] = 1017,
	["Black Channel Marsh"] = 1018,
	["The Green Belt"] = 1019,
	["Mosshide Fen"] = 1020,
	["Thelgen Rock"] = 1021,
	["Bluegill Marsh"] = 1022,
	["Saltspray Glen"] = 1023,
	["Sundown Marsh"] = 1024,
	["The Green Belt"] = 1025,
	["Angerfang Encampment"] = 1036,
	["Grim Batol"] = 1037,
	["Dragonmaw Gates"] = 1038,
	["The Lost Fleet"] = 1039,
	["Darrow Hill"] = 1056,
	["Thoradin's Wall"] = 1057,
	["Webwinder Path"] = 1076,
	["The Hushed Bank"] = 1097,
	["Manor Mistmantle"] = 1098,
	["Camp Mojache"] = 1099,
	["Grimtotem Compound"] = 1100,
	["The Writhing Deep"] = 1101,
	["Wildwind Lake"] = 1102,
	["Gordunni Outpost"] = 1103,
	["Mok'Gordun"] = 1104,
	["Feral Scar Vale"] = 1105,
	["Frayfeather Highlands"] = 1106,
	["Idlewind Lake"] = 1107,
	["The Forgotten Coast"] = 1108,
	["East Pillar"] = 1109,
	["West Pillar"] = 1110,
	["Dream Bough"] = 1111,
	["Jademir Lake"] = 1112,
	["Oneiros"] = 1113,
	["Ruins of Ravenwind"] = 1114,
	["Rage Scar Hold"] = 1115,
	["Feathermoon Stronghold"] = 1116,
	["Ruins of Solarsal"] = 1117,
	["Lower Wilds UNUSED"] = 1118,
	["The Twin Colossals"] = 1119,
	["Sardor Isle"] = 1120,
	["Isle of Dread"] = 1121,
	["High Wilderness"] = 1136,
	["Lower Wilds"] = 1137,
	["Southern Barrens"] = 1156,
	["Southern Gold Road"] = 1157,
	["Zul'Farrak"] = 1176,
	["UNUSEDAlcaz Island"] = 1196,
	["Timbermaw Hold"] = 1216,
	["Vanndir Encampment"] = 1217,
	["TESTAzshara"] = 1218,
	["Legash Encampment"] = 1219,
	["Thalassian Base Camp"] = 1220,
	["Ruins of Eldarath "] = 1221,
	["Hetaera's Clutch"] = 1222,
	["Temple of Zin-Malor"] = 1223,
	["Bear's Head"] = 1224,
	["Ursolan"] = 1225,
	["Temple of Arkkoran"] = 1226,
	["Bay of Storms"] = 1227,
	["The Shattered Strand"] = 1228,
	["Tower of Eldara"] = 1229,
	["Jagged Reef"] = 1230,
	["Southridge Beach"] = 1231,
	["Ravencrest Monument"] = 1232,
	["Forlorn Ridge"] = 1233,
	["Lake Mennar"] = 1234,
	["Shadowsong Shrine"] = 1235,
	["Haldarr Encampment"] = 1236,
	["Valormok"] = 1237,
	["The Ruined Reaches"] = 1256,
	["The Talondeep Path"] = 1276,
	["The Talondeep Path"] = 1277,
	["Rocktusk Farm"] = 1296,
	["Jaggedswine Farm"] = 1297,
	["Razorfen Downs"] = 1316,
	["Lost Rigger Cove"] = 1336,
	["Uldaman"] = 1337,
	["Lordamere Lake"] = 1338,
	["Lordamere Lake"] = 1339,
	["Gallows' Corner"] = 1357,
	["Silithus"] = 1377,
	["Emerald Forest"] = 1397,
	["Sunken Temple"] = 1417,
	["Dreadmaul Hold"] = 1437,
	["Nethergarde Keep"] = 1438,
	["Dreadmaul Post"] = 1439,
	["Serpent's Coil"] = 1440,
	["Altar of Storms"] = 1441,
	["Firewatch Ridge"] = 1442,
	["The Slag Pit"] = 1443,
	["The Sea of Cinders"] = 1444,
	["Blackrock Mountain"] = 1445,
	["Thorium Point"] = 1446,
	["Garrison Armory"] = 1457,
	["The Temple of Atal'Hakkar"] = 1477,
	["Undercity"] = 1497,
	["Uldaman"] = 1517,
	["Not Used Deadmines"] = 1518,
	["Stormwind City"] = 1519,
	["Ironforge"] = 1537,
	["Splithoof Hold"] = 1557,
	["The Cape of Stranglethorn"] = 1577,
	["Southern Savage Coast"] = 1578,
	["Unused The Deadmines 002"] = 1579,
	["Unused Ironclad Cove 003"] = 1580,
	["The Deadmines"] = 1581,
	["Ironclad Cove"] = 1582,
	["Blackrock Spire"] = 1583,
	["Blackrock Depths"] = 1584,
	["Raptor Grounds UNUSED"] = 1597,
	["Grol'dom Farm UNUSED"] = 1598,
	["Mor'shan Base Camp"] = 1599,
	["Honor's Stand UNUSED"] = 1600,
	["Blackthorn Ridge UNUSED"] = 1601,
	["Bramblescar UNUSED"] = 1602,
	["Agama'gor UNUSED"] = 1603,
	["Valley of Heroes"] = 1617,
	["Orgrimmar"] = 1637,
	["Thunder Bluff"] = 1638,
	["Elder Rise"] = 1639,
	["Spirit Rise"] = 1640,
	["Hunter Rise"] = 1641,
	["Darnassus"] = 1657,
	["Cenarion Enclave"] = 1658,
	["Craftsmen's Terrace"] = 1659,
	["Warrior's Terrace"] = 1660,
	["The Temple Gardens"] = 1661,
	["Tradesmen's Terrace"] = 1662,
	["Gavin's Naze"] = 1677,
	["Sofera's Naze"] = 1678,
	["Corrahn's Dagger"] = 1679,
	["The Headland"] = 1680,
	["Misty Shore"] = 1681,
	["Dandred's Fold"] = 1682,
	["Growless Cave"] = 1683,
	["Chillwind Point"] = 1684,
	["Raptor Grounds"] = 1697,
	["Bramblescar"] = 1698,
	["Thorn Hill"] = 1699,
	["Agama'gor"] = 1700,
	["Blackthorn Ridge"] = 1701,
	["Honor's Stand"] = 1702,
	["The Mor'shan Rampart"] = 1703,
	["Grol'dom Farm"] = 1704,
	["Razorfen Kraul"] = 1717,
	["The Great Lift"] = 1718,
	["Mistvale Valley"] = 1737,
	["Nek'mani Wellspring"] = 1738,
	["Bloodsail Compound"] = 1739,
	["Venture Co. Base Camp"] = 1740,
	["Gurubashi Arena"] = 1741,
	["Spirit Den"] = 1742,
	["The Crimson Veil"] = 1757,
	["The Riptide"] = 1758,
	["The Damsel's Luck"] = 1759,
	["Venture Co. Operations Center"] = 1760,
	["Deadwood Village"] = 1761,
	["Felpaw Village"] = 1762,
	["Jaedenar"] = 1763,
	["Bloodvenom River"] = 1764,
	["Bloodvenom Falls"] = 1765,
	["Shatter Scar Vale"] = 1766,
	["Irontree Woods"] = 1767,
	["Irontree Cavern"] = 1768,
	["Timbermaw Hold"] = 1769,
	["Shadow Hold"] = 1770,
	["Shrine of the Deceiver"] = 1771,
	["Itharius's Cave"] = 1777,
	["Sorrowmurk"] = 1778,
	["Draenil'dur Village"] = 1779,
	["Splinterspear Junction"] = 1780,
	["Stagalbog"] = 1797,
	["The Shifting Mire"] = 1798,
	["Stagalbog Cave"] = 1817,
	["Witherbark Caverns"] = 1837,
	["Thoradin's Wall"] = 1857,
	["Boulder'gor"] = 1858,
	["Valley of Fangs"] = 1877,
	["The Dustbowl"] = 1878,
	["Mirage Flats"] = 1879,
	["Featherbeard's Hovel"] = 1880,
	["Shindigger's Camp"] = 1881,
	["Plaguemist Ravine"] = 1882,
	["Valorwind Lake"] = 1883,
	["Agol'watha"] = 1884,
	["Hiri'watha"] = 1885,
	["The Creeping Ruin"] = 1886,
	["Bogen's Ledge"] = 1887,
	["The Maker's Terrace"] = 1897,
	["Dustwind Gulch"] = 1898,
	["Shaol'watha"] = 1917,
	["Noonshade Ruins"] = 1937,
	["Broken Pillar"] = 1938,
	["Abyssal Sands"] = 1939,
	["Southbreak Shore"] = 1940,
	["Caverns of Time"] = 1941,
	["The Marshlands"] = 1942,
	["Ironstone Plateau"] = 1943,
	["Blackchar Cave"] = 1957,
	["Tanner Camp"] = 1958,
	["Dustfire Valley"] = 1959,
	["Zul'Gurub"] = 1977,
	["Misty Reed Post"] = 1978,
	["Bloodvenom Post "] = 1997,
	["Talonbranch Glade "] = 1998,
	["Stratholme"] = 2017,
	["UNUSEDShadowfang Keep 003"] = 2037,
	["Scholomance"] = 2057,
	["Twilight Vale"] = 2077,
	["Twilight Shore"] = 2078,
	["Alcaz Island"] = 2079,
	["Darkcloud Pinnacle"] = 2097,
	["Dawning Wood Catacombs"] = 2098,
	["Stonewatch Keep"] = 2099,
	["Maraudon"] = 2100,
	["Stoutlager Inn"] = 2101,
	["Thunderbrew Distillery"] = 2102,
	["Menethil Keep"] = 2103,
	["Deepwater Tavern"] = 2104,
	["Shadow Grave"] = 2117,
	["Brill Town Hall"] = 2118,
	["Gallows' End Tavern"] = 2119,
	["The Pools of VisionUNUSED"] = 2137,
	["Dreadmist Den"] = 2138,
	["Bael'dun Keep"] = 2157,
	["Emberstrife's Den"] = 2158,
	["Onyxia's Lair"] = 2159,
	["Windshear Mine"] = 2160,
	["Roland's Doom"] = 2161,
	["Battle Ring"] = 2177,
	["The Pools of Vision"] = 2197,
	["Shadowbreak Ravine"] = 2198,
	["Broken Spear Village"] = 2217,
	["Whitereach Post"] = 2237,
	["Gornia"] = 2238,
	["Zane's Eye Crater"] = 2239,
	["Mirage Raceway"] = 2240,
	["Frostsaber Rock"] = 2241,
	["The Hidden Grove"] = 2242,
	["Timbermaw Post"] = 2243,
	["Winterfall Village"] = 2244,
	["Mazthoril"] = 2245,
	["Frostfire Hot Springs"] = 2246,
	["Ice Thistle Hills"] = 2247,
	["Dun Mandarr"] = 2248,
	["Frostwhisper Gorge"] = 2249,
	["Owl Wing Thicket"] = 2250,
	["Lake Kel'Theril"] = 2251,
	["The Ruins of Kel'Theril"] = 2252,
	["Starfall Village"] = 2253,
	["Ban'Thallow Barrow Den"] = 2254,
	["Everlook"] = 2255,
	["Darkwhisper Gorge"] = 2256,
	["Deeprun Tram"] = 2257,
	["The Fungal Vale"] = 2258,
	["UNUSEDThe Marris Stead"] = 2259,
	["The Marris Stead"] = 2260,
	["The Undercroft"] = 2261,
	["Darrowshire"] = 2262,
	["Crown Guard Tower"] = 2263,
	["Corin's Crossing"] = 2264,
	["Scarlet Base Camp"] = 2265,
	["Tyr's Hand"] = 2266,
	["The Scarlet Basilica"] = 2267,
	["Light's Hope Chapel"] = 2268,
	["Browman Mill"] = 2269,
	["The Noxious Glade"] = 2270,
	["Eastwall Tower"] = 2271,
	["Northdale"] = 2272,
	["Zul'Mashar"] = 2273,
	["Mazra'Alor"] = 2274,
	["Northpass Tower"] = 2275,
	["Quel'Lithien Lodge"] = 2276,
	["Plaguewood"] = 2277,
	["Scourgehold"] = 2278,
	["Stratholme"] = 2279,
	["UNUSED Stratholme"] = 2280,
	["Darrowmere Lake"] = 2297,
	["Caer Darrow"] = 2298,
	["Darrowmere Lake"] = 2299,
	["Caverns of Time"] = 2300,
	["Thistlefur Village"] = 2301,
	["The Quagmire"] = 2302,
	["Windbreak Canyon"] = 2303,
	["South Seas"] = 2317,
	["The Great Sea"] = 2318,
	["The Great Sea"] = 2319,
	["The Great Sea"] = 2320,
	["The Great Sea"] = 2321,
	["The Veiled Sea"] = 2322,
	["The Veiled Sea"] = 2323,
	["The Veiled Sea"] = 2324,
	["The Veiled Sea"] = 2325,
	["The Veiled Sea"] = 2326,
	["Razor Hill Barracks"] = 2337,
	["South Seas"] = 2338,
	["The Great Sea"] = 2339,
	["Bloodtooth Camp"] = 2357,
	["Forest Song"] = 2358,
	["Greenpaw Village"] = 2359,
	["Silverwing Outpost"] = 2360,
	["Nighthaven"] = 2361,
	["Shrine of Remulos"] = 2362,
	["Stormrage Barrow Dens"] = 2363,
	["The Great Sea"] = 2364,
	["The Great Sea"] = 2365,
	["The Black Morass"] = 2366,
	["Old Hillsbrad Foothills"] = 2367,
	["Tarren Mill"] = 2368,
	["Southshore"] = 2369,
	["Durnholde Keep"] = 2370,
	["Dun Garok"] = 2371,
	["Hillsbrad Fields"] = 2372,
	["Eastern Strand"] = 2373,
	["Nethander Stead"] = 2374,
	["Darrow Hill"] = 2375,
	["Southpoint Tower"] = 2376,
	["Thoradin's Wall"] = 2377,
	["Western Strand"] = 2378,
	["Azurelode Mine"] = 2379,
	["The Great Sea"] = 2397,
	["The Great Sea"] = 2398,
	["The Great Sea"] = 2399,
	["The Forbidding Sea"] = 2400,
	["The Forbidding Sea"] = 2401,
	["The Forbidding Sea"] = 2402,
	["The Forbidding Sea"] = 2403,
	["Tethris Aran"] = 2404,
	["Ethel Rethor"] = 2405,
	["Ranazjar Isle"] = 2406,
	["Kormek's Hut"] = 2407,
	["Shadowprey Village"] = 2408,
	["Blackrock Pass"] = 2417,
	["Morgan's Vigil"] = 2418,
	["Slither Rock"] = 2419,
	["Terror Wing Path"] = 2420,
	["Draco'dar"] = 2421,
	["Ragefire Chasm"] = 2437,
	["Nightsong Woods"] = 2457,
	["The Veiled Sea"] = 2477,
	["Morlos'Aran"] = 2478,
	["Emerald Sanctuary"] = 2479,
	["Jadefire Glen"] = 2480,
	["Ruins of Constellas"] = 2481,
	["Bitter Reaches"] = 2497,
	["Rise of the Defiler"] = 2517,
	["Lariss Pavilion"] = 2518,
	["Woodpaw Hills"] = 2519,
	["Woodpaw Den"] = 2520,
	["Verdantis River"] = 2521,
	["Ruins of Isildien"] = 2522,
	["Grimtotem Post"] = 2537,
	["Camp Aparaje"] = 2538,
	["Malaka'jin"] = 2539,
	["Boulderslide Ravine"] = 2540,
	["Sishir Canyon"] = 2541,
	["Dire Maul"] = 2557,
	["Deadwind Ravine"] = 2558,
	["Diamondhead River"] = 2559,
	["Ariden's Camp"] = 2560,
	["The Vice"] = 2561,
	["Karazhan"] = 2562,
	["Morgan's Plot"] = 2563,
	["Dire Maul"] = 2577,
	["Alterac Valley"] = 2597,
	["Scrabblescrew's Camp"] = 2617,
	["Jadefire Run"] = 2618,
	["Thondroril River"] = 2619,
	["Thondroril River"] = 2620,
	["Lake Mereldar"] = 2621,
	["Pestilent Scar"] = 2622,
	["The Infectis Scar"] = 2623,
	["Blackwood Lake"] = 2624,
	["Eastwall Gate"] = 2625,
	["Terrorweb Tunnel"] = 2626,
	["Terrordale"] = 2627,
	["Kargathia Keep"] = 2637,
	["Valley of Bones"] = 2657,
	["Blackwing Lair"] = 2677,
	["Deadman's Crossing"] = 2697,
	["Molten Core"] = 2717,
	["The Scarab Wall"] = 2737,
	["Southwind Village"] = 2738,
	["Twilight Base Camp"] = 2739,
	["The Crystal Vale"] = 2740,
	["The Scarab Dais"] = 2741,
	["Hive'Ashi"] = 2742,
	["Hive'Zora"] = 2743,
	["Hive'Regal"] = 2744,
	["Shrine of the Fallen Warrior"] = 2757,
	["UNUSED Alterac Valley"] = 2777,
	["Blackfathom Deeps"] = 2797,
	["***On Map Dungeon***"] = 2817,
	["The Master's Cellar"] = 2837,
	["Stonewrought Pass"] = 2838,
	["Alterac Valley"] = 2839,
	["The Rumble Cage"] = 2857,
	["Chunk Test"] = 2877,
	["Zoram'gar Outpost"] = 2897,
	["Hall of Legends"] = 2917,
	["Champions' Hall"] = 2918,
	["Grosh'gok Compound"] = 2937,
	["Sleeping Gorge"] = 2938,
	["Irondeep Mine"] = 2957,
	["Stonehearth Outpost"] = 2958,
	["Dun Baldar"] = 2959,
	["Icewing Pass"] = 2960,
	["Frostwolf Village"] = 2961,
	["Tower Point"] = 2962,
	["Coldtooth Mine"] = 2963,
	["Winterax Hold"] = 2964,
	["Iceblood Garrison"] = 2977,
	["Frostwolf Keep"] = 2978,
	["Tor'kren Farm"] = 2979,
	["Frost Dagger Pass"] = 3017,
	["Ironstone Camp"] = 3037,
	["Weazel's Crater"] = 3038,
	["Tahonda Ruins"] = 3039,
	["Field of Strife"] = 3057,
	["Icewing Cavern"] = 3058,
	["Valor's Rest"] = 3077,
	["The Swarming Pillar"] = 3097,
	["Twilight Post"] = 3098,
	["Twilight Outpost"] = 3099,
	["Ravaged Twilight Camp"] = 3100,
	["Shalzaru's Lair"] = 3117,
	["Talrendis Point"] = 3137,
	["Rethress Sanctum"] = 3138,
	["Moon Horror Den"] = 3139,
	["Scalebeard's Cave"] = 3140,
	["Boulderslide Cavern"] = 3157,
	["Warsong Labor Camp"] = 3177,
	["Chillwind Camp"] = 3197,
	["The Maul"] = 3217,
	["The Maul UNUSED"] = 3237,
	["Bones of Grakkarond"] = 3257,
	["Warsong Gulch"] = 3277,
	["Frostwolf Graveyard"] = 3297,
	["Frostwolf Pass"] = 3298,
	["Dun Baldar Pass"] = 3299,
	["Iceblood Graveyard"] = 3300,
	["Snowfall Graveyard"] = 3301,
	["Stonehearth Graveyard"] = 3302,
	["Stormpike Graveyard"] = 3303,
	["Icewing Bunker"] = 3304,
	["Stonehearth Bunker"] = 3305,
	["Wildpaw Ridge"] = 3306,
	["Revantusk Village"] = 3317,
	["Rock of Durotan"] = 3318,
	["Silverwing Grove"] = 3319,
	["Warsong Lumber Mill"] = 3320,
	["Silverwing Hold"] = 3321,
	["Wildpaw Cavern"] = 3337,
	["The Veiled Cleft"] = 3338,
	["Yojamba Isle"] = 3357,
	["Arathi Basin"] = 3358,
	["The Coil"] = 3377,
	["Altar of Hir'eek"] = 3378,
	["Shadra'zaar"] = 3379,
	["Hakkari Grounds"] = 3380,
	["Naze of Shirvallah"] = 3381,
	["Temple of Bethekk"] = 3382,
	["The Bloodfire Pit"] = 3383,
	["Altar of the Blood God"] = 3384,
	["Zanza's Rise"] = 3397,
	["Edge of Madness"] = 3398,
	["Trollbane Hall"] = 3417,
	["Defiler's Den"] = 3418,
	["Pagle's Pointe"] = 3419,
	["Farm"] = 3420,
	["Blacksmith"] = 3421,
	["Lumber Mill"] = 3422,
	["Gold Mine"] = 3423,
	["Stables"] = 3424,
	["Cenarion Hold"] = 3425,
	["Staghelm Point"] = 3426,
	["Bronzebeard Encampment"] = 3427,
	["Ahn'Qiraj"] = 3428,
	["Ruins of Ahn'Qiraj"] = 3429,
	["Twilight's Run"] = 3446,
	["Ortell's Hideout"] = 3447,
	["Scarab Terrace"] = 3448,
	["General's Terrace"] = 3449,
	["The Reservoir"] = 3450,
	["The Hatchery"] = 3451,
	["The Comb"] = 3452,
	["Watchers' Terrace"] = 3453,
	["Ruins of Ahn'Qiraj"] = 3454,
	["Naxxramas"] = 3456,
	["City"] = 3459,
	["Gates of Ahn'Qiraj"] = 3478,
	["Ravenholdt Manor"] = 3486,
}
private.MapData = MapData
