local _, addon = ...

local L = setmetatable({}, {__index = function(t, k)
    local v = tostring(k)
    rawset(t, k, v)
    return v
end})

addon.L = L

local LOCALE = GetLocale()

if LOCALE == "enUS" then
L["/tsmsc"] = "/tsmsc"
L["/tsmsc slash commands:"] = "/tsmsc slash commands:"
L["?"] = "?"
L["Any other entry toggles the frame"] = "Any other entry toggles the frame"
L["Example: /tsmsc login"] = "Example: /tsmsc login"
L["Insert itemIDs"] = "Insert itemIDs"
L["login"] = "login"
L["login toggles showing the frame when you first log into WoW."] = "login toggles showing the frame when you first log into WoW."
L["message"] = "message"
L["message toggles displaying this message when you log into WoW."] = "message toggles displaying this message when you log into WoW."
L["or ? prints this menu."] = "or ? prints this menu."
L["reload"] = "reload"
L["reload toggles showing the frame when you reload your UI."] = "reload toggles showing the frame when you reload your UI."
L["TradeSkillMaster itemID String Fixer"] = "TradeSkillMaster itemID String Fixer"
L["TSM String Converter"] = "TSM String Converter"
L["TSMSC: no help menu during log in."] = "TSMSC: no help menu during log in."
L["TSMSC: showing help menu during log in."] = "TSMSC: showing help menu during log in."
L["TSMSC: will show the frame during log in."] = "TSMSC: will show the frame during log in."
L["TSMSC: will show the frame when you relod your UI."] = "TSMSC: will show the frame when you relod your UI."
L["TSMSC: won't show the frame during log in."] = "TSMSC: won't show the frame during log in."
L["TSMSC: won't show the frame when you reload your UI."] = "TSMSC: won't show the frame when you reload your UI."
return end

if LOCALE == "deDE" then
--[[Translation missing --]]
L["/tsmsc"] = "/tsmsc"
--[[Translation missing --]]
L["/tsmsc slash commands:"] = "/tsmsc slash commands:"
L["?"] = "?"
--[[Translation missing --]]
L["Any other entry toggles the frame"] = "Any other entry toggles the frame"
--[[Translation missing --]]
L["Example: /tsmsc login"] = "Example: /tsmsc login"
--[[Translation missing --]]
L["Insert itemIDs"] = "Insert itemIDs"
--[[Translation missing --]]
L["login"] = "login"
--[[Translation missing --]]
L["login toggles showing the frame when you first log into WoW."] = "login toggles showing the frame when you first log into WoW."
--[[Translation missing --]]
L["message"] = "message"
--[[Translation missing --]]
L["message toggles displaying this message when you log into WoW."] = "message toggles displaying this message when you log into WoW."
--[[Translation missing --]]
L["or ? prints this menu."] = "or ? prints this menu."
--[[Translation missing --]]
L["reload"] = "reload"
--[[Translation missing --]]
L["reload toggles showing the frame when you reload your UI."] = "reload toggles showing the frame when you reload your UI."
--[[Translation missing --]]
L["TradeSkillMaster itemID String Fixer"] = "TradeSkillMaster itemID String Fixer"
--[[Translation missing --]]
L["TSM String Converter"] = "TSM String Converter"
--[[Translation missing --]]
L["TSMSC: no help menu during log in."] = "TSMSC: no help menu during log in."
--[[Translation missing --]]
L["TSMSC: showing help menu during log in."] = "TSMSC: showing help menu during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame during log in."] = "TSMSC: will show the frame during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame when you relod your UI."] = "TSMSC: will show the frame when you relod your UI."
--[[Translation missing --]]
L["TSMSC: won't show the frame during log in."] = "TSMSC: won't show the frame during log in."
--[[Translation missing --]]
L["TSMSC: won't show the frame when you reload your UI."] = "TSMSC: won't show the frame when you reload your UI."

return end

