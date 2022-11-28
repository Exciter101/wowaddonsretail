local OzCooldowns = LibStub('AceAddon-3.0'):NewAddon("OzCooldowns", 'AceEvent-3.0', 'AceTimer-3.0')
_G.OzCooldowns = OzCooldowns

OzCooldowns.LSM = LibStub("LibSharedMedia-3.0")
OzCooldowns.MyClass = select(2, UnitClass("player"))

local AS, ES

local pairs, format, ceil, wipe = pairs, format, ceil, wipe
local sort, select, floor, unpack, tostring, tonumber = sort, select, floor, unpack, tostring, tonumber

local GetTime = GetTime
local GetSpellInfo, GetSpellCooldown, GetSpellCharges = GetSpellInfo, GetSpellCooldown, GetSpellCharges

local IsInRaid, IsPartyLFG, IsInGroup, SendChatMessage = IsInRaid, IsPartyLFG, IsInGroup, SendChatMessage
local CreateFrame = CreateFrame
local UnitAura = UnitAura
local GetAddOnEnableState = GetAddOnEnableState

local Cooldowns = {}
local CooldownFrames = {}

local function GetColor(Color, Alpha)
	if type(Color) == "table" then
		return Color[1] or 1, Color[2] or 1, Color[3] or 1, Alpha or Color[4] or 1
	else
		return 1, 1, 1, Alpha or 1
	end
end

local function GetTexCoords(Coords)
	if type(Coords) == "table" then
		return Coords[1] or 0, Coords[2] or 1, Coords[3] or 0, Coords[4] or 1
	else
		return 0, 1, 0, 1
	end
end

function OzCooldowns:FindCooldown(SpellID)
	for _, Frame in pairs(Cooldowns) do
		if SpellID == Frame['SpellID'] then
			if self.db["Mode"] == "HIDE" then
				OzCooldowns:DelayedEnableCooldown(Frame)
			else
				OzCooldowns:EnableCooldown(Frame)
			end
			break
		end
	end
end

function OzCooldowns:DelayedEnableCooldown(Frame)
	Frame:SetParent(self.Delay)

	Frame:Show()
	Frame:SetScript("OnUpdate", function(self)
		local Start, Duration, Enable = GetSpellCooldown(self.SpellID)
		local Charges, _, ChargeStart, ChargeDuration = GetSpellCharges(self.SpellID)
		local CurrentDuration = (Start + Duration - GetTime())
		if Charges then
			CurrentDuration = (ChargeStart + ChargeDuration - GetTime())
		end
		if Enable and (CurrentDuration and floor(CurrentDuration) <= OzCooldowns.db["MinimumDuration"] and floor(CurrentDuration) > .1) then
			OzCooldowns:EnableCooldown(self)
		else
			OzCooldowns:DisableCooldown(self)
		end
	end)
end

