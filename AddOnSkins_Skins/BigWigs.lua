local AS = unpack(AddOnSkins)

if not AS:CheckAddOn('BigWigs') then return end

local Loaded
local name = 'BigWigsSkin'
function AS:SkinBigWigs(event, addon)
	if event == 'LFG_PROPOSAL_SHOW' then
			for i = 1, LFGDungeonReadyPopup:GetNumChildren() do
			local object = select(i, LFGDungeonReadyPopup:GetChildren())
			if object:GetObjectType() == 'StatusBar' then
				AS:SkinStatusBar(object)
			end
		end
		AS:UnregisterEvent(name, event)
		return
	end
	local buttonsize = 19
	local freebg = {}

	local createbg = function()
		local bg = CreateFrame('Frame')
		bg:SetTemplate('Transparent')
		return bg
	end

	local function freestyle(bar)
		local bg = bar:Get('bigwigs:Tukui:bg')
		if bg then
			bg:ClearAllPoints()
			bg:SetParent(UIParent)
			bg:Hide()
			freebg[#freebg + 1] = bg
		end
		local ibg = bar:Get('bigwigs:Tukui:ibg')
		if ibg then
			ibg:ClearAllPoints()
			ibg:SetParent(UIParent)
			ibg:Hide()
			freebg[#freebg + 1] = ibg
		end
		bar.candyBarIconFrame:ClearAllPoints()
		bar.candyBarIconFrame:SetPoint('TOPLEFT')
		bar.candyBarIconFrame:SetPoint('BOTTOMLEFT')
		bar.candyBarBar:ClearAllPoints()
		bar.candyBarBar:SetPoint('TOPRIGHT')
		bar.candyBarBar:SetPoint('BOTTOMRIGHT')
		bar.candyBarBackground:SetAllPoints()
		bar.candyBarDuration:ClearAllPoints()
		bar.candyBarDuration:SetPoint('RIGHT', bar.candyBarBar, 'RIGHT', -2, 0)
		bar.candyBarLabel:ClearAllPoints()
		bar.candyBarLabel:SetPoint('LEFT', bar.candyBarBar, 'LEFT', 2, 0)
		bar.candyBarLabel:SetPoint('RIGHT', bar.candyBarBar, 'RIGHT', -2, 0)
	end

	local applystyle = function(bar)
		bar:SetHeight(buttonsize)
		local bg = nil
		if #freebg > 0 then
			bg = tremove(freebg)
		else
			bg = createbg()
		end
		bg:SetParent(bar)
		bg:ClearAllPoints()
		bg:SetOutside(bar)
		bg:SetTemplate('Transparent')
		bg:Show()
		bar:Set('bigwigs:Tukui:bg', bg)
		local ibg = nil
		if bar.candyBarIconFrame:GetTexture() then
			if #freebg > 0 then
				ibg = tremove(freebg)
			else
				ibg = createbg()
			end
			ibg:SetParent(bar)
			ibg:ClearAllPoints()
			ibg:SetOutside(bar.candyBarIconFrame)
			ibg:SetBackdropColor(0, 0, 0, 0)
			ibg:Show()
			bar:Set('bigwigs:Tukui:ibg', ibg)
		end
		bar.candyBarLabel:SetFont(AS.Font, 12, 'OUTLINE')
		bar.candyBarLabel:SetShadowColor(0, 0, 0, 0)
		bar.candyBarLabel:SetJustifyH('LEFT')
		bar.candyBarLabel:ClearAllPoints()
		bar.candyBarDuration:SetFont(AS.Font, 12, 'OUTLINE')
		bar.candyBarDuration:SetShadowColor(0, 0, 0, 0)
		bar.candyBarDuration:SetJustifyH('RIGHT')
		bar.candyBarDuration:ClearAllPoints()
		if AS:CheckOption('BigWigsHalfBar') then
			bar.candyBarLabel:Point('BOTTOMLEFT', bar, 'TOPLEFT', 0, 4)
			bar.candyBarDuration:Point('BOTTOMRIGHT', bar, 'TOPRIGHT', -1, 2)
		else
			bar.candyBarLabel:Point("LEFT", bar, "LEFT", 4, 0)
			bar.candyBarDuration:Point("RIGHT", bar, "RIGHT", -4, 0)
		end
		bar.candyBarBar:ClearAllPoints()
		bar.candyBarBar:SetAllPoints(bar)
		bar.candyBarBar.SetPoint = AS.Noop
		bar.candyBarBar:SetStatusBarTexture(AS.NormTex)
		bar.candyBarBackground:SetTexture(unpack(AS.BackdropColor))
		bar.candyBarIconFrame:ClearAllPoints()
		bar.candyBarIconFrame:Point('BOTTOMRIGHT', bar, 'BOTTOMLEFT', -7, 0)
		bar.candyBarIconFrame:SetSize(buttonsize, buttonsize)
		bar.candyBarIconFrame.SetWidth = AS.Noop
		AS:SkinTexture(bar.candyBarIconFrame)
	end

	if (IsAddOnLoaded('BigWigs_Plugins') or event == "ADDON_LOADED" and addon == 'BigWigs_Plugins') then
		if Loaded then return end
		Loaded = true
		local BigWigsBars = BigWigs:GetPlugin('Bars')
		BigWigsBars:RegisterBarStyle('Tukui', {
			apiVersion = 1,
			version = 1,
			GetSpacing = function(bar)
				local Spacing = 0
				if AS:CheckOption('BigWigsHalfBar') then
					Spacing = 20
				else
					Spacing = 8
				end
				return Spacing
			end,
			ApplyStyle = applystyle,
			BarStopped = freestyle,
			GetStyleName = function() return 'Tukui' end,
		})
		AS:UnregisterEvent(name, "ADDON_LOADED")
	end
end

AS:RegisterSkin(name, AS.SkinBigWigs, 'ADDON_LOADED', 'LFG_PROPOSAL_SHOW')