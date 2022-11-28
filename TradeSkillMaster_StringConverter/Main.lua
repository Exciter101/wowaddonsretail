local title, addon = ...
local L = addon.L
local gui = LibStub("AceGUI-3.0")

local text_store = "" -- store the edit box text
local main_frame

addon.frame = CreateFrame("Frame")
addon.frame:RegisterEvent("ADDON_LOADED")
addon.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
addon.frame:SetScript("OnEvent", function(self, event, ...)
    addon[event](self, ...)
end)

local function PrintCommands()
    print(L["/tsmsc slash commands:"])
    print("  " .. HELP_LABEL:lower() .. " " .. L["or ? prints this menu."])
    print("  " .. L["login toggles showing the frame when you first log into WoW."])
    print("  " .. L["reload toggles showing the frame when you reload your UI."])
    print("  " .. L["message toggles displaying this message when you log into WoW."])
    print("  " .. L["Any other entry toggles the frame"])
    print(L["Example: /tsmsc login"])
end

local function ToggleFrame()
    main_frame = gui:Create("Frame")
    main_frame:SetTitle(L["TSM String Converter"])
    main_frame:SetStatusText(L["TradeSkillMaster itemID String Fixer"])
    main_frame:SetCallback("OnClose", function(widget)
        text_store = ""
        gui:Release(widget)
    end)
    main_frame:SetLayout("Flow")

    local help_button = gui:Create("Button")
    help_button:SetText(HELP_LABEL)
    help_button:SetRelativeWidth(0.15)
    help_button:SetCallback("OnClick", function()
        PrintCommands()
    end)
    main_frame:AddChild(help_button)

    local edit_box = gui:Create("MultiLineEditBox")
    edit_box:SetLabel(L["Insert itemIDs"])
    edit_box:SetRelativeWidth(1.0)
    edit_box:SetNumLines(25)
    edit_box:SetMaxLetters(0) -- no limit to the number of characters entered
    edit_box:DisableButton(true) -- disables the "Okay" button
    edit_box:SetCallback("OnTextChanged", function(widget, event, text)
        edit_box:SetLabel(L["Insert itemIDs"])
        text_store = text
    end)
    main_frame:AddChild(edit_box)

    local button = gui:Create("Button")
    button:SetText(CONVERT)
    button:SetRelativeWidth(1.0)
    button:SetCallback("OnClick", function()
        -- strip out all spaces, just in case
        text_store = text_store:trim()
        text_store = string.gsub(text_store, " ", "")

        -- break text_store entirely, and fix it (credit to krowbar71 on the Wowinterface forums)
        text_store = string.gsub(string.gsub(text_store, "[iI]:", ""), "(%d+)", "i:%1")

        print("|cff32cd32TSMSC: |r" .. DONE_EDITING)

        edit_box:SetText(text_store)
        edit_box:HighlightText()
        edit_box:SetFocus()
        edit_box:SetLabel(DONE_EDITING)
    end)
    main_frame:AddChild(button)
end -- end of ToggleFrame()

-- create and handle slash command
SLASH_TSMSC1 = L["/tsmsc"]
SlashCmdList["TSMSC"] = function(msg, editBox) -- the edit box that originated the command, not the input field for itemIDs
    msg = msg and strtrim(strlower(msg))

    if msg == L["message"] then
        TSMSC_DB.showMessage = not TSMSC_DB.showMessage
        if TSMSC_DB.showMessage then
            print(L["TSMSC: showing help menu during log in."])
        else
            print(L["TSMSC: no help menu during log in."])
        end

    elseif msg == L["login"] then
        TSMSC_DB.login = not TSMSC_DB.login
        if TSMSC_DB.login then
            print(L["TSMSC: will show the frame during log in."])
        else
            print(L["TSMSC: won't show the frame during log in."])
        end

    elseif msg == L["reload"] then
        TSMSC_DB.reload = not TSMSC_DB.reload
        if TSMSC_DB.reload then
            print(L["TSMSC: will show the frame when you relod your UI."])
        else
            print(L["TSMSC: won't show the frame when you reload your UI."])
        end

    elseif msg == HELP_LABEL:lower() or msg == L["?"] then
        PrintCommands()
        
    else
        if main_frame and main_frame:IsShown() then
            text_store = ""
            main_frame:Release()
        elseif not main_frame or not main_frame:IsShown() then
            ToggleFrame()
        end
    end
end

function addon:ADDON_LOADED(arg1)
    if arg1 == title then
        addon.frame:UnregisterEvent("ADDON_LOADED")

        if TSMSC_DB == nil then TSMSC_DB = {} end
        if TSMSC_DB.login == nil then TSMSC_DB.login = true end
        if TSMSC_DB.reload == nil then TSMSC_DB.reload = false end
        if TSMSC_DB.showMessage == nil then TSMSC_DB.showMessage = true end
    end
end

function addon:PLAYER_ENTERING_WORLD(isInitialLogin, isReloadingUI)
    if isInitialLogin then
        if TSMSC_DB.login then
            if main_frame then
                -- start with a clean slate
                text_store = ""
                main_frame:Release()
            end
            ToggleFrame()
        end

        if TSMSC_DB.showMessage then
            PrintCommands()
        end
    end

    if isReloadingUI then
        if TSMSC_DB.reload then
            if main_frame then
                -- start with a clean slate
                text_store = ""
                main_frame:Release()
            end
            ToggleFrame()
        end
    end
end