function OzCooldowns:EnableCooldown(Frame)
	Frame.Enabled = true
	Frame:SetParent(self.Holder)
	Frame.Icon:SetDesaturated(false)

	if OzCooldowns.db["StatusBar"] then
		Frame.Cooldown:SetDrawSwipe(false)
		Frame.StatusBar:Show()
	end

	Frame:Show()
	Frame:SetScript("OnUpdate", function(self)
		local Start, Duration, Enable = GetSpellCooldown(self.SpellID)
		local Charges, _, ChargeStart, ChargeDuration = GetSpellCharges(self.SpellID)
		local CurrentDuration = (Start + Duration - GetTime())
		if Charges then
			Start, Duration = ChargeStart, ChargeDuration
			CurrentDuration = (ChargeStart + ChargeDuration - GetTime())
			if Start == (((2^32)/1000) - ChargeDuration) then
				CurrentDuration = 0
			end
		end

		self.CurrentDuration = CurrentDuration

		if Enable and OzCooldowns.db['BuffTimer'] then
			local Stacks, _, AuraDuration, ExpirationTime = select(3, AuraUtil.FindAuraByName(self.SpellName, 'player'))
			if ExpirationTime then
				Start, Duration = ExpirationTime - AuraDuration, AuraDuration
				CurrentDuration = (Duration - (GetTime() - Start))
				Charges = Stacks
				self.Cooldown:SetReverse(true)
				self.StatusBar:SetReverseFill(true)
			else
				self.Cooldown:SetReverse(false)
				self.StatusBar:SetReverseFill(false)
			end
		end

		if Enable and (self.CurrentDuration and self.CurrentDuration > 0) then
			local Normalized = CurrentDuration / Duration
			self.Cooldown:SetCooldown(Start, Duration)
			self.StatusBar:SetValue(Normalized)
			self.Stacks:SetText(Charges ~= nil and Charges > 0 and Charges or '')
			if OzCooldowns.db["FadeMode"] == "GreenToRed" then
				self.StatusBar:SetStatusBarColor(1 - Normalized, Normalized, 0)
			elseif OzCooldowns.db["FadeMode"] == "RedToGreen" then
				self.StatusBar:SetStatusBarColor(Normalized, 1 - Normalized, 0)
			end
		else
			OzCooldowns:DisableCooldown(self)
		end
	end)
end

function OzCooldowns:DisableCooldown(Frame)
	Frame.Enabled = false
	Frame.CurrentDuration = 0
	Frame.StatusBar:Hide()
	Frame.Cooldown:SetDrawSwipe(true)

	if OzCooldowns.db["Mode"] == "HIDE" then
		Frame:Hide()
		Frame:SetParent(self.Hider)
	else
		Frame:SetAlpha(.3)
		Frame:SetParent(self.Holder)
		Frame.Icon:SetDesaturated(true)
	end
	Frame:SetScript("OnUpdate", nil)
end

function OzCooldowns:Position()
	local Vertical, Spacing, Size = OzCooldowns.db["Vertical"], OzCooldowns.db["Spacing"], OzCooldowns.db["Size"]
	local xSpacing = Vertical and 0 or Spacing
	local ySpacing = Vertical and -(Spacing + (OzCooldowns.db["StatusBar"] and 8 or 0)) or 0
	local AnchorPoint = Vertical and "BOTTOMLEFT" or "TOPRIGHT"
	local LastFrame = OzCooldowns.Holder
	local Index = 0

	if OzCooldowns.db["SortByDuration"] and OzCooldowns.db["Mode"] == "HIDE" then
		sort(Cooldowns, function (a, b)
			local aStart, aDuration = GetSpellCooldown(a.SpellID)
			local bStart, bDuration = GetSpellCooldown(b.SpellID)
			return (aStart + aDuration) < (bStart + bDuration)
		end)
	end

	for i = 1, #Cooldowns do
		local Frame = Cooldowns[i]

		if OzCooldowns.db["Mode"] == "DIM" then
			Frame:ClearAllPoints()
			Frame:SetPoint("TOPLEFT", LastFrame, Index == 0 and "TOPLEFT" or AnchorPoint, xSpacing, ySpacing)
			LastFrame = Frame
			Index = Index + 1
		end

		if OzCooldowns.db["Mode"] == "HIDE" then
			if Frame.Enabled then
				Frame:ClearAllPoints()
				Frame:SetPoint("TOPLEFT", LastFrame, Index == 0 and "TOPLEFT" or AnchorPoint, xSpacing, ySpacing)
				LastFrame = Frame
				Index = Index + 1
			else
				Frame:SetParent(OzCooldowns.Hider)
			end
		end
	end

	if OzCooldowns.db["Vertical"] then
		OzCooldowns.Holder:SetSize(40, Size * Index + (Index + 1) * ySpacing)
	else
		OzCooldowns.Holder:SetSize(Size * Index + (Index + 1) * xSpacing, 40)
	end
end

