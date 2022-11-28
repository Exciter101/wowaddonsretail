local addonName, motsh = ...;
local L = motsh.L;


local UIConfig = CreateFrame("Frame", "MOTSHframe", UIParent, "UIPanelDialogTemplate");
local UISettings = CreateFrame("Frame", "MOTSHSettings", UIParent, "UIPanelDialogTemplate");
local UIPreview = CreateFrame("Frame", "MOTSHPreview", UIParent);
UIConfig:SetPoint("TOP", UIParent, "TOP",300,0);
UISettings:SetPoint("TOP", UIParent, "TOP",300,0);
UIPreview:SetPoint("TOP", UIParent, "TOP",300,0);

UIConfig:SetMovable(true);
UIConfig:SetUserPlaced(true);
UIConfig:EnableMouse(true);
UIConfig:RegisterForDrag("LeftButton");
UIConfig:SetScript("OnDragStart", UIConfig.StartMoving);
UIConfig:SetScript("OnDragStop", function()
    UICoords.UIConfigCoords.x , UICoords.UIConfigCoords.y = saveFramePos(UIConfig)
end
);
UIConfig:SetSize(352,201);
UIConfig.Title:SetText(L["MOTSH Picker"]);
UIConfig:SetShown(false);
UIConfig:SetClampedToScreen(true);
UIConfig:RegisterEvent("CHAT_MSG_ADDON");
C_ChatInfo.RegisterAddonMessagePrefix("MOTSH")
UIConfig:RegisterEvent("GROUP_ROSTER_UPDATE");
UIConfig:RegisterEvent("ENCOUNTER_START");
--UIConfig:RegisterEvent("PLAYER_ENTERING_WORLD");
UIConfig:RegisterEvent("BOSS_KILL");
UIConfig:RegisterEvent("ADDON_LOADED");
UIConfig:SetScript('OnEvent', function(self, event, arg1, arg2, ...) --https://wow.gamepedia.com/DungeonEncounterID,, https://wow.gamepedia.com/Events
    if event == "ADDON_LOADED" and arg1 == "MistsOfTirnaScitheHelper" then
        if isAnnounce == nil then
            isAnnounce = true;       
        end
        if isPreview == nil then
            isPreview = false;       
        end
        if pickerScale == nil then
            pickerScale = 1
        end
        if pickerTransparency == nil then
            pickerTransparency = 1
        end
        if previewScale == nil then
            previewScale = 1
        end
        if previewTransparency == nil then
            previewTransparency = 1
        end
        if isShowOnBoss == nil then
            isShowOnBoss = true
        end
        if isSync == nil then
            isSync = true;       
        end

        if isShowOrder == nil then
            isShowOrder = false;
        end

        if ChoiceColourTable == nil then
            ChoiceColourTable = {1, 0, 0, 1};
        end
        if AnswerColourTable == nil then
            AnswerColourTable = {0, 1, 0, 1};
        end

        UpdateChoiceColour();
        UpdateAnswerColour();

        UICoords = UICoords or {UIConfigCoords, UISettingsCoords, UIPreviewCoords};
        UICoords.UIConfigCoords = UICoords.UIConfigCoords or {x,y}
        UICoords.UISettingsCoords = UICoords.UISettingsCoords or {x,y}
        UICoords.UIPreviewCoords = UICoords.UIPreviewCoords or {x,y}

        if UICoords.UIConfigCoords.x ~= nil and UICoords.UIConfigCoords.y ~= nil then
            UIConfig:SetPoint("TOP", UIParent, "TOP",UICoords.UIConfigCoords.x,UICoords.UIConfigCoords.y);
        end
        if UICoords.UISettingsCoords.x ~= nil and UICoords.UISettingsCoords.y ~= nil then
            UISettings:SetPoint("TOP", UIParent, "TOP",UICoords.UISettingsCoords.x,UICoords.UISettingsCoords.y);
        end
        if UICoords.UIPreviewCoords.x ~= nil and UICoords.UIPreviewCoords.y ~= nil then
            UIPreview:SetPoint("TOP", UIParent, "TOP",UICoords.UIPreviewCoords.x,UICoords.UIPreviewCoords.y);
        end

        _G["announceButton"]:SetChecked(isAnnounce);
        _G["previewButton"]:SetChecked(isPreview);
        _G["showOnBossButton"]:SetChecked(isShowOnBoss);
        _G["syncWithOthersButton"]:SetChecked(isSync);
        _G["showSelectionOrderButton"]:SetChecked(isShowOrder);
        _G["pickerScaleSlider"]:SetValue(pickerScale);
        _G["pickerTransparencySlider"]:SetValue(pickerTransparency);
        _G["previewScaleSlider"]:SetValue(previewScale);
        _G["previewTransparencySlider"]:SetValue(previewTransparency);

        for k = 1, 8 do
            _G["frameCounter" .. k]:SetShown(isShowOrder);
        end
    elseif (event == "BOSS_KILL" and arg1 == 2397) then --Ingra Maloch
        --print("|cff00ffffMOTSH|r |cffFF4500Ingra Maloch Killed. Type /motsh to show this addon if not already showing|r");
        UIConfig:SetShown(true);
    elseif (event == "BOSS_KILL" and arg1 == 2392 and isShowOnBoss) then --Mistcaller
        --print("|cff00ffffMOTSH|r |cffFF4500Mistcaller Killed. Type /motsh to hide this addon if not already hidden|r");
        UIConfig:SetShown(false);
        reset(); --resetting for future MOTS runs
    elseif (event == "ENCOUNTER_START" and arg1 == 2392) then --Mistcaller
        reset(); --for current fight
        if not isShowOnBoss then
            UIConfig:SetShown(false);
        end    

    --[[if (event == "PLAYER_ENTERING_WORLD" ) then
        local isInstance, instanceType = IsInInstance();
        if (isInstance == true and ((instanceType == "party") or (instanceType == "raid"))) then
            local instanceName, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty,
                    isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo();
            if (instanceName == "Mists of Tirna Scithe") then
                UIConfig:SetShown(true);
            end
        else
            UIConfig:SetShown(false);
        end
    end--]]
    elseif event == ("CHAT_MSG_ADDON") then
        if arg1 == "MOTSH" and isSync then
            local indexCommunicated = arg2
            if indexCommunicated ~= nil and tonumber(indexCommunicated) then
                updateUI(tonumber(indexCommunicated), true);
            elseif indexCommunicated ~= nil and indexCommunicated == "reset" then
                reset();
            end
        end  
    elseif event == ("GROUP_ROSTER_UPDATE") then
        reset();
    end
end
);


