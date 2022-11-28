local Altoholic_LDB_Feed = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("Altoholic ", {
    type = "launcher",
    icon = "Interface\\Icons\\INV_Drink_05",
    OnClick = function()
		if not IsAddOnLoaded("Altoholic") then LoadAddOn("Altoholic") end
        Altoholic:ToggleUI()
		if (GetMouseButtonClicked() == "RightButton") then
			Altoholic:Tab_OnClick(6)
		end
    end,
	OnEnter = function(self)
		GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
		
		GameTooltip:AddLine("Altoholic",255,255,255)
		GameTooltip:AddLine("Left click to open Altoholic.")
		GameTooltip:AddLine("Right click for Altoholic options.")
		
		GameTooltip:Show()
	end,
	OnLeave = function() GameTooltip:Hide() end,
})