if LOCALE == "frFR" then
L["/tsmsc"] = "/tsmsc"
--[[Translation missing --]]
L["/tsmsc slash commands:"] = "/tsmsc slash commands:"
L["?"] = "?"
--[[Translation missing --]]
L["Any other entry toggles the frame"] = "Any other entry toggles the frame"
--[[Translation missing --]]
L["Example: /tsmsc login"] = "Example: /tsmsc login"
L["Insert itemIDs"] = "Inserer IDobjets"
--[[Translation missing --]]
L["login"] = "login"
--[[Translation missing --]]
L["login toggles showing the frame when you first log into WoW."] = "login toggles showing the frame when you first log into WoW."
--[[Translation missing --]]
L["message"] = "message"
--[[Translation missing --]]
L["message toggles displaying this message when you log into WoW."] = "message toggles displaying this message when you log into WoW."
--[[Translation missing --]]
L["or ? prints this menu."] = "or ? prints this menu."
--[[Translation missing --]]
L["reload"] = "reload"
--[[Translation missing --]]
L["reload toggles showing the frame when you reload your UI."] = "reload toggles showing the frame when you reload your UI."
L["TradeSkillMaster itemID String Fixer"] = "Correcteur de caract??res TradeSkillMaster IDobjet"
L["TSM String Converter"] = "TSM Convertisseur de cha??ne de caract??res"
--[[Translation missing --]]
L["TSMSC: no help menu during log in."] = "TSMSC: no help menu during log in."
--[[Translation missing --]]
L["TSMSC: showing help menu during log in."] = "TSMSC: showing help menu during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame during log in."] = "TSMSC: will show the frame during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame when you relod your UI."] = "TSMSC: will show the frame when you relod your UI."
--[[Translation missing --]]
L["TSMSC: won't show the frame during log in."] = "TSMSC: won't show the frame during log in."
--[[Translation missing --]]
L["TSMSC: won't show the frame when you reload your UI."] = "TSMSC: won't show the frame when you reload your UI."

return end

if LOCALE == "esES" or LOCALE == "esMX" then
--[[Translation missing --]]
L["/tsmsc"] = "/tsmsc"
--[[Translation missing --]]
L["/tsmsc slash commands:"] = "/tsmsc slash commands:"
L["?"] = "?"
--[[Translation missing --]]
L["Any other entry toggles the frame"] = "Any other entry toggles the frame"
--[[Translation missing --]]
L["Example: /tsmsc login"] = "Example: /tsmsc login"
--[[Translation missing --]]
L["Insert itemIDs"] = "Insert itemIDs"
--[[Translation missing --]]
L["login"] = "login"
--[[Translation missing --]]
L["login toggles showing the frame when you first log into WoW."] = "login toggles showing the frame when you first log into WoW."
--[[Translation missing --]]
L["message"] = "message"
--[[Translation missing --]]
L["message toggles displaying this message when you log into WoW."] = "message toggles displaying this message when you log into WoW."
--[[Translation missing --]]
L["or ? prints this menu."] = "or ? prints this menu."
--[[Translation missing --]]
L["reload"] = "reload"
--[[Translation missing --]]
L["reload toggles showing the frame when you reload your UI."] = "reload toggles showing the frame when you reload your UI."
--[[Translation missing --]]
L["TradeSkillMaster itemID String Fixer"] = "TradeSkillMaster itemID String Fixer"
--[[Translation missing --]]
L["TSM String Converter"] = "TSM String Converter"
--[[Translation missing --]]
L["TSMSC: no help menu during log in."] = "TSMSC: no help menu during log in."
--[[Translation missing --]]
L["TSMSC: showing help menu during log in."] = "TSMSC: showing help menu during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame during log in."] = "TSMSC: will show the frame during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame when you relod your UI."] = "TSMSC: will show the frame when you relod your UI."
--[[Translation missing --]]
L["TSMSC: won't show the frame during log in."] = "TSMSC: won't show the frame during log in."
--[[Translation missing --]]
L["TSMSC: won't show the frame when you reload your UI."] = "TSMSC: won't show the frame when you reload your UI."

return end