--settings
UISettings:SetMovable(true);
UISettings:SetScript("OnDragStart", UISettings.StartMoving);
UISettings:SetScript("OnDragStop", function()
    UICoords.UISettingsCoords.x , UICoords.UISettingsCoords.y = saveFramePos(UISettings)
end
);
UISettings:SetUserPlaced(true);
UISettings:EnableMouse(true);
UISettings:RegisterForDrag("LeftButton");
UISettings.Title:SetText(L["MOTSH Settings"]);
UISettings:SetShown(false);
UISettings:SetClampedToScreen(true);


--preview
UIPreview:SetMovable(true);
UIPreview:SetScript("OnDragStart", UIPreview.StartMoving);
UIPreview:SetScript("OnDragStop", function()
    UICoords.UIPreviewCoords.x , UICoords.UIPreviewCoords.y = saveFramePos(UIPreview)
end
);
UIPreview:SetUserPlaced(true);
UIPreview:EnableMouse(true);
UIPreview:RegisterForDrag("LeftButton");
UIPreview:SetSize(90, 110);
UIPreview:SetShown(false);
UIPreview:SetClampedToScreen(true);
local UIPreviewBackdrop = CreateFrame("Frame", "UIPreviewBackdrop", UIPreview);
UIPreviewBackdrop:SetSize(75, 75);
UIPreviewBackdrop:SetPoint("TOPLEFT", UIPreview, "TOPLEFT", 7, -25);

local UITexture = UIPreviewBackdrop:CreateTexture("previewTexture", "ARTWORK")


local count = 0;
local winner = 0;

--announce button
local yPoint = -50;
local xPoint = -20;
local announceToGroup = UISettings:CreateFontString("announceToGroup", "ARTWORK", "GameFontNormal");
announceToGroup:SetText(L["Announce To Group"]);
announceToGroup:SetPoint("TOPLEFT", 15, yPoint);
announceButton = CreateFrame("CheckButton", "announceButton", UISettings, "ChatConfigCheckButtonTemplate");
announceButton:SetWidth(20);
announceButton:SetHeight(20);
announceButton:SetPoint("TOPRIGHT", UISettings,"TOPRIGHT", xPoint, yPoint);
announceButton:SetScript("OnClick", function(self)
    isAnnounce = not isAnnounce;    
    if isAnnounce then
        printMOTSH(L["will now announce to group!"]);
        if checkKey(count) ~= 0 then
            printWinner();
        end
    else
        printMOTSH(L["will no longer announce to group!"]);
    end
end
);

--preview button
local showPreview = UISettings:CreateFontString("showPreview", "ARTWORK", "GameFontNormal");
yPoint = yPoint - 25;
showPreview:SetText(L["Show Combination Preview"]);
showPreview:SetPoint("TOPLEFT", 15, yPoint);
previewButton = CreateFrame("CheckButton", "announceButton", UISettings, "ChatConfigCheckButtonTemplate");
previewButton:SetWidth(20);
previewButton:SetHeight(20);
previewButton:SetPoint("TOPRIGHT", UISettings,"TOPRIGHT", xPoint, yPoint);
previewButton:SetScript("OnClick", function(self)
    isPreview = not isPreview;    
    if isPreview then
        printMOTSH(L["will now show a preview frame on combination selection!"]);
        if winner ~= 0 then
            UITexture:SetTexture("Interface/AddOns/MistsOfTirnaScitheHelper/Images/" .. winner)		
            UITexture:SetAllPoints(UIPreviewBackdrop)
            UIPreviewBackdrop.texture = UITexture
            UIPreview:SetShown(true);
        end
    else
        printMOTSH(L["will no longer show a preview frame on combination selection!"]);
        UIPreview:SetShown(false);
    end
end
);

--show on boss button
yPoint = yPoint - 25;
local showOnBoss = UISettings:CreateFontString("showOnBoss", "ARTWORK", "GameFontNormal");
showOnBoss:SetText(L["Show On Boss"]);
showOnBoss:SetPoint("TOPLEFT", 15, yPoint);
showOnBossButton = CreateFrame("CheckButton", "showOnBossButton", UISettings, "ChatConfigCheckButtonTemplate");
showOnBossButton:SetWidth(20);
showOnBossButton:SetHeight(20);
showOnBossButton:SetPoint("TOPRIGHT", UISettings,"TOPRIGHT", xPoint, yPoint);
showOnBossButton:SetScript("OnClick", function(self)
    isShowOnBoss = not isShowOnBoss;    
    if isShowOnBoss then
        printMOTSH(L["will now show during Mistcaller fight!"]);
    else
        printMOTSH(L["will no longer show during Mistcaller fight!"]);
    end
end
);