function OzCooldowns:UpdateCooldownFrames()
	local Size = self.db["Size"]
	local MouseEnabled = self.db["Tooltips"] or self.db["Announce"]

	for _, Frame in pairs(CooldownFrames) do
		Frame:SetSize(Size, Size)
		Frame:EnableMouse(MouseEnabled)
		Frame.Stacks:SetFont(self.LSM:Fetch("font", self.db["StackFont"]), self.db["StackFontSize"], self.db["StackFontFlag"])
		Frame.StatusBar:SetStatusBarTexture(self.LSM:Fetch('statusbar', self.db["StatusBarTexture"]))
		Frame.StatusBar:SetStatusBarColor(unpack(self.db["StatusBarTextureColor"]))
		Frame.StatusBar:SetSize(Size - ((AS and AS.PixelPerfect and 2 or 4) or 2), 4)
		if self.Masque and self.db.Masque and Frame.__MSQ_NormalSkin then
			Frame.StatusBar.Backdrop:SetTexture(Frame.__MSQ_NormalSkin.EmptyTexture or Frame.__MSQ_NormalSkin.Texture)
			Frame.StatusBar.Backdrop:SetTexCoord(GetTexCoords(Frame.__MSQ_NormalSkin.EmptyCoords or Frame.__MSQ_NormalSkin.TexCoords))
			Frame.StatusBar.Backdrop:SetVertexColor(GetColor(Frame.__MSQ_NormalSkin.Color))
		end
	end
end