if LOCALE == "ptBR" then
--[[Translation missing --]]
L["/tsmsc"] = "/tsmsc"
--[[Translation missing --]]
L["/tsmsc slash commands:"] = "/tsmsc slash commands:"
--[[Translation missing --]]
L["?"] = "?"
--[[Translation missing --]]
L["Any other entry toggles the frame"] = "Any other entry toggles the frame"
--[[Translation missing --]]
L["Example: /tsmsc login"] = "Example: /tsmsc login"
--[[Translation missing --]]
L["Insert itemIDs"] = "Insert itemIDs"
--[[Translation missing --]]
L["login"] = "login"
--[[Translation missing --]]
L["login toggles showing the frame when you first log into WoW."] = "login toggles showing the frame when you first log into WoW."
--[[Translation missing --]]
L["message"] = "message"
--[[Translation missing --]]
L["message toggles displaying this message when you log into WoW."] = "message toggles displaying this message when you log into WoW."
--[[Translation missing --]]
L["or ? prints this menu."] = "or ? prints this menu."
--[[Translation missing --]]
L["reload"] = "reload"
--[[Translation missing --]]
L["reload toggles showing the frame when you reload your UI."] = "reload toggles showing the frame when you reload your UI."
--[[Translation missing --]]
L["TradeSkillMaster itemID String Fixer"] = "TradeSkillMaster itemID String Fixer"
--[[Translation missing --]]
L["TSM String Converter"] = "TSM String Converter"
--[[Translation missing --]]
L["TSMSC: no help menu during log in."] = "TSMSC: no help menu during log in."
--[[Translation missing --]]
L["TSMSC: showing help menu during log in."] = "TSMSC: showing help menu during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame during log in."] = "TSMSC: will show the frame during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame when you relod your UI."] = "TSMSC: will show the frame when you relod your UI."
--[[Translation missing --]]
L["TSMSC: won't show the frame during log in."] = "TSMSC: won't show the frame during log in."
--[[Translation missing --]]
L["TSMSC: won't show the frame when you reload your UI."] = "TSMSC: won't show the frame when you reload your UI."

return end

if LOCALE == "ruRU" then
L["/tsmsc"] = "/tsmsc"
--[[Translation missing --]]
L["/tsmsc slash commands:"] = "/tsmsc slash commands:"
L["?"] = "?"
--[[Translation missing --]]
L["Any other entry toggles the frame"] = "Any other entry toggles the frame"
L["Example: /tsmsc login"] = "????????????????: /tsmsc login"
L["Insert itemIDs"] = "?????????????? ID ??????????????????"
L["login"] = "??????????"
--[[Translation missing --]]
L["login toggles showing the frame when you first log into WoW."] = "login toggles showing the frame when you first log into WoW."
L["message"] = "??????????????????"
--[[Translation missing --]]
L["message toggles displaying this message when you log into WoW."] = "message toggles displaying this message when you log into WoW."
--[[Translation missing --]]
L["or ? prints this menu."] = "or ? prints this menu."
L["reload"] = "????????????????????????"
--[[Translation missing --]]
L["reload toggles showing the frame when you reload your UI."] = "reload toggles showing the frame when you reload your UI."
--[[Translation missing --]]
L["TradeSkillMaster itemID String Fixer"] = "TradeSkillMaster itemID String Fixer"
--[[Translation missing --]]
L["TSM String Converter"] = "TSM String Converter"
L["TSMSC: no help menu during log in."] = "TSMSC: ?????? ???????? ???????????? ???? ?????????? ??????????."
L["TSMSC: showing help menu during log in."] = "TSMSC: ???????????????????? ???????? ???????????? ???? ?????????? ??????????."
L["TSMSC: will show the frame during log in."] = "TSMSC:?????????? ???????????????????????? ?????????? ???? ?????????? ??????????."
L["TSMSC: will show the frame when you relod your UI."] = "TSMSC: ?????????? ???????????????????????? ?????????? ???? ?????????? ???????????????????????? ???????????? UI."
L["TSMSC: won't show the frame during log in."] = "TSMSC: ???? ?????????? ???????????????????????? ?????????? ???? ?????????? ??????????."
L["TSMSC: won't show the frame when you reload your UI."] = "TSMSC: ?????????? ???????????????????????? ?????????? ???? ?????????? ???????????????????????? ???????????? UI."

return end

