local OzCooldowns = _G.OzCooldowns

local ACR, ACD = LibStub('AceConfigRegistry-3.0'), LibStub('AceConfigDialog-3.0')
local ACL = LibStub('AceLocale-3.0'):GetLocale('OzCooldowns')

local GetSpellInfo, IsSpellKnown = GetSpellInfo, IsSpellKnown
local pairs, tinsert, sort, unpack = pairs, tinsert, sort, unpack
local format, tostring, tonumber = format, tostring, tonumber
local CopyTable = CopyTable

local function sortedpairs(t, f)
	local a = {}
	for n in pairs(t) do tinsert(a, n) end
	sort(a, f)
	local i = 0
	local iter = function()
		i = i + 1
		if a[i] == nil then return nil
			else return a[i], t[a[i]]
		end
	end
	return iter
end

function OzCooldowns:BuildProfile()
	local SpellList = {}
	for _, SpellID in pairs(self.Racials) do
		if IsSpellKnown(SpellID) then
			tinsert(self.SpellList, SpellID)
		end
	end
	for _, SpellID in pairs(self.SpellList) do
		if DoesSpellExist(SpellID) then
			SpellList[SpellID] = true
		else
			print(format('SpellID ID: %s in %s is invalid.', SpellID, self.MyClass))
		end
	end

	self.data = LibStub('AceDB-3.0'):New('OzCooldownsDB', {
		profile = {
			['Announce'] = true,
			['BuffTimer'] = true,
			['CooldownText'] = {
				['Accurate'] = true,
				['Enable'] = true,
				['Expiring'] = { 1, 0, 0 },
				['Font'] = 'Arial Narrow',
				['FontFlag'] = 'OUTLINE',
				['FontSize'] = 14,
				['Minutes'] = { 1, 1, 1 },
				['Seconds'] = { 1, 1, 0 },
				['Threshold'] = 10,
			},
			['DurationText'] = true,
			['FadeMode'] = 'None',
			['Masque'] = false,
			['MinimumDuration'] = 600,
			['Mode'] = 'HIDE',
			['Size'] = 36,
			['SortByDuration'] = true,
			['Spacing'] = 4,
			['SpellCDs'] = CopyTable(SpellList),
			['StackFont'] = 'Arial Narrow',
			['StackFontFlag'] = 'OUTLINE',
			['StackFontSize'] = 12,
			['StatusBar'] = true,
			['StatusBarTexture'] = 'Blizzard Raid Bar',
			['StatusBarTextureColor'] = { .24, .54, .78 },
			['Tooltips'] = true,
			['Vertical'] = false,
			['WarnUser'] = false,
		},
	})

	self.data.RegisterCallback(self, 'OnProfileChanged', 'UpdateProfile')
	self.data.RegisterCallback(self, 'OnProfileCopied', 'UpdateProfile')
end

function OzCooldowns:UpdateProfile()
	self.db = self.data.profile
end

function OzCooldowns:GenerateSpellOptions()
	local SpellOptions = {}

	local Num = 1
	for k in sortedpairs(OzCooldowns.db.SpellCDs, function(a, b) local aName = GetSpellInfo(a) local bName = GetSpellInfo(b) return aName < bName end) do
		local Name, _, Icon = GetSpellInfo(k)
		if Name then
			SpellOptions[tostring(k)] = {
				order = Num,
				type = 'toggle',
				image = Icon,
				imageCoords = {.08, .92, .08, .92},
				name = Name,
				desc = 'Spell ID: '..k,
			}
			Num = Num + 1
		end
	end

	return SpellOptions
end

