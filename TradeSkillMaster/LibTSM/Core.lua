-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

-- This is loaded before anything else and simply sets up the addon table

local ADDON_NAME = select(1, ...)
local TSM = select(2, ...) ---@class TSM
local VERSION_RAW = GetAddOnMetadata("TradeSkillMaster", "Version")
local IS_DEV_VERSION = strmatch(VERSION_RAW, "^@tsm%-project%-version@$") and true or false
local BUILD_NUMBER = select(4, GetBuildInfo())
local private = {
	context = {},
	initOrder = {},
	loadOrder = {},
	frame = nil,
	gotAddonLoaded = false,
	gotPlayerLogin = false,
	gotPlayerLogout = false,
}



-- ============================================================================
-- Module Metatable
-- ============================================================================

local MODULE_METHODS = {
	OnModuleLoad = function(self, func)
		local context = private.context[self]
		assert(context and not context.moduleLoadFunc and not context.moduleLoadTime and type(func) == "function")
		context.moduleLoadFunc = func
	end,
	OnSettingsLoad = function(self, func)
		local context = private.context[self]
		assert(context and not context.settingsLoadFunc and not context.settingsLoadTime and type(func) == "function")
		context.settingsLoadFunc = func
	end,
	OnGameDataLoad = function(self, func)
		local context = private.context[self]
		assert(context and not context.gameDataLoadFunc and not context.gameDataLoadTime and type(func) == "function")
		context.gameDataLoadFunc = func
	end,
	OnModuleUnload = function(self, func)
		local context = private.context[self]
		assert(context and not context.moduleUnloadFunc and not context.moduleUnloadTime and type(func) == "function")
		context.moduleUnloadFunc = func
	end,
}

local MODULE_MT = {
	__index = MODULE_METHODS,
	__newindex = function(self, key, value)
		local context = private.context[self]
		assert(context and not MODULE_METHODS[key] and not context.moduleLoadTime)
		rawset(self, key, value)
	end,
	__metatable = false,
}



-- ============================================================================
-- Addon Object Functions
-- ============================================================================

---Creates a new TSM module.
---@param path string The name of the module
---@return table @The module table
function TSM.Init(path)
	assert(type(path) == "string")
	if private.context[path] then
		error("Module already exists for path: "..tostring(path))
	end
	local moduleObj = setmetatable({}, MODULE_MT)
	private.context[path] = {
		path = path,
		module = moduleObj,
		moduleLoadFunc = nil,
		moduleLoadTime = nil,
		settingsLoadFunc = nil,
		settingsLoadTime = nil,
		gameDataLoadFunc = nil,
		gameDataLoadTime = nil,
		moduleUnloadFunc = nil,
		moduleUnloadTime = nil,
	}
	-- store a reference to the context by both the module object and the path
	private.context[moduleObj] = private.context[path]
	tinsert(private.initOrder, path)
	return moduleObj
end

---Returns an existing TSM module.
---@generic T
---@param path `T`
---@return T
function TSM.Include(path)
	local context = private.context[path]
	if not context then
		error("Module doesn't exist for path: "..tostring(path))
	end
	private.ProcessModuleLoad(path)
	return context.module
end

---Returns whether or not we're running a dev version.
---@return boolean
function TSM.IsDevVersion()
	return IS_DEV_VERSION
end

---Returns whether or not we're running in a test environment
---@return boolean
function TSM.IsTestEnvironment()
	return VERSION_RAW == "v4.99.99"
end

---Gets the current addon version
---@return string @The current addon version
function TSM.GetVersion()
	return TSM.IsDevVersion() and "Dev" or VERSION_RAW
end

---Returns an iterator over all available modules.
---@return fun(): number, string, number, number, number, number # An iterator with fields: `index, loadTime, settingsLoadTime, gameDataLoadTime, moduleUnloadTime`
function TSM.ModuleInfoIterator()
	return private.ModuleInfoIterator, nil, 0
end

---Returns whether or not we're running within a classic version of the game.
---@return boolean
function TSM.IsWowClassic()
	return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC
end

---Returns whether or not we're running within Vanilla Classic.
---@return boolean
function TSM.IsWowVanillaClassic()
	return WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
end

---Returns whether or not we're running within Wrath Classic.
---@return boolean
function TSM.IsWowWrathClassic()
	return WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC or WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC
end