if LOCALE == "koKR" then
--[[Translation missing --]]
L["/tsmsc"] = "/tsmsc"
--[[Translation missing --]]
L["/tsmsc slash commands:"] = "/tsmsc slash commands:"
--[[Translation missing --]]
L["?"] = "?"
--[[Translation missing --]]
L["Any other entry toggles the frame"] = "Any other entry toggles the frame"
--[[Translation missing --]]
L["Example: /tsmsc login"] = "Example: /tsmsc login"
--[[Translation missing --]]
L["Insert itemIDs"] = "Insert itemIDs"
--[[Translation missing --]]
L["login"] = "login"
--[[Translation missing --]]
L["login toggles showing the frame when you first log into WoW."] = "login toggles showing the frame when you first log into WoW."
--[[Translation missing --]]
L["message"] = "message"
--[[Translation missing --]]
L["message toggles displaying this message when you log into WoW."] = "message toggles displaying this message when you log into WoW."
--[[Translation missing --]]
L["or ? prints this menu."] = "or ? prints this menu."
--[[Translation missing --]]
L["reload"] = "reload"
--[[Translation missing --]]
L["reload toggles showing the frame when you reload your UI."] = "reload toggles showing the frame when you reload your UI."
--[[Translation missing --]]
L["TradeSkillMaster itemID String Fixer"] = "TradeSkillMaster itemID String Fixer"
--[[Translation missing --]]
L["TSM String Converter"] = "TSM String Converter"
--[[Translation missing --]]
L["TSMSC: no help menu during log in."] = "TSMSC: no help menu during log in."
--[[Translation missing --]]
L["TSMSC: showing help menu during log in."] = "TSMSC: showing help menu during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame during log in."] = "TSMSC: will show the frame during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame when you relod your UI."] = "TSMSC: will show the frame when you relod your UI."
--[[Translation missing --]]
L["TSMSC: won't show the frame during log in."] = "TSMSC: won't show the frame during log in."
--[[Translation missing --]]
L["TSMSC: won't show the frame when you reload your UI."] = "TSMSC: won't show the frame when you reload your UI."

return end

if LOCALE == "zhTW" then
--[[Translation missing --]]
L["/tsmsc"] = "/tsmsc"
--[[Translation missing --]]
L["/tsmsc slash commands:"] = "/tsmsc slash commands:"
--[[Translation missing --]]
L["?"] = "?"
--[[Translation missing --]]
L["Any other entry toggles the frame"] = "Any other entry toggles the frame"
--[[Translation missing --]]
L["Example: /tsmsc login"] = "Example: /tsmsc login"
--[[Translation missing --]]
L["Insert itemIDs"] = "Insert itemIDs"
--[[Translation missing --]]
L["login"] = "login"
--[[Translation missing --]]
L["login toggles showing the frame when you first log into WoW."] = "login toggles showing the frame when you first log into WoW."
--[[Translation missing --]]
L["message"] = "message"
--[[Translation missing --]]
L["message toggles displaying this message when you log into WoW."] = "message toggles displaying this message when you log into WoW."
--[[Translation missing --]]
L["or ? prints this menu."] = "or ? prints this menu."
--[[Translation missing --]]
L["reload"] = "reload"
--[[Translation missing --]]
L["reload toggles showing the frame when you reload your UI."] = "reload toggles showing the frame when you reload your UI."
--[[Translation missing --]]
L["TradeSkillMaster itemID String Fixer"] = "TradeSkillMaster itemID String Fixer"
--[[Translation missing --]]
L["TSM String Converter"] = "TSM String Converter"
--[[Translation missing --]]
L["TSMSC: no help menu during log in."] = "TSMSC: no help menu during log in."
--[[Translation missing --]]
L["TSMSC: showing help menu during log in."] = "TSMSC: showing help menu during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame during log in."] = "TSMSC: will show the frame during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame when you relod your UI."] = "TSMSC: will show the frame when you relod your UI."
--[[Translation missing --]]
L["TSMSC: won't show the frame during log in."] = "TSMSC: won't show the frame during log in."
--[[Translation missing --]]
L["TSMSC: won't show the frame when you reload your UI."] = "TSMSC: won't show the frame when you reload your UI."

return end

