-- No Error Spam
-- By Tia Lynn
-- Prevents the Same Error Message from repeating more than 1 per 8 seconds
--      (8 Seconds is the Default Time it takes for a message to fade away)

local nesSpamDB = {}

local NESframe = CreateFrame("frame", "NoErrorSpam")
NESframe:SetScript("OnEvent", function(self, event, ...)
    self[event](self, event, ...)
    end)
NESframe:RegisterEvent("ADDON_LOADED")

local ErrorUI_OnEvent = UIErrorsFrame:GetScript("OnEvent")

local function NES_OnEvent(self, event, sMessage, ...)
    if (event == "UI_ERROR_MESSAGE") then
        local sLowerMsg = string.lower(sMessage)
        if (nesSpamDB[sLowerMsg]) then
            local nTickTock = GetTime() - nesSpamDB[sLowerMsg]
            if (nTickTock < 8) then return end
        end
        nesSpamDB[sLowerMsg] = GetTime()
    end
    return ErrorUI_OnEvent(self, event, sMessage, ...)
end

function NESframe.ADDON_LOADED(self, event, sAddonTitle)
    if (sAddonTitle ~= "Tia_NoErrorSpam") then return end
    self:UnregisterEvent(event)
    UIErrorsFrame:SetScript("OnEvent", NES_OnEvent)
end