--Show Selection Order Button
yPoint = yPoint - 25;
local showSelectionOrder = UISettings:CreateFontString("showSelectionOrder", "ARTWORK", "GameFontNormal");
showSelectionOrder:SetText(L["Show Selection Order"]);
showSelectionOrder:SetPoint("TOPLEFT", 15, yPoint);
showSelectionOrderButton = CreateFrame("CheckButton", "showSelectionOrderButton", UISettings, "ChatConfigCheckButtonTemplate");
showSelectionOrderButton:SetWidth(20);
showSelectionOrderButton:SetHeight(20);
showSelectionOrderButton:SetPoint("TOPRIGHT", UISettings,"TOPRIGHT", xPoint, yPoint);
showSelectionOrderButton:SetScript("OnClick", function(self)
    isShowOrder = not isShowOrder;
    for k = 1, 8 do
        _G["frameCounter" .. k]:SetShown(isShowOrder);
    end    
    if isShowOrder then
        printMOTSH(L["will now show selection order!"]);
    else
        printMOTSH(L["will no longer show selection order!"]);
    end
end
);

--Sync With Other Button
yPoint = yPoint - 25;
local syncWithOthers = UISettings:CreateFontString("syncWithOthers", "ARTWORK", "GameFontNormal");
syncWithOthers:SetText(L["Sync With Others"]);
syncWithOthers:SetPoint("TOPLEFT", 15, yPoint);
syncWithOthersButton = CreateFrame("CheckButton", "syncWithOthersButton", UISettings, "ChatConfigCheckButtonTemplate");
syncWithOthersButton:SetWidth(20);
syncWithOthersButton:SetHeight(20);
syncWithOthersButton:SetPoint("TOPRIGHT", UISettings,"TOPRIGHT", xPoint, yPoint);
syncWithOthersButton:SetScript("OnClick", function(self)
    isSync = not isSync;    
    if isSync then
        printMOTSH(L["is now synced with group members!"]);
    else
        printMOTSH(L["is no longer synced with group members!"]);
    end
end
);

function ChangeBorderColours(inputRed, inputGreen, inputBlue, inputTable)
    for k = 1, 8 do
        local redChange, greenChange, blueChange, alphaChange = _G["backdrop".. k]:GetBackdropBorderColor()
        redChange = tonumber(string.format("%.3f", redChange));
        greenChange = tonumber(string.format("%.3f", greenChange));
        blueChange = tonumber(string.format("%.3f", blueChange));
        alphaChange = tonumber(string.format("%.3f", alphaChange));
        local bdbcChange = {redChange, greenChange , blueChange, alphaChange};

        if listCompare(bdbcChange, inputTable) then
            _G["backdrop".. k]:SetBackdropBorderColor(inputRed, inputGreen, inputBlue, 1);
        end
    end
end

function UpdateChoiceColour()
    _G["ChoiceColourButtonTexture"]:SetColorTexture(ChoiceColourTable[1], ChoiceColourTable[2], ChoiceColourTable[3])	
    _G["ChoiceColourButtonTexture"]:SetAllPoints(_G["ChoiceColourButton"])
    _G["ChoiceColourButton"].texture = _G["ChoiceColourButtonTexture"]
end

function UpdateAnswerColour()
    _G["AnswerColourButtonTexture"]:SetColorTexture(AnswerColourTable[1], AnswerColourTable[2], AnswerColourTable[3])		
    _G["AnswerColourButtonTexture"]:SetAllPoints(_G["AnswerColourButton"])
    _G["AnswerColourButton"].texture = _G["AnswerColourButtonTexture"]
end