function OzCooldowns:GetOptions()
	local Options = {
		type = 'group',
		name = OzCooldowns['Title'],
		order = 101,
		childGroups = 'tab',
		get = function(info) return OzCooldowns.db[info[#info]] end,
		set = function(info, value) OzCooldowns.db[info[#info]] = value OzCooldowns:UpdateCooldownFrames() end,
		args = {
			main = {
				order = 0,
				type = 'group',
				name = ACL['Main Options'],
				args = {
					Masque = {
						order = 0,
						type = 'toggle',
						name = ACL['Masque Support'],
					},
					SortByDuration = {
						order = 1,
						type = 'toggle',
						name = ACL['Sort by Current Duration'],
						disabled = function() return OzCooldowns.db['Mode'] == 'DIM' end,
					},
					MinimumDuration = {
						order = 2,
						type = 'range',
						name = ACL['Minimum Duration Visibility'],
						desc = ACL['Duration in Seconds'],
						min = 2, max = 600, step = 1,
					},
					BuffTimer = {
						order = 3,
						type = 'toggle',
						name = ACL['Buff Timer'],
					},
					CooldownText = {
						type = 'group',
						order = 4,
						name = ACL['Cooldown Text'],
						guiInline = true,
						get = function(info) return OzCooldowns.db.CooldownText[info[#info]] end,
						set = function(info, value) OzCooldowns.db.CooldownText[info[#info]] = value OzCooldowns:UpdateCooldownSettings() end,
						args = {
							Enable = {
								type = 'toggle',
								order = 0,
								name = ACL['Enabled'],
							},
							Accurate = {
								type = 'toggle',
								order = 0,
								name = ACL['M:SS Format'],
							},
							Font = {
								type = 'select', dialogControl = 'LSM30_Font',
								order = 1,
								name = ACL['Font'],
								values = OzCooldowns.LSM:HashTable('font'),
							},
							FontSize = {
								type = 'range',
								order = 2,
								name = ACL['Font Size'],
								min = 8, max = 18, step = 1,
							},
							FontFlag = {
								name = ACL['Font Flag'],
								order = 3,
								type = 'select',
								values = {
									['MONOCHROME'] = 'MONOCHROME',
									['MONOCHROMEOUTLINE'] = 'MONOCHROMEOUTLINE',
									['NONE'] = 'None',
									['OUTLINE'] = 'OUTLINE',
									['THICKOUTLINE'] = 'THICKOUTLINE',
								},
							},
							Threshold = {
								type = 'range',
								order = 4,
								name = ACL['Low Threshold'],
								desc = ACL['Threshold before text turns red and is in decimal form. Set to -1 for it to never turn red'],
								min = -1, max = 20, step = 1,
							},
							Expiring = {
								type = 'color',
								order = 5,
								name = ACL['Expiring'],
								desc = ACL['Color when the text is about to expire'],
								get = function(info) return unpack(OzCooldowns.db.CooldownText[info[#info]]) end,
								set = function(info, r, g, b) OzCooldowns.db.CooldownText[info[#info]] = { r, g, b } OzCooldowns:UpdateCooldownSettings() end,
							},
							Seconds = {
								type = 'color',
								order = 6,
								name = SECONDS,
								desc = ACL['Color when the text is in the seconds format.'],
								get = function(info) return unpack(OzCooldowns.db.CooldownText[info[#info]]) end,
								set = function(info, r, g, b) OzCooldowns.db.CooldownText[info[#info]] = { r, g, b } OzCooldowns:UpdateCooldownSettings() end,
							},
							Minutes = {
								type = 'color',
								order = 7,
								name = MINUTES,
								desc = ACL['Color when the text is in the minutes format.'],
								get = function(info) return unpack(OzCooldowns.db.CooldownText[info[#info]]) end,
								set = function(info, r, g, b) OzCooldowns.db.CooldownText[info[#info]] = { r, g, b } OzCooldowns:UpdateCooldownSettings() end,
							},
						},
					},
					Icons = {
						order = 5,
						type = 'group',
						guiInline = true,
						name = ACL['Icons'],
						args = {
							Vertical = {
								order = 1,
								type = 'toggle',
								name = ACL['Vertical'],
							},
							Tooltips = {
								order = 2,
								type = 'toggle',
								name = ACL['Tooltips'],
							},
							Announce = {
								order = 3,
								type = 'toggle',
								name = ACL['Announce on Click'],
							},
							Size = {
								order = 4,
								type = 'range',
								name = ACL['Size'],
								min = 24, max = 60, step = 1,
							},
							Spacing = {
								order = 5,
								type = 'range',
								name = ACL['Spacing'],
								min = 0, max = 20, step = 1,
							},
							Mode = {
								order = 6,
								type = 'select',
								name = ACL['Dim or Hide'],
								values = {
									['DIM'] = ACL['DIM'],
									['HIDE'] = ACL['HIDE'],
								},
							},
							StackFont = {
								type = 'select',
								dialogControl = 'LSM30_Font',
								order = 7,
								name = ACL['Stacks/Charges Font'],
								values = OzCooldowns.LSM:HashTable('font'),
							},
							StackFontSize = {
								type = 'range',
								order = 8,
								name = ACL['Stacks/Charges Font Size'],
								min = 8, max = 18, step = 1,
							},
							StackFontFlag = {
								name = ACL['Stacks/Charges Font Flag'],
								order = 9,
								type = 'select',
								values = {
									['MONOCHROME'] = 'MONOCHROME',
									['MONOCHROMEOUTLINE'] = 'MONOCHROMEOUTLINE',
									['NONE'] = 'None',
									['OUTLINE'] = 'OUTLINE',
									['THICKOUTLINE'] = 'THICKOUTLINE',
								},
							},
						},
					},
					StatusBars = {
						order = 4,
						type = 'group',
						guiInline = true,
						name = ACL['Status Bar'],
						args = {
							StatusBar = {
								order = 1,
								type = 'toggle',
								name = ACL['Enabled'],
							},
							StatusBarTexture = {
								type = 'select',
								dialogControl = 'LSM30_Statusbar',
								order = 2,
								name = ACL['Texture'],
								values = OzCooldowns.LSM:HashTable('statusbar'),
								disabled = function() return not OzCooldowns.db['StatusBar'] end,
							},
							FadeMode = {
								order = 3,
								type = 'select',
								name = ACL['Fade Mode'],
								disabled = function() return not OzCooldowns.db['StatusBar'] end,
								values = {
									['None'] = ACL['None'],
									['RedToGreen'] = ACL['Red to Green'],
									['GreenToRed'] = ACL['Green to Red'],
								},
							},
							StatusBarTextureColor = {
								type = 'color',
								order = 4,
								name = ACL['Texture Color'],
								hasAlpha = false,
								get = function(info) return unpack(OzCooldowns.db[info[#info]])	end,
								set = function(info, r, g, b, a) OzCooldowns.db[info[#info]] = { r, g, b, a} OzCooldowns:UpdateCooldownFrames() end,
								disabled = function() return not OzCooldowns.db['StatusBar'] or OzCooldowns.db['FadeMode'] == 'GreenToRed' or OzCooldowns.db['FadeMode'] == 'RedToGreen' end,
							},
						},
					},
				},
			},
			spells = {
				order = 1,
				type = 'group',
				name = SPELLS,
				args = OzCooldowns:GenerateSpellOptions(),
				get = function(info) return OzCooldowns.db.SpellCDs[tonumber(info[#info])] end,
				set = function(info, value)
					OzCooldowns.db.SpellCDs[tonumber(info[#info])] = value
					OzCooldowns:BuildCooldowns()
				end,
			},
		},
	}

	Options.args.profiles = LibStub('AceDBOptions-3.0'):GetOptionsTable(OzCooldowns.data)
	Options.args.profiles.order = -2
	ACR:RegisterOptionsTable('OzCooldowns', Options.args.profiles)

	if OzCooldowns.EP then
		local Ace3OptionsPanel = OzCooldowns.ElvUI and ElvUI[1] or Enhanced_Config
		Ace3OptionsPanel.Options.args.ozcooldowns = Options
	end

	ACR:RegisterOptionsTable('OzCooldowns', Options)
	ACD:AddToBlizOptions('OzCooldowns', 'OzCooldowns', nil, 'spells')
	for k, v in pairs(Options.args) do
		if k ~= 'spells' then
			ACD:AddToBlizOptions('OzCooldowns', v.name, 'OzCooldowns', k)
		end
	end
end