function OzCooldowns:CreateCooldownFrame(SpellID)
	local SpellName, _, SpellTexture = GetSpellInfo(SpellID)
	local Size = self.db["Size"]

	local Frame = CreateFrame("Button", 'OzCD_'..SpellID, self.Holder)
	Frame:RegisterForClicks('AnyUp')
	Frame:SetSize(Size, Size)

	local Icon = Frame:CreateTexture(nil, "ARTWORK", nil, 1)
	Icon:SetPoint('TOPLEFT', 2, -2)
	Icon:SetPoint('BOTTOMRIGHT', -2, 2)
	Icon:SetTexCoord(.08, .92, .08, .92)
	Icon:SetTexture(SpellTexture)

	local Stacks = Frame:CreateFontString(nil, "OVERLAY")
	Stacks:SetFont(self.LSM:Fetch('font', self.db.StackFont), self.db.StackFontSize, self.db.StackFontFlag)
	Stacks:SetTextColor(1, 1, 1)
	Stacks:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", 0, 2)

	local StatusBar = CreateFrame("StatusBar", nil, Frame)
	StatusBar:SetSize(Size - 2, 4)
	StatusBar:SetPoint("TOP", Frame, "BOTTOM", 0, -1)
	StatusBar:SetMinMaxValues(0, 1)

	local Cooldown = CreateFrame("Cooldown", nil, Frame, "CooldownFrameTemplate")
	Cooldown:SetAllPoints(Icon)
	Cooldown:SetDrawEdge(false)

	self:RegisterCooldown(Cooldown)

	if self.Masque and self.db.Masque then
		self.MasqueGroup:AddButton(Frame)

		StatusBar.Backdrop = StatusBar:CreateTexture(nil, 'OVERLAY')
		StatusBar.Backdrop:SetPoint('TOPLEFT', -4, 1)
		StatusBar.Backdrop:SetPoint('BOTTOMRIGHT', 4, -1)

		StatusBar.Background = StatusBar:CreateTexture(nil, 'BACKGROUND')
		StatusBar.Background:SetColorTexture(0, 0, 0, .6)
		StatusBar.Background:SetPoint('TOPLEFT', -1, 1)
		StatusBar.Background:SetPoint('BOTTOMRIGHT', 1, -1)
	else
		if AS then
			AS:SetTemplate(Frame, 'Default')
			AS:CreateShadow(Frame)
			Icon:SetInside()
			AS:CreateBackdrop(StatusBar, 'Default')
			AS:CreateShadow(StatusBar.Backdrop)
			StatusBar:SetPoint("TOP", Frame, "BOTTOM", 0, -3)
		elseif self.ElvUI or self.Tukui then
			Frame:CreateBackdrop()
			Icon:SetInside()
			StatusBar:CreateBackdrop()
			StatusBar:SetPoint("TOP", Frame, "BOTTOM", 0, -3)
		else
			local BG =	{
				bgFile = [[Interface\Buttons\WHITE8x8]],
				edgeFile = [[Interface\Buttons\WHITE8x8]],
				tile = false, tileSize = 0, edgeSize = 1,
				insets = { left = 1, right = 1, top = 1, bottom = 1},
			}

			Frame:SetBackdrop(BG)
			Frame:SetBackdropColor(0, 0, 0, 1)
			Frame:SetBackdropBorderColor(.6, .6, .6)

			StatusBar.BG = CreateFrame('Frame', nil, StatusBar)
			StatusBar.BG:SetFrameLevel(StatusBar:GetFrameLevel() - 1)
			StatusBar.BG:SetBackdrop(BG)
			StatusBar.BG:SetBackdropColor(0, 0, 0, 1)
			StatusBar.BG:SetBackdropBorderColor(.6, .6, .6)
			StatusBar.BG:SetPoint('TOPLEFT', -1, 1)
			StatusBar.BG:SetPoint('BOTTOMRIGHT', 1, -1)
		end
	end

	if not (self.ElvUI or self.Tukui) then
		Frame:RegisterForDrag('LeftButton')
		Frame:SetScript('OnDragStart', function(self) self:GetParent():StartMoving() end)
		Frame:SetScript('OnDragStop', function(self) self:GetParent():StopMovingOrSizing() end)
	end

	Frame:SetScript('OnEnter', function(self)
		if not OzCooldowns.db["Tooltips"] then return end
		GameTooltip:SetOwner(self, 'ANCHOR_CURSOR')
		GameTooltip:ClearLines()
		GameTooltip:SetSpellByID(self.SpellID)
		GameTooltip:Show()
	end)
	Frame:SetScript('OnLeave', GameTooltip_Hide)
	Frame:SetScript('OnClick', function(self)
		if not OzCooldowns.db["Announce"] then return end
		local Channel = IsInRaid() and "RAID" or IsPartyLFG() and "INSTANCE_CHAT" or IsInGroup() and "PARTY" or "SAY"
		local CurrentDuration = self.CurrentDuration
		local TimeRemaining
		if CurrentDuration > 60 then
			TimeRemaining = format("%d m", ceil(CurrentDuration / 60))
		elseif CurrentDuration <= 60 and CurrentDuration > 10 then
			TimeRemaining = format("%d s", CurrentDuration)
		elseif CurrentDuration <= 10 and CurrentDuration > 0 then
			TimeRemaining = format("%.1f s", CurrentDuration)
		end
		SendChatMessage(format("My %s will be off cooldown in %s", self.SpellName, TimeRemaining), Channel)
	end)

	Frame.Icon = Icon
	Frame.Stacks = Stacks
	Frame.StatusBar = StatusBar
	Frame.Cooldown = Cooldown
	Frame.SpellID = SpellID
	Frame.SpellName = SpellName

	self:DisableCooldown(Frame)

	return Frame
end

function OzCooldowns:BuildCooldowns()
	wipe(Cooldowns)

	local i = 1
	for SpellID in pairs(OzCooldowns.db.SpellCDs) do
		CooldownFrames[SpellID] = CooldownFrames[SpellID] or self:CreateCooldownFrame(SpellID)
		CooldownFrames[SpellID]:Hide() -- Just for DIM Mode
		if OzCooldowns.db.SpellCDs[SpellID] then
			Cooldowns[i] = CooldownFrames[SpellID]
			i = i + 1
		elseif CooldownFrames[SpellID] then
			self:DisableCooldown(CooldownFrames[SpellID])
		end
	end
	OzCooldowns:UpdateCooldownSettings()
	OzCooldowns:UpdateCooldownFrames()

	for _, Frame in pairs(Cooldowns) do
		self:FindCooldown(Frame.SpellID)
	end

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

