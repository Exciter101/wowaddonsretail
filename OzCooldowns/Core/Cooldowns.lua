local OzCooldowns = _G.OzCooldowns

local floor, ceil, unpack, format, select, tinsert, pairs = floor, ceil, unpack, format, select, tinsert, pairs
local CreateFrame, UIParent, GetTime, hooksecurefunc = CreateFrame, UIParent, GetTime, hooksecurefunc

local Threshold, TimeFormats, TimeColors, RegisteredCooldowns = 10, { [1] = '%d', [2] = '%.1f' }, {}, {}

local function GetTimeInfo(s)
	if s < 60 then
		if s >= Threshold then
			return floor(s), 1
		else
			return s, 2
		end
	else
		return OzCooldowns.db.CooldownText.Accurate and format('%d:%.2d', s/60, s%60) or ceil(s / 60), 0
	end
end

local function OnSetCooldown(self, start, duration)
	local timervalue, formatid = GetTimeInfo(duration - (GetTime() - start))
	self.text:SetFormattedText(TimeFormats[formatid], timervalue)
	self.text:SetTextColor(unpack(TimeColors[formatid]))
end

function OzCooldowns:RegisterCooldown(Cooldown)
	if (Cooldown.isHooked) then return end

	if not Cooldown.text then
		local NumRegions = Cooldown:GetNumRegions()
		for i = 1, NumRegions do
			local Region = select(i, Cooldown:GetRegions())
			if Region.GetText then
				Cooldown.text = Region
				Region:Point("CENTER", 1, 1)
			end
		end
	end

	hooksecurefunc(Cooldown, "SetCooldown", OnSetCooldown)
	tinsert(RegisteredCooldowns, Cooldown)

	if self.ElvUI then
		ElvUI[1]:RegisterCooldown(Cooldown);
	end

	Cooldown.isHooked = true
end

function OzCooldowns:UpdateCooldownSettings()
	Threshold = self.db.CooldownText.Threshold

	TimeColors[0] = self.db.CooldownText.Minutes
	TimeColors[1] = self.db.CooldownText.Seconds
	TimeColors[2] = self.db.CooldownText.Expiring

	if self.db.CooldownText.Accurate then
		TimeFormats[0] = '%s'
	else
		TimeFormats[0] = '%dm'
	end

	for _, Cooldown in pairs(RegisteredCooldowns) do
		Cooldown.text:SetFont(self.LSM:Fetch('font', self.db.CooldownText.Font), self.db.CooldownText.FontSize, self.db.CooldownText.FontFlag)
		if self.db.CooldownText['Enable'] then
			Cooldown:SetHideCountdownNumbers(false)
		else
			Cooldown:SetHideCountdownNumbers(true)
		end
	end
end