local init = false
--https://www.wowinterface.com/forums/showthread.php?t=21402
function ShowColorPicker(r, g, b, a, changedCallback, colourButton)
    init = false
    ColorPickerFrame:SetColorRGB(r,g,b);
    ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = (a ~= nil), a;
    ColorPickerFrame.previousValues = {r,g,b,a};
    ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = 
     changedCallback, changedCallback, changedCallback;
    ColorPickerFrame:Hide(); -- Need to run the OnShow handler.
    ColorPickerFrame:Show();
    init = true
    ColorPickerFrame.func = 
    function () 
        if init == true then
            --Get Color From ColorPickerFrame
            local rr, gg, bb = ColorPickerFrame:GetColorRGB()
            --Set Button Color To Selected Color
            --Save Selected RGB
            _G[colourButton .. "Button"]:SetBackdropColor(rr, gg, bb, 1)
            if colourButton == "ChoiceColour" then
                ChangeBorderColours(rr, gg, bb, ChoiceColourTable)
                ChoiceColourTable = {rr, gg, bb, 1};
                UpdateChoiceColour();
            elseif colourButton == "AnswerColour" then
                ChangeBorderColours(rr, gg, bb, AnswerColourTable)
                AnswerColourTable = {rr, gg, bb, 1};
                UpdateAnswerColour();
            end

            if listCompare(ChoiceColourTable, AnswerColourTable) or listCompare(AnswerColourTable, ChoiceColourTable) then
                printMOTSH(L["Choice and Answer colours are the same. Colours have been reset to default and the picker has been reset."])
                reset();
                ChoiceColourTable = {1, 0, 0, 1};
                AnswerColourTable = {0, 1, 0, 1};  
                UpdateChoiceColour();
                UpdateAnswerColour();
                ColorPickerFrame:Hide();
            end
            --button.r, button.g, button.b = r, g, b
        end
    end
    ColorPickerFrame.cancelFunc = 
    function (previousValues)
        --Get Color From Previous Values
        if colourButton == "ChoiceColour" then
            ChangeBorderColours(ColorPickerFrame.previousValues[1], ColorPickerFrame.previousValues[2], ColorPickerFrame.previousValues[3], ChoiceColourTable)
            ChoiceColourTable = previousValues --here
            UpdateChoiceColour();
        elseif colourButton == "AnswerColour" then
            ChangeBorderColours(ColorPickerFrame.previousValues[1], ColorPickerFrame.previousValues[2], ColorPickerFrame.previousValues[3], AnswerColourTable)
            AnswerColourTable = previousValues
            UpdateAnswerColour();
        end
       -- local r, g, b = previousValues.r, previousValues.g, previousValues.b
        --Set Color On Button
        
        --Save Previous RGB
        
        --button.r, button.g, button.b = r, g, b
    end
    ColorPickerFrame.opacityFunc = 
    function ()
    end
   end
   
    local function myColorCallback(restore)
    local newR, newG, newB, newA;
    if restore then
    -- The user bailed, we extract the old color from the table created by ShowColorPicker.
    newR, newG, newB, newA = unpack(restore);
    else
    -- Something changed
    newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();
    end
    
    -- Update our internal storage.
    rr, gg, bb, aa = newR, newG, newB, newA;
    -- And update any UI elements that use this color...
    end

--Cancel Function


yPoint = yPoint - 25;
local ChoiceColour = UISettings:CreateFontString("ChoiceColour", "ARTWORK", "GameFontNormal");
ChoiceColour:SetText(L["Change Selection Colour"]);
ChoiceColour:SetPoint("TOPLEFT", 15, yPoint);
--ChoiceColourButton = CreateFrame("Frame", "ChoiceColourButton", UISettings, BackdropTemplateMixin and "BackdropTemplate")
local ChoiceColourButton = CreateFrame("Button", "ChoiceColourButton", UISettings, "ChatConfigButtonTemplate" and "BackdropTemplate");
ChoiceColourButton:SetWidth(20);
ChoiceColourButton:SetHeight(20);
ChoiceColourButton:SetPoint("TOPRIGHT", UISettings,"TOPRIGHT", xPoint, yPoint);
ChoiceColourButton:SetScript("OnClick", function(self)
    ShowColorPicker(ChoiceColourTable[1], ChoiceColourTable[2], ChoiceColourTable[3], ChoiceColourTable[4], _, "ChoiceColour")
end
);
local ChoiceColourButtonTexture = ChoiceColourButton:CreateTexture("ChoiceColourButtonTexture", "ARTWORK")

yPoint = yPoint - 25;
local AnswerColour = UISettings:CreateFontString("AnswerColour", "ARTWORK", "GameFontNormal");
AnswerColour:SetText(L["Change Answer Colour"]);
AnswerColour:SetPoint("TOPLEFT", 15, yPoint);
--AnswerColourButton = CreateFrame("Frame", "AnswerColourButton", UISettings, BackdropTemplateMixin and "BackdropTemplate")
local AnswerColourButton = CreateFrame("Button", "AnswerColourButton", UISettings, "ChatConfigButtonTemplate" and "BackdropTemplate");
AnswerColourButton:SetWidth(20);
AnswerColourButton:SetHeight(20);
AnswerColourButton:SetPoint("TOPRIGHT", UISettings,"TOPRIGHT", xPoint, yPoint);
AnswerColourButton:SetScript("OnClick", function(self)
    ShowColorPicker(AnswerColourTable[1], AnswerColourTable[2], AnswerColourTable[3], AnswerColourTable[4], _, "AnswerColour")
end
);
local AnswerColourButtonTexture = AnswerColourButton:CreateTexture("AnswerColourButtonTexture", "ARTWORK")
   