---Returns whether or not we're running within Wrath Classic.
---@return boolean
function TSM.IsWowWrathPatch341()
	return TSM.IsWowWrathClassic() and BUILD_NUMBER >= 30401
end

---Unloads all modules to simulate a logout.
function TSM.DebugLogout()
	private.UnloadAll()
end



-- ============================================================================
-- Private Helper Functions
-- ============================================================================

function private.ModuleInfoIterator(_, index)
	index = index + 1
	local path = private.initOrder[index]
	if not path then
		return
	end
	local context = private.context[path]
	assert(context)
	return index, path, context.moduleLoadTime, context.settingsLoadTime, context.gameDataLoadTime, context.moduleUnloadTime
end

function private.ProcessModuleLoad(path)
	local context = private.context[path]
	assert(context)
	if context.moduleLoadTime then
		-- already loaded
		return
	end
	tinsert(private.loadOrder, path)
	context.moduleLoadTime = 0
	if context.moduleLoadFunc then
		local st = debugprofilestop()
		context.moduleLoadFunc()
		context.moduleLoadTime = debugprofilestop() - st
	end
end

function private.ProcessSettingsLoad(path)
	local context = private.context[path]
	assert(context)
	if context.settingsLoadTime then
		-- already loaded
		return
	end
	context.settingsLoadTime = 0
	if context.settingsLoadFunc then
		local st = debugprofilestop()
		context.settingsLoadFunc()
		context.settingsLoadTime = debugprofilestop() - st
	end
end

function private.ProcessGameDataLoad(path)
	local context = private.context[path]
	assert(context)
	if context.gameDataLoadTime then
		-- already loaded
		return
	end
	context.gameDataLoadTime = 0
	if context.gameDataLoadFunc then
		local st = debugprofilestop()
		context.gameDataLoadFunc()
		context.gameDataLoadTime = debugprofilestop() - st
	end
end

function private.ProcessModuleUnload(path)
	local context = private.context[path]
	assert(context)
	if context.moduleUnloadTime then
		-- already unloaded
		return
	end
	context.moduleUnloadTime = 0
	if context.moduleUnloadFunc then
		local st = debugprofilestop()
		context.moduleUnloadFunc()
		context.moduleUnloadTime = debugprofilestop() - st
	end
end

function private.UnloadAll()
	-- unload in the opposite order we loaded
	for i = #private.loadOrder, 1, -1 do
		private.ProcessModuleUnload(private.loadOrder[i])
	end
end

function private.OnEvent(_, event, arg)
	if event == "ADDON_LOADED" and arg == ADDON_NAME and not private.gotAddonLoaded then
		assert(not private.gotAddonLoaded and not private.gotPlayerLogin and not private.gotPlayerLogout)
		private.gotAddonLoaded = true
		-- load any module which haven't already
		for _, path in ipairs(private.initOrder) do
			private.ProcessModuleLoad(path)
		end
		-- settings are now available
		for _, path in ipairs(private.loadOrder) do
			private.ProcessSettingsLoad(path)
		end
		private.frame:UnregisterEvent("ADDON_LOADED")
	elseif event == "PLAYER_LOGIN" then
		assert(private.gotAddonLoaded and not private.gotPlayerLogin and not private.gotPlayerLogout)
		private.gotPlayerLogin = true
		-- game data is now available
		for _, path in ipairs(private.loadOrder) do
			private.ProcessGameDataLoad(path)
		end
	elseif event == "PLAYER_LOGOUT" then
		assert(private.gotAddonLoaded and not private.gotPlayerLogout)
		private.gotPlayerLogout = true
		if not private.gotPlayerLogin then
			-- this can happen if the player exists the game during the loading screen, in which case we just ignore it
			return
		end
		private.UnloadAll()
	end
end



-- ============================================================================
-- Initialization Code
-- ============================================================================

-- Only do initialization if we're loaded in a WoW environment
if ADDON_NAME then
	-- Create frame to listen for lifecycle events
	private.frame = CreateFrame("Frame")
	private.frame:RegisterEvent("ADDON_LOADED")
	private.frame:RegisterEvent("PLAYER_LOGIN")
	private.frame:RegisterEvent("PLAYER_LOGOUT")
	private.frame:SetScript("OnEvent", private.OnEvent)
	-- Manually register LibTSMClass
	local libTSMClassModule = TSM.Init("LibTSMClass")
	local libTable = LibStub("LibTSMClass")
	for k, v in pairs(libTable) do
		libTSMClassModule[k] = v
	end
end