function OzCooldowns:UNIT_SPELLCAST_SUCCEEDED(event, ...)
	local Unit, _, SpellID  = ...
	if Unit == 'player' then
		C_Timer.After(.1, function() self:FindCooldown(SpellID) end)
	end
end

function OzCooldowns:MasqueCallback(Addon, Group, SkinID, Gloss, Backdrop, Colors, Disabled)
	for _, Frame in pairs(CooldownFrames) do
		Frame.StatusBar.Backdrop:SetTexture(Frame.__MSQ_NormalSkin.EmptyTexture or Frame.__MSQ_NormalSkin.Texture)
		Frame.StatusBar.Backdrop:SetTexCoord(GetTexCoords(Frame.__MSQ_NormalSkin.EmptyCoords or Frame.__MSQ_NormalSkin.TexCoords))
		Frame.__MSQ_BaseFrame:SetFrameLevel(2)
	end
end

function OzCooldowns:Initialize()
	local MyName = UnitName('player')
	self.ElvUI = GetAddOnEnableState(MyName, 'ElvUI') > 0
	self.Tukui = GetAddOnEnableState(MyName, 'Tukui') > 0
	AS = AddOnSkins and unpack(AddOnSkins)
	ES = _G.EnhancedShadows

	self:BuildProfile()
	self:UpdateProfile()

	self.EP = LibStub('LibElvUIPlugin-1.0', true)

	self.Masque = LibStub("Masque", true)
	if self.Masque and self.db.Masque then
		self.Masque:Register("OzCooldowns", self.MasqueCallback)
		self.MasqueGroup = self.Masque:Group("OzCooldowns")
	end

	local Holder = CreateFrame("Frame", 'OzCooldownsHolder', UIParent)
	Holder:SetFrameStrata('LOW')
	Holder:SetFrameLevel(10)
	Holder:SetSize(40, 40)
	Holder:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 360)

	if self.Tukui then
		Tukui[1]["Movers"]:RegisterFrame(Holder)
	elseif self.ElvUI then
		ElvUI[1]:CreateMover(Holder, "OzCooldownsMover", "OzCooldowns Anchor", nil, nil, nil, "ALL,GENERAL")
	else
		Holder:SetMovable(true)
		Holder:SetScript('OnDragStart', function(self) self:StartMoving() end)
		Holder:SetScript('OnDragStop', function(self) self:StopMovingOrSizing() end)
	end

	self.Holder = Holder

	self.Hider = CreateFrame('Frame', nil, UIParent)
	self.Hider:Hide()

	self.Delay = CreateFrame('Frame', nil, UIParent)
	self.Delay:SetPoint('BOTTOM', UIParent, 'TOP', 0, 0)

	self.Title = GetAddOnMetadata("OzCooldowns", "Title")

	if self.EP then
		self.EP:RegisterPlugin("OzCooldowns", self.GetOptions)
	else
		self:GetOptions()
	end

	if not self.ElvUI and GetCVarBool("countdownForCooldowns") == false and (not self.db.WarnUser) then
		StaticPopupDialogs["OZCOOLDOWNS"] = {
			text = 'Blizzard Console Variable - Show Numbers for Cooldown is Disabled. It needs to be enabled if you would like numbers on the cooldowns.\n\nWould you like to enable it?',
			button1 = YES,
			button2 = NO,
			OnAccept = function(self)
				SetCVar("countdownForCooldowns", "1")
			end,
			OnCancel = function(self)
				OzCooldowns.db.WarnUser = true
			end,
			timeout = 0,
			whileDead = 1,
			showAlert = 1,
		}
		StaticPopup_Show("OZCOOLDOWNS")
	end

	self:RegisterEvent('PLAYER_ENTERING_WORLD', 'BuildCooldowns')
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:ScheduleRepeatingTimer('Position', .1)
end

OzCooldowns:RegisterEvent('PLAYER_LOGIN', 'Initialize')