--[[
--size slider
sizeSlider = CreateFrame("Slider", "sizeSlider", UISettings, "OptionsSliderTemplate");
sizeSlider:SetPoint("TOP", UISettings, "TOP", 0, -100);
sizeSlider:SetMinMaxValues(0.1, 2);
sizeSlider:SetValue(1);
sizeSlider:SetValueStep(0.1);
sizeSlider:SetObeyStepOnDrag(true);
sizeSlider:SetWidth(150)
sizeSlider:SetScript("OnValueChanged", function(self,value)
    UIConfig:SetScale(sizeSlider:GetValue());
  end);

  ]]--
  local SimpleRound = function(val, valStep)
    return floor(val/valStep)*valStep
  end
 
  --basic slider func
  local CreateBasicSlider = function(parent, name, title, minVal, maxVal, valStep, width, xP, yP)
    local slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate")
    local editbox = CreateFrame("EditBox", "$parentEditBox", slider, "InputBoxTemplate")
    slider:SetMinMaxValues(minVal, maxVal)
    slider:SetValueStep(valStep)
    slider.text = _G[name.."Text"]
    slider.text:SetText(title)
    slider.textLow = _G[name.."Low"]
    slider.textHigh = _G[name.."High"]
    slider.textLow:SetText(floor(minVal))
    slider.textHigh:SetText(floor(maxVal))
    slider.textLow:SetTextColor(0.4,0.4,0.4)
    slider.textHigh:SetTextColor(0.4,0.4,0.4)
    slider:SetWidth(width)
    slider:SetPoint("TOP", parent, "TOP", xP, yP);
    editbox:SetSize(50,30)
    editbox:ClearAllPoints()
    editbox:SetPoint("TOP", slider, "TOP", 0, -10)
    editbox:SetText(slider:GetValue())
    editbox:SetAutoFocus(false)
    slider:SetScript("OnValueChanged", function(self,value)
      self.editbox:SetText(SimpleRound(value, valStep))
    end)
    editbox:SetScript("OnEnterPressed", function(self)
      local val = self:GetText()
      if tonumber(val) then
        slider:SetValue(val)
         self:ClearFocus()
      end
    end)
    editbox:SetScript("OnEditFocusLost", function(self)
        local val = self:GetText()
        if tonumber(val) then
          slider:SetValue(val)
           self:ClearFocus()
        end
      end)
    slider.editbox = editbox
    return slider
  end

  --create sliders
  yPoint = yPoint - 50;
    local pickerScaleSlider = CreateBasicSlider(UISettings, "pickerScaleSlider", L["Picker Scale"], 0.1, 2, 0.01, 150, 0, yPoint)
    pickerScaleSlider:HookScript("OnValueChanged", function(self,value)
        UIConfig:SetScale(pickerScaleSlider:GetValue());
        pickerScale = pickerScaleSlider:GetValue();
    end)

    yPoint = yPoint - 75;
    local pickerTransparencySlider = CreateBasicSlider(UISettings, "pickerTransparencySlider", L["Picker Transparency"], 0.05, 1, 0.01, 150, 0, yPoint)
    pickerTransparencySlider:HookScript("OnValueChanged", function(self,value)
        UIConfig:SetAlpha(pickerTransparencySlider:GetValue());
        pickerTransparency = pickerTransparencySlider:GetValue();
    end)

    yPoint = yPoint - 75;
    local previewScaleSlider = CreateBasicSlider(UISettings, "previewScaleSlider", L["Preview Scale"], 0.1, 2, 0.01, 150, 0, yPoint)
    previewScaleSlider:HookScript("OnValueChanged", function(self,value)
        UIPreview:SetScale(previewScaleSlider:GetValue());
        previewScale = previewScaleSlider:GetValue();
    end)

    yPoint = yPoint - 75;
    local previewTransparencySlider = CreateBasicSlider(UISettings, "previewTransparencySlider", L["Preview Transparency"], 0.05, 1, 0.01, 150, 0, yPoint)
    previewTransparencySlider:HookScript("OnValueChanged", function(self,value)
        UIPreview:SetAlpha(previewTransparencySlider:GetValue());
        previewTransparency = previewTransparencySlider:GetValue();
    end)
    


--Reset Options Button
yPoint = yPoint - 55;
local ResetSettingsButton = CreateFrame("Button", "ResetSettingsButton", UISettings, "UIPanelButtonTemplate");
ResetSettingsButton:SetWidth(150);
ResetSettingsButton:SetHeight(30);
ResetSettingsButton:SetText(L["Reset Settings"]);
ResetSettingsButton:SetPoint("TOP", UISettings, "TOP", 0, yPoint);
ResetSettingsButton:SetScript("OnClick", function(self)
        reset();
        isAnnounce = true;       
        isPreview = false;       
        pickerScale = 1
        pickerTransparency = 1
        previewScale = 1
        previewTransparency = 1
        isShowOnBoss = true
        isSync = true;
        isShowOrder = false;
        ChoiceColourTable = {1, 0, 0, 1};
        AnswerColourTable = {0, 1, 0, 1};  
        
        UpdateChoiceColour();
        UpdateAnswerColour();
        
        UICoords.UIConfigCoords.x = nil
        UICoords.UIConfigCoords.y = nil
        UICoords.UISettingsCoords.x = nil
        UICoords.UISettingsCoords.y = nil
        UICoords.UIPreviewCoords.x = nil
        UICoords.UIPreviewCoords.y = nil
        UIConfig:ClearAllPoints()
        UISettings:ClearAllPoints()
        UIPreview:ClearAllPoints()
        UIConfig:SetPoint("TOP", UIParent, "TOP",300,0);
        UISettings:SetPoint("TOP", UIParent, "TOP",300,0);
        UIPreview:SetPoint("TOP", UIParent, "TOP",300,0);
        UIPreview:SetShown(false);
    _G["announceButton"]:SetChecked(isAnnounce);
    _G["previewButton"]:SetChecked(isPreview);
    _G["showOnBossButton"]:SetChecked(isShowOnBoss);
    _G["syncWithOthersButton"]:SetChecked(isSync);
    _G["showSelectionOrderButton"]:SetChecked(isShowOrder);
    _G["pickerScaleSlider"]:SetValue(pickerScale);
    _G["pickerTransparencySlider"]:SetValue(pickerTransparency);
    _G["previewScaleSlider"]:SetValue(previewScale);
    _G["previewTransparencySlider"]:SetValue(previewTransparency);
    for k = 1, 8 do
        _G["frameCounter" .. k]:SetShown(isShowOrder);
    end
end
);

UISettings:SetSize(250,50 - yPoint);