if LOCALE == "zhCN" then
--[[Translation missing --]]
L["/tsmsc"] = "/tsmsc"
--[[Translation missing --]]
L["/tsmsc slash commands:"] = "/tsmsc slash commands:"
--[[Translation missing --]]
L["?"] = "?"
--[[Translation missing --]]
L["Any other entry toggles the frame"] = "Any other entry toggles the frame"
--[[Translation missing --]]
L["Example: /tsmsc login"] = "Example: /tsmsc login"
--[[Translation missing --]]
L["Insert itemIDs"] = "Insert itemIDs"
--[[Translation missing --]]
L["login"] = "login"
--[[Translation missing --]]
L["login toggles showing the frame when you first log into WoW."] = "login toggles showing the frame when you first log into WoW."
--[[Translation missing --]]
L["message"] = "message"
--[[Translation missing --]]
L["message toggles displaying this message when you log into WoW."] = "message toggles displaying this message when you log into WoW."
--[[Translation missing --]]
L["or ? prints this menu."] = "or ? prints this menu."
--[[Translation missing --]]
L["reload"] = "reload"
--[[Translation missing --]]
L["reload toggles showing the frame when you reload your UI."] = "reload toggles showing the frame when you reload your UI."
--[[Translation missing --]]
L["TradeSkillMaster itemID String Fixer"] = "TradeSkillMaster itemID String Fixer"
--[[Translation missing --]]
L["TSM String Converter"] = "TSM String Converter"
--[[Translation missing --]]
L["TSMSC: no help menu during log in."] = "TSMSC: no help menu during log in."
--[[Translation missing --]]
L["TSMSC: showing help menu during log in."] = "TSMSC: showing help menu during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame during log in."] = "TSMSC: will show the frame during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame when you relod your UI."] = "TSMSC: will show the frame when you relod your UI."
--[[Translation missing --]]
L["TSMSC: won't show the frame during log in."] = "TSMSC: won't show the frame during log in."
--[[Translation missing --]]
L["TSMSC: won't show the frame when you reload your UI."] = "TSMSC: won't show the frame when you reload your UI."

return end

if LOCALE == "itIT" then
--[[Translation missing --]]
L["/tsmsc"] = "/tsmsc"
--[[Translation missing --]]
L["/tsmsc slash commands:"] = "/tsmsc slash commands:"
L["?"] = "?"
--[[Translation missing --]]
L["Any other entry toggles the frame"] = "Any other entry toggles the frame"
--[[Translation missing --]]
L["Example: /tsmsc login"] = "Example: /tsmsc login"
--[[Translation missing --]]
L["Insert itemIDs"] = "Insert itemIDs"
--[[Translation missing --]]
L["login"] = "login"
--[[Translation missing --]]
L["login toggles showing the frame when you first log into WoW."] = "login toggles showing the frame when you first log into WoW."
--[[Translation missing --]]
L["message"] = "message"
--[[Translation missing --]]
L["message toggles displaying this message when you log into WoW."] = "message toggles displaying this message when you log into WoW."
--[[Translation missing --]]
L["or ? prints this menu."] = "or ? prints this menu."
--[[Translation missing --]]
L["reload"] = "reload"
--[[Translation missing --]]
L["reload toggles showing the frame when you reload your UI."] = "reload toggles showing the frame when you reload your UI."
--[[Translation missing --]]
L["TradeSkillMaster itemID String Fixer"] = "TradeSkillMaster itemID String Fixer"
--[[Translation missing --]]
L["TSM String Converter"] = "TSM String Converter"
--[[Translation missing --]]
L["TSMSC: no help menu during log in."] = "TSMSC: no help menu during log in."
--[[Translation missing --]]
L["TSMSC: showing help menu during log in."] = "TSMSC: showing help menu during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame during log in."] = "TSMSC: will show the frame during log in."
--[[Translation missing --]]
L["TSMSC: will show the frame when you relod your UI."] = "TSMSC: will show the frame when you relod your UI."
--[[Translation missing --]]
L["TSMSC: won't show the frame during log in."] = "TSMSC: won't show the frame during log in."
--[[Translation missing --]]
L["TSMSC: won't show the frame when you reload your UI."] = "TSMSC: won't show the frame when you reload your UI."

return end