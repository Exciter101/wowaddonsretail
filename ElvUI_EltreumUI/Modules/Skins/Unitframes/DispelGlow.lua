local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local LCG = E.Libs.CustomGlow
local pairs = _G.pairs
local ElvUI_EltreumUI = _G.ElvUI_EltreumUI
--local LCG = LibStub('LibCustomGlow-1.0')

--glow dispellable debuffs
function ElvUI_EltreumUI:UFGlow(object, debuffType, _, wasFiltered)
	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if E.db.ElvUI_EltreumUI.glow.enableUFs then
			local name = object:GetName()
			if (name ~= "ElvUF_Player" and name ~= "ElvUF_Target") then
				if debuffType then
					if not wasFiltered then
						--local canDispel = filtercheck:StyleFilterDispelCheck(object, debuffType)
						local color = UF.db.colors.debuffHighlight[debuffType]
						if E.db.ElvUI_EltreumUI.glow.pixel then
							LCG.PixelGlow_Start(object, {color.r, color.g, color.b, 1}, 7, 0.25, 14, 4, 3, 3, false, nil, 6)
							if E.db.ElvUI_EltreumUI.glow.gradient then
								for k,v in pairs({object._PixelGlow:GetRegions()}) do
									local r,g,b = v:GetVertexColor()
									v:SetVertexColor(r-(k/20),g-(k/20),b-(k/20),1)
								end
							end
						elseif E.db.ElvUI_EltreumUI.glow.autocast then
							LCG.AutoCastGlow_Start(object, {color.r, color.g, color.b, 1}, 8, 0.4, 2, 3, 3)
							if E.db.ElvUI_EltreumUI.glow.gradient then
								for k,v in pairs({object._AutoCastGlow:GetRegions()}) do
									local r,g,b = v:GetVertexColor()
									v:SetVertexColor(r-(k/50),g-(k/50),b-(k/50),1)
								end
							end
						elseif E.db.ElvUI_EltreumUI.glow.blizzard then
							LCG.ButtonGlow_Start(object, {color.r, color.g, color.b, 1}, 0.5)
							object._ButtonGlow.outerGlow:SetScale(1.15)
							if E.db.ElvUI_EltreumUI.glow.gradient then
								if not E.Classic then
									object._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",{r = color.r - 0.2, g = color.g - 0.2, b = color.b - 0.2, a = 1}, {r = color.r + 0.2, g = color.g + 0.2, b = color.b + 0.2, a = 1})
								else
									object._ButtonGlow.outerGlow:SetGradient("HORIZONTAL",E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r -0.2, E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g-0.2, E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b-0.2, E.db.ElvUI_EltreumUI.glow.glowcustomcolor.r+0.2, E.db.ElvUI_EltreumUI.glow.glowcustomcolor.g+0.2, E.db.ElvUI_EltreumUI.glow.glowcustomcolor.b+0.2)
								end
							end
						end
					end
				else
					if E.db.ElvUI_EltreumUI.glow.pixel then
						LCG.PixelGlow_Stop(object)
					elseif E.db.ElvUI_EltreumUI.glow.autocast then
						LCG.AutoCastGlow_Stop(object)
					elseif E.db.ElvUI_EltreumUI.glow.blizzard then
						LCG.ButtonGlow_Stop(object)
					end
				end
			end
		end
	end
end
hooksecurefunc(UF, "PostUpdate_AuraHighlight", ElvUI_EltreumUI.UFGlow)