local openSettingsButton = CreateFrame("Button", "openSettingsButton", UIConfig, "UIPanelButtonTemplate");
openSettingsButton:SetWidth(75);
openSettingsButton:SetHeight(20);
openSettingsButton:SetText(L["Settings"]);
openSettingsButton:SetPoint("TOPLEFT", UIConfig,"TOPLEFT", 7, -5);
openSettingsButton:SetScript("OnClick", function(self)
    UISettings:SetShown(not UISettings:IsVisible());
end
);

local resetButton = CreateFrame("Button", "resetButton", UIConfig, "UIPanelButtonTemplate");
resetButton:SetWidth(80);
resetButton:SetHeight(20);
resetButton:SetPoint("TOPRIGHT", UIConfig,"TOPRIGHT", -27, -5);
resetButton:SetText(L["Reset"]);

resetButton:SetScript("OnClick", function(self)
    if GetNumGroupMembers() == 0 or isSync == false then
        reset();
    else
        C_ChatInfo.SendAddonMessage("MOTSH", "reset", InstanceOrParty());
        C_ChatInfo.SendAddonMessage('MAZEHELPER', 'SendReset', InstanceOrParty()); --MazeHelper Compatibility!  
    end 
end
);


--[[

RING
0 - yes
1 - no

FORM
0 - flower
1 - leaf

FILL
0 - empty
1 - full


]]--
local table = 
{
    {
        id = 1,

        ring = 0;
        form = 0;
        fill = 0;

        selected = false;
    },
    {
        id = 2;

        ring = 0;
        form = 0;
        fill = 1;

        selected = false;
    },
    {
        id = 3,

        ring = 0;
        form = 1;
        fill = 0;

        selected = false;
    },
    {
        id = 4,
        
        ring = 0;
        form = 1;
        fill = 1;

        selected = false;
    },
    {
        id = 5,

        ring = 1;
        form = 0;
        fill = 0;

        selected = false;
    },
    {
        id = 6,

        ring = 1;
        form = 0;
        fill = 1;

        selected = false;
    },
    {
        id = 7,

        ring = 1;
        form = 1;
        fill = 0;

        selected = false;
    },
    {
        id = 8,

        ring = 1;
        form = 1;
        fill = 1;

        selected = false;
    }
}

local buttonID_MH = {
    [1] = 4,
    [2] = 3,
    [3] = 2,
    [4] = 1,
    [5] = 8,
    [6] = 7,
    [7] = 6,
    [8] = 5,
};


function addButtons()
    local ypos = -25;
    local xpos = 7;
    
    for i = 1, 8 do

        if i == 5  then
            ypos = -108;
            xpos = 7;
        end
        
        local backdrop = CreateFrame("Frame", "backdrop" .. i, UIConfig, BackdropTemplateMixin and "BackdropTemplate")
        backdrop:SetPoint("TOPLEFT", UIConfig, "TOPLEFT", xpos, ypos);
        backdrop:SetWidth(85);
        backdrop:SetHeight(85);
        backdrop:SetBackdrop({
            --bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            edgeSize = 30,
            --insets = { left = 4, right = 4, top = 4, bottom = 4 },
        })
        backdrop:SetBackdropBorderColor(0, 0, 0, 0);
        local frameCounter = backdrop:CreateFontString("frameCounter" .. i, "ARTWORK", "GameFontNormal");
        frameCounter:SetText("");
        frameCounter:SetPoint("TOPLEFT", 10, -7);
        local button = CreateFrame("Button", "button" .. i, backdrop, "BackdropTemplate");
        button:SetWidth(75);
        button:SetHeight(75);
        button:SetPoint("CENTER",backdrop,"CENTER");
        button:SetNormalTexture("Interface/AddOns/MistsOfTirnaScitheHelper/Images/" .. i);
        button:SetPushedTexture("Interface/AddOns/MistsOfTirnaScitheHelper/Images/" .. i);
        --button:SetHighlightTexture("Interface/AddOns/MistsOfTirnaScitheSmartSolve/Images/" .. i);
        button:SetScript("OnClick", function(self)
            sendClick(i, true)
        end
        );
        xpos = xpos + 85;
    end
end

addButtons();

function settingsUI()

end

function updateUI(index, isSendToAddons)
    local skipThisIteration = false;
    local blackTable = {0, 0, 0, 0};
    local f = _G["button" .. index]:GetParent()
    table[index].selected = not table[index].selected;
    local red, green, blue, alpha = f:GetBackdropBorderColor()
    red = tonumber(string.format("%.3f", red));
    green = tonumber(string.format("%.3f", green));
    blue = tonumber(string.format("%.3f", blue));
    alpha = tonumber(string.format("%.3f", alpha));
    local bdbc = {red, green , blue, alpha};
    
    if listCompare(bdbc, blackTable) then
        f:SetBackdropBorderColor(ChoiceColourTable[1], ChoiceColourTable[2], ChoiceColourTable[3], ChoiceColourTable[4]);
        count = count + 1;

        local isCountMore = false
        local order = count;
        for k = 1, 8 do
            if _G["frameCounter".. k]:GetText() ~= nil then
                if tonumber(_G["frameCounter".. k]:GetText()) > (count-1) then
                    isCountMore = true
                end
            end
        end
        if isCountMore then
            for k1 = 1, count do
                if isCountMore then
                    local orderMissing = true;
                    for k2 = 1, 8 do
                        if _G["frameCounter".. k2]:GetText() ~= nil then
                            if tonumber(_G["frameCounter".. k2]:GetText()) == k1 then
                                orderMissing = false; 
                            end
                        end
                    end
                    if orderMissing then
                        order = k1
                        isCountMore = false
                    end
                end
            end
        end
        _G["frameCounter".. index]:SetText(order);

        if winner ~= 0 then
            _G["backdrop".. winner]:SetBackdropBorderColor(ChoiceColourTable[1], ChoiceColourTable[2], ChoiceColourTable[3], ChoiceColourTable[4]);
        end
    elseif listCompare(bdbc, ChoiceColourTable) then
        f:SetBackdropBorderColor(0, 0, 0, 0);
        count = count - 1;
        _G["frameCounter".. index]:SetText("");
        if winner ~= 0 then
            _G["backdrop".. winner]:SetBackdropBorderColor(ChoiceColourTable[1], ChoiceColourTable[2], ChoiceColourTable[3], ChoiceColourTable[4]);
        end
    elseif listCompare(bdbc, AnswerColourTable) then
        f:SetBackdropBorderColor(0, 0, 0, 0);
        count = count - 1;
        _G["frameCounter".. index]:SetText("");
        if count == 3 then
            skipThisIteration = true;
            winner = 0;
            UIPreview:SetShown(false);
        end
    end


    --do extra window stuff here
    

    if (not skipThisIteration) then
        winner = checkKey(count);
        if winner ~= 0 then
            if isPreview then
                UITexture:SetTexture("Interface/AddOns/MistsOfTirnaScitheHelper/Images/" .. winner)		
                UITexture:SetAllPoints(UIPreviewBackdrop)
                UIPreviewBackdrop.texture = UITexture
                UIPreview:SetShown(true);
            end
            _G["backdrop".. winner]:SetBackdropBorderColor(AnswerColourTable[1], AnswerColourTable[2], AnswerColourTable[3], AnswerColourTable[4]);
            if isAnnounce and isSendToAddons then
                printWinner();
            end
        else
            UIPreview:SetShown(false);
        end
    end
end

function listCompare(list1, list2)
    for k = 1, 4 do
        if tonumber(string.format("%.3f", list1[k])) ~= tonumber(string.format("%.3f", list2[k])) then
            return false;
        end
    end
    return true;
end

function printWinner()
    for index, value in pairs(table) do
        if value.id == winner then
            local ringS, formS, fillS;
            if value.ring == 1 then
                ringS = L["NO RING"];
            else
                ringS = L["RING"];
            end

            if value.form == 1 then
                formS = L["LEAF"];
            else
                formS = L["FLOWER"];
            end

            if value.fill == 1 then
                fillS = L["FILLED"];
            else
                fillS = L["EMPTY"];
            end
            --SendChatMessage("|cff00ffffMOTSH|r |cffFF4500Correct Combination is: [" .. ringS .. "], [" .. formS .. "], [" .. fillS .. "]|r", "PARTY")
            if GetNumGroupMembers() ~= 0 and isSync then
                SendChatMessage(string.format(L["[%s], [%s], [%s] (MOTSH-Addon)"], ringS, formS, fillS), InstanceOrParty());
            else
                printMOTSH(string.format(L["[%s], [%s], [%s] (MOTSH)"], ringS, formS, fillS))
            end
            
        end
    end
end

function copy1(obj)
    if type(obj) ~= 'table' then return obj end
    local res = {};
    for k, v in pairs(obj) do res[copy1(k)] = copy1(v); end
    return res;
end

function checkKey(counter)
    local returnID;
    local found = 0;
    if counter == 4 then
        local list = {};
        local j = 1;
        for i = 1, 8 do
            if table[i].selected == true then
                list[j] = copy1(table[i]);
                j = j+1;
            end
        end
        local sumRing = list[1].ring + list[2].ring + list[3].ring + list[4].ring;
        local sumForm = list[1].form + list[2].form + list[3].form + list[4].form;
        local sumFill = list[1].fill + list[2].fill + list[3].fill + list[4].fill;
        if sumRing == 1 then
            if list[1].ring == 1 then returnID = list[1].id; found = found + 1;
            elseif list[2].ring == 1 then returnID = list[2].id; found = found + 1;
            elseif list[3].ring == 1 then returnID = list[3].id; found = found + 1;
            elseif list[4].ring == 1 then returnID = list[4].id; found = found + 1;
            end
        end
        if sumForm == 1 then
            if list[1].form == 1 then returnID = list[1].id; found = found + 1;
            elseif list[2].form == 1 then returnID = list[2].id; found = found + 1;
            elseif list[3].form == 1 then returnID = list[3].id; found = found + 1;
            elseif list[4].form == 1 then returnID = list[4].id; found = found + 1;
            end
        end
        if sumFill == 1 then
            if list[1].fill == 1 then returnID = list[1].id; found = found + 1;
            elseif list[2].fill == 1 then returnID = list[2].id; found = found + 1;
            elseif list[3].fill == 1 then returnID = list[3].id; found = found + 1;
            elseif list[4].fill == 1 then returnID = list[4].id; found = found + 1;
            end
        end
        if sumRing == 3 then
            if list[1].ring == 0 then returnID = list[1].id; found = found + 1;
            elseif list[2].ring == 0 then returnID = list[2].id; found = found + 1;
            elseif list[3].ring == 0 then returnID = list[3].id; found = found + 1;
            elseif list[4].ring == 0 then returnID = list[4].id; found = found + 1;
            end
        end
        if sumForm == 3 then
            if list[1].form == 0 then returnID = list[1].id; found = found + 1;
            elseif list[2].form == 0 then returnID = list[2].id; found = found + 1;
            elseif list[3].form == 0 then returnID = list[3].id; found = found + 1;
            elseif list[4].form == 0 then returnID = list[4].id; found = found + 1;
            end
        end
        if sumFill == 3 then
            if list[1].fill == 0 then returnID = list[1].id; found = found + 1;
            elseif list[2].fill == 0 then returnID = list[2].id; found = found + 1;
            elseif list[3].fill == 0 then returnID = list[3].id; found = found + 1;
            elseif list[4].fill == 0 then returnID = list[4].id; found = found + 1;
            end
        end
    elseif counter == 3 then
        local list = {};
        local j = 1;
        for i = 1, 8 do
            if table[i].selected == true then
                list[j] = copy1(table[i]);
                j = j+1;
            end
        end

        returnID = checkThrees(list[1], list[2], list[3])
        if returnID == 0 then
            returnID = checkThrees(list[2], list[3], list[1])
        end
        if returnID == 0 then
            returnID = checkThrees(list[3], list[1], list[2])
        end
        if returnID ~= 0 then
            return returnID;
        else
            local answerRing, answerForm, answerFill;
            local sumRing = list[1].ring + list[2].ring + list[3].ring
            local sumForm = list[1].form + list[2].form + list[3].form
            local sumFill = list[1].fill + list[2].fill + list[3].fill

            if sumRing == 3 or sumRing == 2 then answerRing = 0;
            elseif sumRing == 0 or sumRing == 1 then answerRing = 1; end
            if sumForm == 3 or sumForm == 2 then answerForm = 0;
            elseif sumForm == 0 or sumForm == 1 then answerForm = 1; end
            if sumFill == 3 or sumFill == 2 then answerFill = 0;
            elseif sumFill == 0 or sumFill == 1 then answerFill = 1; end
            if answerRing == nil or answerForm == nil or answerFill == nil then
                return 0;
            elseif sumRing > 0 and sumRing < 3 and  sumForm > 0 and sumForm < 3 and sumFill > 0 and sumFill < 3 then
                return 0;
            else
                for index, values in pairs(table) do
                    if values.ring == answerRing and values.form == answerForm and values.fill == answerFill then
                        sendClick(values.id, false);
                        return winner;
                    end
                end
            end 
            return 0;
        end
    end
    if found ~= 1 then
        if found > 1 then
            printMOTSH(string.format(L["found %s different solutions to the chosen symbols. Please check your symbols and try again!"], found));
        end
        return 0;
    else
        return returnID;
    end
end

function reset()
    for resetter = 1, 8 do
        _G["backdrop".. resetter]:SetBackdropBorderColor(0, 0, 0, 0);
        _G["frameCounter".. resetter]:SetText("");
        table[resetter].selected = false;
        count = 0;
        winner = 0;
    end
    UIPreview:SetShown(false);
end

function checkThrees(a, b, c)
    if a.ring == b.ring and c.ring ~= a.ring and a.form == b.form and c.form ~= a.form then
        return c.id;
    elseif a.ring == b.ring and c.ring ~= a.ring and a.fill == b.fill and c.fill ~= a.fill then
        return c.id;
    elseif a.fill == b.fill and c.fill ~= a.fill and a.form == b.form and c.form ~= a.form then
        return c.id;
    else
        return 0;
    end
end

function InstanceOrParty()
    if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and (not IsInRaid())) then
        return "INSTANCE_CHAT";
    else
        return "PARTY";
    end
end

function sendClick(i, isSendToAddons)
    if GetNumGroupMembers() == 0 or isSync == false then
        updateUI(i, isSendToAddons);
    else
        local mode;
        if table[i].selected then
            mode = "UNACTIVE"
        else
            mode = "ACTIVE"
        end
        local data = 'SendButtonID|' .. buttonID_MH[i] .. '|' .. mode;
        if isSendToAddons then
            C_ChatInfo.SendAddonMessage("MOTSH", i, InstanceOrParty());
        else
            updateUI(i, isSendToAddons);
        end
        C_ChatInfo.SendAddonMessage('MAZEHELPER', data, InstanceOrParty()); --MazeHelper Compatibility!   
        
    end
end


function saveFramePos(f)
    local xOfs, yOfs;
    
    _, _, _, xOfs, yOfs = f:GetPoint()

    f:StopMovingOrSizing()

    return xOfs, yOfs;
end

function printMOTSH(inputString)
    print("|cff00ffffMOTSH|r |cffFF4500" .. inputString .. "|r")
end


_G["SLASH_motsh1"] = "/motsh";
-- Possible Sub-commands.
local function SlashCmd(cmd,self)
	if(cmd == "") then
		UIConfig:SetShown(not UIConfig:IsVisible());
	end

	if(cmd == "settings") then
		--UISettings:SetShown(not UISettings:IsVisible());
		UISettings:SetShown(true);
	end

	if(cmd == "help") then
		showHelp();
	end
end
SlashCmdList["motsh"] = SlashCmd;

--_G["SLASH_mists2"] = "/mists options";
--SlashCmdList["mists options"] = function(cmd)
--	UISettings:SetShown(not UISettings:IsVisible());
--end
--
--_G["SLASH_mists3"] = "/mists help";
--SlashCmdList["mists help"] = function(cmd)
--	showHelp();
--end

function showHelp()
	print("|cff00ccffCommands:|r");
	print(" - /motsh");
	print(" - /motsh settings");
	print(" - /motsh help");
	print("");
	print("|cFF808080Version: " .. GetAddOnMetadata(addonName, 'Version') .. "|r");
	print("");
end