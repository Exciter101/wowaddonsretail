local COMPAT, _, T = select(4,GetBuildInfo()), ...
if T.SkipLocalActionBook then return end
local MODERN, CF_CLASSIC, CI_ERA = COMPAT >= 10e4, COMPAT < 10e4, COMPAT < 2e4
local MODERN_CONTAINERS = MODERN or C_Container and C_Container.GetContainerNumSlots
local EV = T.Evie
local AB = T.ActionBook:compatible(2,21)
local RW = T.ActionBook:compatible("Rewire", 1,27)
local KR = T.ActionBook:compatible("Kindred", 1,14)
assert(EV and AB and RW and KR and 1, "Incompatible library bundle")
local L = T.ActionBook.L
local spellFeedback, itemHint, toyHint, mountHint, mountMap

local NormalizeInRange = {[0]=0, 1, [true]=1, [false]=0}
local _, CLASS = UnitClass("player")
local lowered = setmetatable({}, {__index=function(t,k)
	if k ~= nil then
		local r = type(k) == "string" and k:lower() or k
		t[k] = r
		return r
	end
end})
local callMethod = setmetatable({}, {__index=function(t,k)
	t[k] = function(self, ...)
		return self[k](self, ...)
	end
	return t[k]
end})

local function NewWidgetName(prefix)
	local bni, bn = 0 repeat
		bn, bni = prefix .. bni, bni + 1
	until GetClickFrame(bn) == nil
	return bn
end

if MODERN then -- mount: mount ID
	local function summonAction(mountID)
		return "func", C_MountJournal.SummonByID, mountID
	end
	if CLASS == "DRUID" then
		local clickPrefix do
			local MOONKIN_FORM = GetSpellInfo(24858)
			local bn = NewWidgetName("AB:M!")
			local b = CreateFrame("Button", bn, nil, "SecureActionButtonTemplate")
			b:SetAttribute("macrotext", "/cancelform [nocombat]")
			b:SetScript("PreClick", function()
				local sf = GetShapeshiftForm()
				local _, _, _, fsid = GetShapeshiftFormInfo(sf ~= 0 and sf or -1)
				local n = GetSpellInfo(fsid or -1)
				if not (InCombatLockdown() or n == MOONKIN_FORM) then
					b:SetAttribute("type", "macro")
				end
			end)
			b:SetScript("PostClick", function(_, btn)
				if not InCombatLockdown() then
					b:SetAttribute("type", nil)
				end
				btn = tonumber(btn)
				if btn then
					C_MountJournal.SummonByID(btn)
				end
			end)
			T.TenSABT(b)
			clickPrefix = SLASH_CLICK1 .. " " .. bn .. " "
		end
		summonAction = function(mountID)
			return "attribute", "type","macro", "macrotext",clickPrefix .. mountID
		end
	end

	local function checkUsableMountID(mid, myFactionId, trustMap, GetMountInfo)
		local _1, sid, _3, _4, _5, _6, _7, factionLocked, factionId, hide, have = (GetMountInfo or C_MountJournal.GetMountInfoByID)(mid)
		return (trustMap and trustMap[sid] or have and sid ~= 0 and not hide
		        and (not factionLocked or factionId == (myFactionId or UnitFactionGroup("player") == "Horde" and 0 or 1)) and sid ~= 0
		        and RW:IsSpellCastable(sid, 2)) and mid or nil, sid
	end
	local function mountSync()
		local changed, myFactionId = false, UnitFactionGroup("player") == "Horde" and 0 or 1
		local idm, GetMountInfo, oldID, curID, sid = C_MountJournal.GetMountIDs(), C_MountJournal.GetMountInfoByID
		for mid=1,#idm do
			mid = idm[mid]
			oldID, curID, sid = mountMap[sid], checkUsableMountID(mid, myFactionId, nil, GetMountInfo)
			if oldID ~= curID then
				local sname, srank, rname = GetSpellInfo(sid), GetSpellSubtext(sid)
				rname = sname .. "(" .. (srank or "") .. ")" -- Paladin/Warlock/Death Knight horses have spell ranks
				changed, mountMap[sid], mountMap[lowered[sname]], mountMap[lowered[rname]] =
					true, curID, curID, curID
			end
		end
		mountMap[150544] = 0
		if changed then AB:NotifyObservers("spell") end
	end
	function mountHint(id)
		local usable = (not (InCombatLockdown() or IsIndoors())) and HasFullControl() and not UnitIsDeadOrGhost("player")
		local cname, sid, icon, active, usable2 = C_MountJournal.GetMountInfoByID(id)
		local time, cdStart, cdLength = GetTime(), GetSpellCooldown(sid)
		return usable and cdStart == 0 and usable2, active and 1 or 0, icon, cname, 0, (cdStart or 0) > 0 and (cdStart+cdLength-time) or 0, cdLength, callMethod.SetMountBySpellID, sid
	end
	local actionMap = {}
	local function createMount(id)
		if type(id) == "number" and not actionMap[id] and checkUsableMountID(id, nil, mountMap) then
			actionMap[id] = AB:CreateActionSlot(mountHint, id, summonAction(id))
		end
		return actionMap[id]
	end
	local function describeMount(id)
		local name, sid, icon, _4, _5, _6, _7, factionLocked, factionId = C_MountJournal.GetMountInfoByID(id)
		if name and factionLocked then
			name = name .. (factionId == 0 and "|A:QuestPortraitIcon-Horde-small:14:14:0:-1|a" or "|A:QuestPortraitIcon-Alliance-small:15:13:-1:-1|a")
		end
		return L"Mount", name, icon, nil, callMethod.SetMountBySpellID, sid
	end
	AB:RegisterActionType("mount", createMount, describeMount)
	do -- random
		local rname, _, ricon = GetSpellInfo(150544)
		actionMap[0] = AB:CreateActionSlot(function()
			return HasFullControl() and not IsIndoors(), IsMounted() and 1 or 0, ricon, rname, 0, 0, 0, callMethod.SetMountBySpellID, 150544
		end, nil, summonAction(0))
		RW:SetCastEscapeAction(GetSpellInfo(150544), actionMap[0])
		RW:SetCastEscapeAction("spell:150544", actionMap[0])
	end
	EV.MOUNT_JOURNAL_USABILITY_CHANGED, EV.PLAYER_ENTERING_WORLD, EV.COMPANION_LEARNED = mountSync, mountSync, mountSync
	mountMap = {}
else
	function mountHint()
	end
	mountMap = {}
end
do -- spell: spell ID + mount spell ID
	local actionMap, spellMap = {}, {}
	local function isCurrentForm(q)
		local id = GetShapeshiftForm()
		if id == 0 then return end
		local _, _, _, sid = GetShapeshiftFormInfo(id)
		return q == sid or q == GetSpellInfo(sid or 0) or (sid and q and ("" .. sid) == q)
	end
	local SetSpellBookItem, SetSpellByID, SetSpellByExactID do
		if MODERN then
			function SetSpellBookItem(self, id)
				return self:SetSpellBookItem(id, BOOKTYPE_SPELL)
			end
			function SetSpellByID(self, ...)
				return self:SetSpellByID(...)
			end
			function SetSpellByExactID(self, id)
				return self:SetSpellByID(id, false, true, true)
			end
		else
			local tr1 = {}
			local function SetRankText(self, sid, ...)
				if sid then
					local tr = tr1[self]
					if tr == nil and self then
						local n = self:GetName()
						tr = n and _G[n .. "TextRight1"]
						tr = type(tr) == "table" and type(tr.IsObjectType) == "function" and tr:IsObjectType("FontString") and tr
						tr1[self] = tr or false
					end
					local sr = tr and not tr:IsShown() and GetSpellSubtext(sid) or ""
					if sr ~= "" then
						tr:SetText(sr)
						tr:SetTextColor(0.5, 0.5, 0.5)
						tr:Show()
						self:Show()
					end
				end
				return ...
			end
			function SetSpellBookItem(self, id)
				local st, sid = GetSpellBookItemInfo(id, BOOKTYPE_SPELL)
				return SetRankText(self, st == "SPELL" and sid, self:SetSpellBookItem(id, BOOKTYPE_SPELL))
			end
			function SetSpellByID(self, ...)
				return SetRankText(self, (...), self:SetSpellByID(...))
			end
			SetSpellByExactID = SetSpellByID
		end
	end
	local getSpellIDFromName = CI_ERA and function(n)
		return (select(7, GetSpellInfo(n or "")))
	end or function(n)
		return tonumber(((GetSpellLink(n) or ""):match("spell:(%d+)")))
	end
	local function spellHint(n, _modState, target)
		if not n then return end
		local nlow = lowered[n]
		local mmID = mountMap[nlow]
		if mmID then return mountHint(mmID) end
		local sname, _, _, _, _, _, sid = GetSpellInfo(n)
		if not sname then return end
		local time, msid = GetTime(), spellMap[nlow] or sid
		local inRange, usable, nomana, hasRange = NormalizeInRange[IsSpellInRange(n, target or "target")], IsUsableSpell(n)
		inRange, hasRange = inRange ~= 0, inRange ~= nil
		local cooldown, cdLength, enabled = GetSpellCooldown(n)
		local cdLeft = (cooldown or 0) > 0 and (enabled ~= 0) and (cooldown + cdLength - time) or 0
		local count, charges, maxCharges, chargeStart, chargeDuration = GetSpellCount(n), GetSpellCharges(n)
		local state = ((IsSelectedSpellBookItem(n) or IsCurrentSpell(n) or isCurrentForm(n)  or enabled == 0) and 1 or 0) +
		              (MODERN and IsSpellOverlayed(msid or 0) and 2 or 0) + (nomana and 8 or 0) + (inRange and 0 or 16) + (charges and charges > 0 and 64 or 0) +
		              (hasRange and 512 or 0) + (usable and 0 or 1024) + (enabled == 0 and 2048 or 0)
		usable = not not (usable and inRange and (cooldown or 0) == 0 or (enabled == 0))
		if charges and maxCharges and charges < maxCharges and cdLeft == 0 then
			cdLeft, cdLength = chargeStart-time + chargeDuration, chargeDuration
		end
		local sbslot = msid and msid ~= 161691 and FindSpellBookSlotBySpellID(msid)
		return usable, state, GetSpellTexture(n), sname or n, count <= 1 and charges or count, cdLeft, cdLength, sbslot and SetSpellBookItem or msid and SetSpellByID, sbslot or msid
	end
	function spellFeedback(sname, target, spellId)
		spellMap[sname] = spellId or spellMap[sname] or getSpellIDFromName(sname)
		return spellHint(sname, nil, target)
	end
	local function createSpell(id, optToken)
		if type(id) ~= "number" then return end
		local action = mountMap[id]
		if action then
			return AB:GetActionSlot("mount", action)
		end
		
		local laxRank = CF_CLASSIC and optToken ~= "lock-rank" and "lax-rank"
		local castable, rwCastType = RW:IsSpellCastable(id, nil, laxRank)
		if not castable then
			return
		elseif rwCastType == "forced-id-cast" then
			action = id
		elseif rwCastType == "rewire-escape" then
			return AB:GetActionSlot("macrotext", SLASH_CAST1 .. " " .. GetSpellInfo(id))
		else
			local s0, r0 = GetSpellInfo(id), GetSpellSubtext(id)
			local o, s = pcall(GetSpellInfo, s0, r0)
			if laxRank and not (o and s) then
				o, s = pcall(GetSpellInfo, s0)
			end
			if not (o and s and s0) then
				return
			end
			local r1 = laxRank and r0 or GetSpellSubtext(s0)
			action = (r0 and r1 ~= r0 and (CF_CLASSIC or FindSpellBookSlotBySpellID(id))) and (s0 .. "(" .. r0 .. ")") or s0
			id = CF_CLASSIC and select(7, GetSpellInfo(action)) or id
		end
		
		if action then
			if not actionMap[action] then
				actionMap[action] = AB:CreateActionSlot(spellHint, action, "attribute", "type","spell", "spell",action, "checkselfcast",true, "checkfocuscast",true)
			end
			if type(action) == "string" and spellMap[action] ~= id then
				spellMap[lowered[action]] = id
			end
		end
		return actionMap[action]
	end
	local function describeSpell(q, id, optToken)
		local name2, sid2, icon2, rank, name, _, icon, _, _, _, _, icon1 = nil, nil, nil, GetSpellSubtext(id), GetSpellInfo(id)
		local laxRank = CF_CLASSIC and optToken ~= "lock-rank" and "lax-rank"
		local _, castType = RW:IsSpellCastable(id, nil, laxRank)
		if name and castType ~= "forced-id-cast" then
			local qRank = (MODERN or q == "list-query" or not laxRank) and rank or nil
			rank, name2, _, icon2, _, _, _, sid2 = GetSpellSubtext(name, rank), GetSpellInfo(name, qRank)
			if MODERN and sid2 and IsPassiveSpell(sid2) then
				icon, name2, icon2 = icon1 or icon, nil, nil
			end
		end
		local srank = rank and rank ~= "" and (rank ~= GetSpellSubtext(name) or (CF_CLASSIC and rank ~= GetSpellSubtext(name, (rank:gsub("%d+", "1"))))) and " (" .. rank .. ")" or ""
		local ts, ns = q == "list-query" and srank or "", (laxRank or q == "list-query") and "" or srank
		return mountMap[id] and L"Mount" or (L"Spell" .. ts), (name2 or name or "?") .. ns, icon2 or icon, nil, SetSpellByExactID, id
	end
	AB:RegisterActionType("spell", createSpell, describeSpell, nil, true)
	if MODERN then -- specials
		local gab = GetSpellInfo(161691)
		actionMap[gab] = AB:CreateActionSlot(spellHint, gab, "conditional", "[outpost]", "attribute", "type","spell", "spell",gab)
		spellMap[lowered[gab]] = 161691
		actionMap[150544] = AB:GetActionSlot("mount", 0)
	end
	
	function EV.SPELLS_CHANGED()
		for k, v in pairs(spellMap) do
			if v ~= 161691 then
				spellMap[k] = nil
			end
		end
		AB:NotifyObservers("spell")
	end
end
do -- item: items ID/inventory slot
	local actionMap, itemIdMap, lastSlot = {}, {}, INVSLOT_LAST_EQUIPPED
	local function containerTip(self, bagslot)
		local slot = bagslot % 100
		self:SetBagItem((bagslot-slot)/100, slot)
	end
	local function playerInventoryTip(self, slot)
		self:SetInventoryItem("player", slot)
	end
	local function GetItemLocation(iid, name, name2)
		local name2, cb, cs, n = name2 and lowered[name2]
		for i=1, lastSlot do
			if GetInventoryItemID("player", i) == iid then
				n = GetItemInfo(GetInventoryItemLink("player", i))
				if n == name or n and name2 and lowered[n] == name2 then
					return nil, i
				elseif not cs then
					cb, cs = nil, i
				end
			end
		end
		local ns = MODERN_CONTAINERS and C_Container.GetContainerNumSlots or GetContainerNumSlots
		local giid = MODERN_CONTAINERS and C_Container.GetContainerItemID or GetContainerItemID
		local gil = MODERN_CONTAINERS and C_Container.GetContainerItemLink or GetContainerItemLink
		for i=0,4 do
			for j=1, ns(i) do
				if iid == giid(i, j) then
					n = GetItemInfo(gil(i, j))
					if n == name or n and name2 and lowered[n] == name2 then
						return i, j
					elseif not cs then
						cb, cs = i, j
					end
				end
			end
		end
		return cb, cs
	end
	function itemHint(ident, _modState, target, purpose, ibag, islot)
		local name, link, icon, _, bag, slot, tip, tipArg
		if type(ident) == "number" and ident <= lastSlot then
			local invid = GetInventoryItemID("player", ident)
			if invid == nil then return end
			bag, slot, name, link = nil, invid, GetItemInfo(GetInventoryItemLink("player", ident) or invid)
			if name then ident = name end
		elseif ident then
			name, link, _, _, _, _, _, _, _, icon = GetItemInfo(ident)
		end
		local iid, cdStart, cdLen, enabled, cdLeft = (link and tonumber(link:match("item:([x%x]+)"))) or itemIdMap[ident]
		if MODERN and iid and PlayerHasToy(iid) and GetItemCount(iid) == 0 then
			return toyHint(iid, nil, target)
		elseif iid then
			cdStart, cdLen, enabled = (MODERN_CONTAINERS and C_Container.GetItemCooldown or GetItemCooldown)(iid)
			local time = GetTime()
			cdLeft = (cdStart or 0) > 0 and (enabled ~= 0) and (cdStart + cdLen - time)
		end
		local inRange, hasRange = NormalizeInRange[IsItemInRange(ident, target or "target")]
		inRange, hasRange = inRange ~= 0, inRange ~= nil
		if ibag and islot then
			bag, slot = ibag, islot
		elseif iid then
			bag, slot = GetItemLocation(iid, name, ident)
		end
		if bag and slot then
			tip, tipArg = containerTip, bag * 100 + slot
		elseif slot then
			tip, tipArg = playerInventoryTip, slot
		elseif iid then
			tip, tipArg = callMethod.SetItemByID, iid
		end
		local nCharge = GetItemCount(ident, false, true) or 0
		local usable = nCharge > 0 and (GetItemSpell(ident) == nil or IsUsableItem(ident))
		local qual = MODERN and ident and (C_TradeSkillUI.GetItemReagentQualityByItemInfo(ident) or C_TradeSkillUI.GetItemCraftedQualityByItemInfo(ident))
		qual = qual and qual > 0 and qual < 8 and (qual * 16384) or 0
		local state = (IsCurrentItem(ident) and 1 or 0) + (inRange and 0 or 16) + (slot and IsEquippableItem(ident) and (bag and (purpose == "equip" and 128 or 0) or (slot and 256 or 0)) or 0) + (hasRange and 512 or 0) + (usable and 0 or 1024) + (enabled == 0 and 2048 or 0) + qual
		return not not (usable and inRange and (cdLen or 0) == 0), state, icon or GetItemIcon(ident), name or ident, nCharge,
			cdLeft or 0, cdLen or 0, tip, tipArg
	end
	local function createItem(id, byName, forceShow, onlyEquipped)
		if type(id) ~= "number" then return end
		local name = id <= lastSlot and id or (byName and GetItemInfo(id) or ("item:" .. id))
		if not forceShow and onlyEquipped and not ((id > lastSlot and IsEquippedItem(name)) or (id <= lastSlot and GetInventoryItemLink("player", id))) then return end
		if not forceShow and GetItemCount(name) == 0 then return end
		if not actionMap[name] then
			actionMap[name], itemIdMap[name] = AB:CreateActionSlot(itemHint, name, "attribute", "type","item", "item",name, "checkselfcast",true, "checkfocuscast",true), id
		end
		return actionMap[name]
	end
	local function describeItem(id)
		local cat, cq = L"Item", MODERN and id and (C_TradeSkillUI.GetItemReagentQualityByItemInfo(id) or C_TradeSkillUI.GetItemCraftedQualityByItemInfo(id))
		cat = cq and cat .. "|A:Professions-Icon-Quality-Tier" .. cq .. "-Small:0:0:2:0|a" or cat
		return cat, GetItemInfo(id), GetItemIcon(id), nil, callMethod.SetItemByID, tonumber(id)
	end
	AB:RegisterActionType("item", createItem, describeItem, {"byName", "forceShow", "onlyEquipped"})
	function EV.BAG_UPDATE()
		AB:NotifyObservers("item")
	end
	RW:SetCommandHint(SLASH_EQUIP1, 70, function(_, _, clause, target)
		if clause and clause ~= "" and GetItemInfo(clause) then
			return true, itemHint(clause, nil, target, "equip")
		end
	end)
	RW:SetCommandHint(SLASH_EQUIP_TO_SLOT1, 70, function(_, _, clause)
		local item = clause and clause:match("^%s*%d+%s+(.*)")
		if item then
			return RW:GetCommandAction(SLASH_EQUIP1, item)
		end
	end)
end
do -- macrotext
	local map = {}
	local function macroHint(mtext, modLockState)
		return RW:GetMacroAction(mtext, modLockState)
	end
	local function createMacrotext(macrotext)
		if type(macrotext) ~= "string" then return end
		if not map[macrotext] then
			map[macrotext] = AB:CreateActionSlot(macroHint, macrotext, "recall", RW:seclib(), "RunMacro", macrotext, false, true)
		end
		return map[macrotext]
	end
	local function describeMacrotext(macrotext)
		if macrotext == "" then return L"Custom Macro", L"New Macro", "Interface/Icons/INV_Misc_Note_03" end
		local _, _, ico = RW:GetMacroAction(macrotext)
		return L"Custom Macro", "", ico
	end
	AB:RegisterActionType("macrotext", createMacrotext, describeMacrotext)
	local function checkReturn(pri, ...)
		if select("#", ...) > 0 then return pri, ... end
	end
	local function checkCountReturn(pri, ...)
		if select("#", ...) > 0 then
			local _, _, _, _, nc = ...
			return nc == 0 and pri - 1 or pri, ...
		end
	end
	local function canUseViaSCUI(clause)
		if (tonumber(clause) or 0) > INVSLOT_LAST_EQUIPPED then
			-- SCUI will pass to UseInventoryItem
			return false
		end
		return true
	end
	RW:SetCommandHint("/use", 100, function(_, _, clause, target, _, _, msg)
		if not clause or clause == "" then return end
		local isItemReturn, link, bag, slot = false, SecureCmdItemParse(clause)
		if (bag and slot) or (link and GetItemInfoInstant(link)) then
			if msg == "castrandom-fallback" or canUseViaSCUI(clause) then
				isItemReturn = true
			end
		end
		if isItemReturn then
			return checkCountReturn(90, itemHint(link, nil, target, nil, bag, slot))
		end
		local sid = clause:match("^spell:(%d+)$")
		if sid or not tonumber(clause, 10) then
			return checkReturn(true, spellFeedback(sid or clause, target))
		end
	end)
	RW:SetCommandHint("/cast", 100, function(_, _, clause, target, _, _, msg)
		if not clause or clause == "" then return end
		local sex = DoesSpellExist(clause) and not tonumber(clause, 10)
		local sid = not sex and clause:match("^spell:(%d+)$")
		if sex or sid then
			return checkReturn(true, spellFeedback(sid or clause, target))
		else
			local link, bag, slot = SecureCmdItemParse(clause)
			if ((bag and slot) or (link and GetItemInfoInstant(link))) and
			   (msg == "castrandom-fallback" or canUseViaSCUI(clause)) then
				return checkCountReturn(90, itemHint(link, nil, target, nil, bag, slot))
			end
		end
	end)
	RW:SetCommandHint(SLASH_CASTSEQUENCE1, 100, function(_, _, clause, target)
		if not clause or clause == "" then return end
		local _, item, spell = QueryCastSequence(clause)
		clause = (item or spell)
		if clause then
			return RW:GetCommandAction("/use", clause, target)
		end
	end)
	do -- /userandom
		local f, seed = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate"), math.random(2^30)
		f:SetFrameRef("RW", RW:seclib())
		f:Execute("seed, t, RW = " .. seed .. ", newtable(), self:GetFrameRef('RW'), self:SetAttribute('frameref-RW', nil)")
		f:SetAttribute("RunSlashCmd", [[--
			local cmd, v, target, s = ...
			if v == "" or not v then
				return
			elseif not t[v] then
				local tv, tn = newtable(), 1
				for f in v:gmatch("[^,]+") do
					tv[tn], tn = f:match("^%s*(.-)%s*$"), tn + 1
				end
				t[v], tv[0] = tv, seed
			end
			v = t[v]
			v, v[0] = v[1 + v[0] % #v], (v[0] * 12616645 + 16777213) % 2^32
			return RW:RunAttribute("RunSlashCmd", "/cast", v, target, "opt-into-cr-fallback")
		]])
		RW:RegisterCommand(SLASH_USERANDOM1, true, true, f)
		local sc, ic = GetManagedEnvironment(f).t, {}
		RW:SetCommandHint(SLASH_USERANDOM1, 50, function(_, _, clause, target)
			if not clause or clause == "" then return end
			local t1, t, n = sc[clause]
			t = t1 or ic[clause]
			if t1 then
				ic[clause] = nil
			elseif not t then
				t, n = {[0]=seed}, 0
				for s in clause:gmatch("[^,]+") do
					t[n+1], n = s, n + 1
				end
				ic[clause] = t
			end
			if t then
				local nextArg = t[1 + t[0] % #t]
				local nextN = tonumber(nextArg)
				if nextN and nextN > 20 and GetItemInfo(nextN) then
					nextArg = "item:" .. nextArg
				end
				return RW:GetCommandAction("/use", nextArg, target, nil, "castrandom-fallback")
			end
		end)
	end
end
do -- macro: name
	local map, sm = {}, {} do
		local wmSynced, owner = true, RW:RegisterNamedMacroTextOwner("ab-macro-wrapper", 10)
		local function syncWMacros()
			local notify, numGlobal, numChar = false, GetNumMacros()
			for k in pairs(sm) do
				if not GetMacroInfo(k) then
					notify, sm[k] = RW:SetNamedMacroText(k, nil, owner, true) or notify, nil
				end
			end
			local ofs = MAX_ACCOUNT_MACROS - numGlobal
			for i=1,numGlobal + numChar do
				local k, _, text = GetMacroInfo((i > numGlobal and ofs or 0)+i)
				if k and text ~= sm[k] then
					notify, sm[k] = RW:SetNamedMacroText(k, "#abmacrowrap " .. k .. "\n" .. text, owner, true) or notify, text
				end
			end
			if notify then
				AB:NotifyObservers("macro")
			end
			wmSynced = true
			return "remove"
		end
		function EV.UPDATE_MACROS()
			if not InCombatLockdown() then
				syncWMacros()
			elseif wmSynced then
				EV.PLAYER_REGEN_ENABLED, wmSynced = syncWMacros, nil
			end
		end
	end
	RW:SetMetaHintFilter("abmacrowrap", "macroFallback", false, function(_meta, v)
		if sm[v] then
			local n, ico = GetMacroInfo(v)
			return true, not not n, ico, v
		end
	end)
	local function namedMacroHint(name, cndState)
		return RW:GetNamedMacroAction(name, cndState)
	end
	local function createNamedMacro(name, forceShow)
		if type(name) == "string" and (forceShow or RW:IsNamedMacroKnown(name)) then
			if not map[name] then
				map[name] = AB:CreateActionSlot(namedMacroHint, name, "recall", RW:seclib(), "RunSlashCmd", "/runmacro", name)
			end
			return map[name]
		end
	end
	local function describeMacro(name)
		local _, ico
		if RW:IsNamedMacroKnown(name) then
			_, _, ico = RW:GetNamedMacroAction(name)
		end
		return L"Macro", name, ico
	end
	AB:RegisterActionType("macro", createNamedMacro, describeMacro, {"forceShow"})
end
if MODERN then -- battlepet: pet ID, species ID
	local petAction, special = {}, {}
	local function SetBattlePetByID(self, id)
		local sid, cname, lvl, _, _, _, _, name, _, ptype, _, _, desc, _, cb = C_PetJournal.GetPetInfoByPetID(id)
		if not sid then return false end
		local hp, mhp, ap, spd, rarity = C_PetJournal.GetPetStats(id)
		local qc, hc, icof = ITEM_QUALITY_COLORS[rarity-1], HIGHLIGHT_FONT_COLOR, "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:0:0:32:32:%d:%d:%d:%d|t %s"
		self:AddLine(cname or name, qc.r, qc.g, qc.b)
		if cb then
			self:AddLine(UNIT_TYPE_LEVEL_TEMPLATE:format(lvl, _G["BATTLE_PET_NAME_".. ptype]), hc.r, hc.g, hc.b)
			self:AddLine(icof:format(0, 16, 0, 16, ap) .. "   " .. icof:format(0, 16, 16, 32, spd) .. "   " .. icof:format(16,32,16,32, hp < mhp and (hp .. "/" .. mhp) or hp), hc.r, hc.g, hc.b)
		elseif desc then
			local nc = NORMAL_FONT_COLOR
			self:AddLine(desc, nc.r, nc.g, nc.b, 1)
		end
	end
	local function battlepetHint(pid)
		local sid, cn, _, _, _, _, _, n, tex = C_PetJournal.GetPetInfoByPetID(pid)
		local cooldown, duration, enabled = C_PetJournal.GetPetCooldownByGUID(pid)
		local cdLeft = (cooldown or 0) > 0 and (enabled ~= 0) and (cooldown + duration - GetTime())
		local active = C_PetJournal.GetSummonedPetGUID()
		local state = (active and active:upper()) == pid and 1 or 0
		return sid and not cdLeft and not C_PetJournal.PetIsRevoked(pid), state, tex, cn or n or "", 0, cdLeft or 0, duration or 0, SetBattlePetByID, pid
	end
	do -- random favorite pet
		local rname, _, ricon = GetSpellInfo(243819)
		local function randFaveHint()
			return HasFullControl(), C_PetJournal.GetSummonedPetGUID() and 1 or 0, ricon, rname, 0, 0, 0, callMethod.SetSpellByID, 243819
		end
		petAction.fave = AB:CreateActionSlot(randFaveHint, nil, "attribute", "type","macro", "macrotext",SLASH_RANDOMFAVORITEPET1)
		RW:ImportSlashCmd("RANDOMFAVORITEPET", true, false, 20, function(_, _, clause, _target)
			if clause then
				return true, randFaveHint()
			end
		end)
		RW:SetCastEscapeAction(GetSpellInfo(243819), petAction.fave)
		RW:SetCastEscapeAction("spell:243819", petAction.fave)
		function special.fave()
			return L"Battle Pet", rname, ricon, nil, callMethod.SetSpellByID, 243819
		end
	end
	local GetBattlePetInfo do -- (petID[, speciesID])
		local function checkInfoReturn(pid, spid, ok, ...)
			if ok and ... then
				return pid, ...
			elseif spid then
				local sn = C_PetJournal.GetPetInfoBySpeciesID(spid)
				local _, pid = C_PetJournal.FindPetIDByName(sn ~= "" and sn or "---")
				if pid then
					return GetBattlePetInfo(pid)
				end
			end
		end
		function GetBattlePetInfo(pid, spid)
			return checkInfoReturn(pid, spid, pcall(C_PetJournal.GetPetInfoByPetID, pid))
		end
	end
	local function createBattlePet(pid, spid)
		if special[pid] then return petAction[pid] end
		local rpid = GetBattlePetInfo(pid, spid)
		if not rpid then return end
		local pk = rpid:upper()
		if not petAction[pk] then
			petAction[pk] = AB:CreateActionSlot(battlepetHint, rpid, "func", C_PetJournal.SummonPetByGUID, rpid)
		end
		return petAction[pk]
	end
	local function describeBattlePet(pid, spid)
		if special[pid] then return special[pid]() end
		local rpid, _, cn, lvl, _, _, _, _, n, tex = GetBattlePetInfo(pid, spid)
		if not rpid then return L"Battle Pet", "?" end
		if (cn or n) and ((lvl or 0) > 1) then cn = "[" .. lvl .. "] " .. (cn or n) end
		return L"Battle Pet", cn or n or ("#" .. tostring(rpid)), tex, nil, SetBattlePetByID, rpid
	end
	AB:RegisterActionType("battlepet", createBattlePet, describeBattlePet)
	RW:SetCommandHint(SLASH_SUMMON_BATTLE_PET1, 60, function(_, _, clause)
		if clause and clause ~= "" then
			local _, petID = C_PetJournal.FindPetIDByName(clause:trim())
			if petID then
				return true, battlepetHint(petID)
			end
		end
	end)
end
if MODERN then -- equipmentset: equipment sets by name
	local setMap = {}
	local function resolveIcon(fid)
		return type(fid) == "number" and fid or ("Interface/Icons/" .. (fid or "INV_Misc_QuestionMark"))
	end
	local function equipmentsetHint(name)
		local esid = name and C_EquipmentSet.GetEquipmentSetID(name) or -1
		local _, icon, _, active, total, equipped, available = C_EquipmentSet.GetEquipmentSetInfo(esid)
		if icon then
			return total == equipped or (available > 0), active and 1 or 0, resolveIcon(icon), name, nil, 0, 0, callMethod.SetEquipmentSet, esid
		end
	end
	function EV.EQUIPMENT_SETS_CHANGED()
		AB:NotifyObservers("equipmentset")
	end
	local function createEquipSet(name)
		local sid = type(name) == "string" and C_EquipmentSet.GetEquipmentSetID(name)
		if not sid then return end
		if not setMap[name] then
			setMap[name] = AB:CreateActionSlot(equipmentsetHint, name, "attribute", "type","equipmentset", "equipmentset",name)
		end
		return setMap[name]
	end
	local function describeEquipSet(name)
		local esid = name and C_EquipmentSet.GetEquipmentSetID(name) or -1
		local _, ico = C_EquipmentSet.GetEquipmentSetInfo(esid)
		return L"Equipment Set", name, ico and resolveIcon(ico) or "Interface/Icons/INV_Misc_QuestionMark", nil, callMethod.SetEquipmentSet, esid
	end
	AB:RegisterActionType("equipmentset", createEquipSet, describeEquipSet)
	RW:SetCommandHint(SLASH_EQUIP_SET1, 80, function(_, _, clause)
		if clause and clause ~= "" then
			return true, equipmentsetHint(clause)
		end
	end)
end
do -- raidmark
	local map, waitingToClearSelf = {}
	local function CanChangeRaidTargets(unit)
		return not not ((not IsInRaid() or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) and not (unit and UnitIsPlayer(unit) and UnitIsEnemy("player", unit)))
	end
	local function click(id)
		if GetRaidTargetIndex("target") == id then id = 0 end
		SetRaidTarget("target", id)
	end
	local function raidmarkHint(i, _, target)
		local target = target or "target"
		return CanChangeRaidTargets(target), GetRaidTargetIndex(target) == i and 1 or 0, "Interface/TargetingFrame/UI-RaidTargetingIcon_" .. i, _G["RAID_TARGET_" .. i], 0, 0, 0
	end
	local function removeHint()
		return CanChangeRaidTargets(), 0, "Interface/Icons/INV_Gauntlets_02", REMOVE_WORLD_MARKERS, 0, 0, 0
	end
	local function FinishClearRaidTargets()
		if waitingToClearSelf and GetRaidTargetIndex("player") == 1 then
			waitingToClearSelf = nil
			if CanChangeRaidTargets() then
				SetRaidTarget("player", 0)
			end
			return "remove"
		end
	end
	map[0] = AB:CreateActionSlot(removeHint, nil, "func", function()
		if not CanChangeRaidTargets() then return end
		local pt = GetRaidTargetIndex("player")
		for i=8, 0, -1 do
			SetRaidTarget("player", i == pt and 1 or i == 1 and pt or i)
		end
		if not (pt or waitingToClearSelf) and IsInGroup() then
			waitingToClearSelf, EV.RAID_TARGET_UPDATE = 1, FinishClearRaidTargets
		end
	end)
	for i=1,8 do
		map[i] = AB:CreateActionSlot(raidmarkHint, i, "func", click, i)
	end
	local function createRaidMark(id)
		return map[id]
	end
	local function describeRaidMark(id)
		if id == 0 then return L"Raid Marker", REMOVE_WORLD_MARKERS, "Interface/Icons/INV_Gauntlets_02" end
		return L"Raid Marker", _G["RAID_TARGET_" .. id], "Interface/TargetingFrame/UI-RaidTargetingIcon_" .. id
	end
	AB:RegisterActionType("raidmark", createRaidMark, describeRaidMark)
	RW:ImportSlashCmd("TARGET_MARKER", true, false, 40, function(_, _, clause, target)
		clause = tonumber(clause)
		if clause == 0 then
			return true, removeHint()
		elseif clause then
			return true, raidmarkHint(clause, nil, target)
		end
	end)
end
if MODERN then -- worldmarker
	local map, icons = {}, {[0]="Interface/Icons/INV_Misc_PunchCards_White",
		"Interface/Icons/INV_Misc_QirajiCrystal_04","Interface/Icons/INV_Misc_QirajiCrystal_03",
		"Interface/Icons/INV_Misc_QirajiCrystal_05","Interface/Icons/INV_Misc_QirajiCrystal_02",
		"Interface/Icons/INV_Misc_QirajiCrystal_01","Interface/Icons/INV_Elemental_Primal_Fire",
		"Interface/Icons/INV_jewelcrafting_taladiterecrystal","Interface/Icons/INV_jewelcrafting_taladitecrystal"}
	local function worldmarkHint(i)
		return not not (IsInGroup() and (not IsInRaid() or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or IsEveryoneAssistant())), i > 0 and IsRaidMarkerActive(i) and 1 or 0, icons[i], i == 0 and REMOVE_WORLD_MARKERS or _G["WORLD_MARKER" .. i], 0, 0, 0
	end
	for i=1, 8 do
		map[i] = AB:CreateActionSlot(worldmarkHint, i, "attribute", "type","worldmarker", "action","toggle", "marker",i)
	end
	map[0] = AB:CreateActionSlot(worldmarkHint, 0, "attribute", "type","macro", "macrotext",SLASH_CLEAR_WORLD_MARKER1 .. " " .. ALL)
	local function createWorldmark(id)
		return map[id]
	end
	local function describeWorldmark(id)
		return L"Raid World Marker", id == 0 and REMOVE_WORLD_MARKERS or _G["WORLD_MARKER" .. id], icons[id]
	end
	AB:RegisterActionType("worldmark", createWorldmark, describeWorldmark)
	RW:SetCommandHint(SLASH_WORLD_MARKER1, 40, function(_, _, clause)
		clause = tonumber(clause)
		if clause and clause >= 1 and clause <= 8 then
			return true, worldmarkHint(clause)
		end
	end)
end
if MODERN then -- extrabutton
	local slot = GetExtraBarIndex()*12 - 11
	local function extrabuttonHint()
		if not HasExtraActionBar() then
			return false, 0, "Interface/Icons/temp", "", 0, 0, 0
		end
		local at, aid = GetActionInfo(slot)
		local inRange, usable, nomana, hasRange = NormalizeInRange[IsActionInRange(slot)], IsUsableAction(slot)
		inRange, hasRange = inRange ~= 0, inRange ~= nil
		local cooldown, cdLength, enabled = GetActionCooldown(slot)
		local cdLeft = (cooldown or 0) > 0 and (enabled ~= 0) and (cooldown + cdLength - GetTime()) or 0
		local count, charges, maxCharges, chargeStart, chargeDuration = GetActionCount(slot), GetActionCharges(slot)
		local state = ((IsCurrentAction(slot) or enabled == 0) and 1 or 0) +
		              (at == "spell" and IsSpellOverlayed(aid) and 2 or 0) +
		              (nomana and 8 or 0) + (inRange and 0 or 16) + (charges and charges > 0 and 64 or 0) + (hasRange and 512 or 0) + (usable and 0 or 1024)
		if charges and maxCharges and charges < maxCharges and cdLeft == 0 then
			local time = GetTime()
			cdLeft, cdLength = chargeStart-time + chargeDuration, chargeDuration
		end
		usable = not not (usable and inRange and ((cooldown == nil or cooldown == 0) or (enabled == 0) or (charges > 0)))
		return usable, state, GetActionTexture(slot), GetActionText(slot) or (at == "spell" and GetSpellInfo(aid)), count <= 1 and charges or count, cdLeft, cdLength, callMethod.SetAction, slot
	end
	local aid = AB:CreateActionSlot(extrabuttonHint, nil, "conditional", "[extrabar]", "attribute", "type","action", "action",slot)
	local aid2 = AB:CreateActionSlot(extrabuttonHint, nil, "attribute", "type","action", "action",slot)
	local function createExtraButton(id, forceShow)
		return id == 1 and (forceShow and aid2 or aid) or nil
	end
	local function describeExtraButton(_id)
		local name, tex = L"Extra Action Button", "Interface/Icons/Temp"
		if HasExtraActionBar() then
			local at, aid = GetActionInfo(slot)
			name, tex = GetActionText(slot) or (at == "spell" and GetSpellInfo(aid)) or name, GetActionTexture(slot) or tex
		end
		return L"Extra Action Button", name, tex
	end
	AB:RegisterActionType("extrabutton", createExtraButton, describeExtraButton, {"forceShow"})
	RW:SetClickHint("ExtraActionButton1", 95, function()
		if HasExtraActionBar() then
			return true, extrabuttonHint()
		end
	end)
end
do -- petspell: spell ID
	local actionInfo = {
		stay={"Interface\\Icons\\Spell_Nature_TimeStop", "PET_ACTION_WAIT"},
		move={"Interface\\Icons\\Ability_Hunter_Pet_Goto", "PET_ACTION_MOVE_TO", 1},
		follow={"Interface\\Icons\\Ability_Tracking", "PET_ACTION_FOLLOW"},
		attack={"Interface\\Icons\\Ability_GhoulFrenzy", "PET_ACTION_ATTACK"},
		defend={"Interface\\Icons\\Ability_Defend", "PET_MODE_DEFENSIVE"},
		assist={"Interface\\Icons\\Ability_Hunter_Pet_Assist", "PET_MODE_ASSIST"},
		passive={"Interface\\Icons\\Ability_Seal", "PET_MODE_PASSIVE"},
		dismiss={CLASS == "WARLOCK" and "Interface\\Icons\\spell_shadow_sacrificialshield" or "Interface\\Icons\\spell_nature_spiritwolf"}
	}
	local actionID = {}
	local petTip = MODERN and function(self, slot)
		return self:SetSpellBookItem(slot, "pet")
	end or function(self, slot)
		return self:SetPetAction(slot)
	end
	local petCommandFeedback = MODERN and function(info)
		local ico, name, slot = info[1], info[2], info[3]
		if GetSpellBookItemTexture(slot or 0, "pet") ~= ico then
			slot = nil
			for i=1,HasPetSpells() or 0 do
				if GetSpellBookItemTexture(i, "pet") == ico and GetSpellBookItemInfo(i, "pet") == "PETACTION" then
					info[3], slot = i, i
					break
				end
			end
		end
		return not not slot, slot and IsSelectedSpellBookItem(slot, "pet") and 1 or 0, ico, _G[name] or (slot and GetSpellBookItemName(slot, "pet")) or "", 0, 0, 0, slot and petTip or nil, slot
	end or function(info)
		local ico, name, slot = info[1], info[2], info[3]
		local sname, _icokey, _isToken, isActive, _autoCastAllowed, _autoCastEnabled, _spellID, hasRange, inRange = GetPetActionInfo(slot or 0)
		if sname ~= name then
			info[3], slot = nil
			for i=1,10 do
				sname, _icokey, _isToken, isActive, _autoCastAllowed, _autoCastEnabled, _spellID, hasRange, inRange = GetPetActionInfo(i)
				if sname == name then
					info[3], slot = i, i
					break
				end
			end
		end
		local flags = slot and (isActive and 1 or 0 + (hasRange and not inRange and 16 or 0) + (hasRange and 512 or 0)) or 0
		return not not slot and (inRange or not hasRange), flags, ico, _G[name] or name, 0, 0, 0, slot and petTip or nil, slot
	end
	local function petHint(sid)
		local info = actionInfo[sid]
		if sid == "dismiss" then
			if CLASS == "HUNTER" and PetCanBeAbandoned() then
				return spellFeedback(2641, nil, 2641)
			end
			return HasFullControl() and UnitExists("pet") and PetCanBeDismissed(), 0, info[1], PET_ACTION_DISMISS
		elseif info then
			return petCommandFeedback(info)
		elseif sid then
			return spellFeedback(sid, nil, sid)
		end
	end
	local function createPetAction(id)
		if type(id) == "number" and id > 0 and not actionID[id] and not IsPassiveSpell(id) then
			actionID[id] = AB:CreateActionSlot(petHint, id, "conditional","[petcontrol,known:" .. id .. "];hide", "attribute", "type","spell", "spell",id)
		end
		return actionID[id]
	end
	local function describePetAction(id)
		if type(id) == "number" then
			local name, _, icon = GetSpellInfo(id)
			return L"Pet Ability", name, icon, nil, callMethod.SetSpellByID, id
		elseif actionID[id] then
			local st, _, _, icon, name, _, _, _, tipf, tipa = nil, petHint(id)
			_, st = GetSpellBookItemName(tipa or 0, "pet")
			return MODERN and st or L"Pet Ability", name, icon, nil, tipf, tipa
		end
	end
	AB:RegisterActionType("petspell", createPetAction, describePetAction)
	do
		local cnd, macroMap = "[petcontrol,@pet,help,novehicleui]", {}
		local function check(...)
			if ... ~= nil then
				return true, ...
			end
		end
		local function petmacroHint(slash, _, clause, _target)
			local aid = clause and macroMap[slash]
			if aid then
				return check(petHint(aid))
			end
		end
		local function addPetCommand(cmd, key)
			actionID[key] = AB:CreateActionSlot(petHint, key, "conditional", cnd, "attribute", "type","macro", "macrotext",cmd)
			RW:SetCommandHint(cmd, 75, petmacroHint)
			macroMap[cmd:lower()] = key
		end
		addPetCommand(SLASH_PET_STAY1, "stay")
		addPetCommand(SLASH_PET_FOLLOW1, "follow")
		addPetCommand(SLASH_PET_ATTACK1, "attack")
		addPetCommand(SLASH_PET_DEFENSIVE1, "defend")
		addPetCommand(SLASH_PET_PASSIVE1, "passive")
		actionID.dismiss = AB:CreateActionSlot(petHint, "dismiss", "conditional", cnd, "attribute", "type","macro", "macrotext",SLASH_PET_DISMISS1)
		if MODERN then
			addPetCommand(SLASH_PET_MOVE_TO1, "move")
			addPetCommand(SLASH_PET_ASSIST1, "assist")
		else
			actionInfo.assist = {"Interface/Icons/Ability_Racial_BloodRage", "PET_MODE_AGGRESSIVE"}
			addPetCommand(SLASH_PET_AGGRESSIVE1, "assist")
		end
	end
end
if MODERN then -- toy: item ID, forceShow
	local map, lastUsability, uq, whinedAboutGIIR = {}, {}, {}
	local IGNORE_TOY_USABILITY = {
		[129149]=1, [129279]=1, [129367]=1, [130157]="[in:broken isles]", [130158]=1, [130170]=1,
		[130191]=1, [130199]=1, [130232]=1, [131812]=1, [131814]=1, [140325]=1, [147708]=1,
		[165021]=1,
		[153039]=1, [119421]=1, [128462]="[alliance]", [128471]="[horde]", [95589]="[alliance]", [95590]="[horde]",
		[89222]=1, [63141]="[alliance]", [64997]="[horde]", [66888]=1, [89869]=1, [90175]=1,
		[103685]=1, [115468]="[horde]", [115472]="[alliance]", [119160]="[horde]", [119182]="[alliance]",
		[122283]=1, [142531]=1, [142532]=1,
		[85500]="[fish5]",
		[182773]="[coven:necro][acoven80:necro]", [184353]="[coven:kyrian][acoven80:kyrian]", [180290]="[coven:fae][acoven80:fae]", [183716]="[coven:venthyr][acoven80:venthyr]", [190237] = 1,
	}
	function toyHint(iid)
		local _, name, icon = C_ToyBox.GetToyInfo(iid)
		local cdStart, cdLength = (MODERN_CONTAINERS and C_Container.GetItemCooldown or GetItemCooldown)(iid)
		local ignUse, usable = IGNORE_TOY_USABILITY[iid]
		if not PlayerHasToy(iid) then
			usable = false
		elseif ignUse == nil then
			usable = C_ToyBox.IsToyUsable(iid) ~= false
		else
			usable = ignUse == 1 or (not not KR:EvaluateCmdOptions(ignUse))
		end
		return name and cdStart == 0 and usable, 0, icon or GetItemIcon(iid), name, 0, (cdStart or 0) > 0 and (cdStart+cdLength-GetTime()) or 0, cdLength, callMethod.SetToyByItemID, iid
	end
	function EV:GET_ITEM_INFO_RECEIVED(iid, ok)
		if not (ok and uq[iid]) then
			return
		end
		local iu = C_ToyBox.IsToyUsable(iid)
		if iu ~= nil then
			lastUsability[iid], uq[iid] = iu, nil
		elseif not whinedAboutGIIR then
			whinedAboutGIIR = true
			error("Curse your sudden but inevitable betrayal [" .. iid .. "]")
		end
	end
	local function wrapCondition(cnd, ...)
		if (cnd or 1) == 1 then
			return ...
		else
			return "conditional", cnd, ...
		end
	end
	local function createToy(id, forceShow)
		local mid, ignUse = map[id], IGNORE_TOY_USABILITY[id]
		if not (mid or ignUse or type(id) == "number") or not (forceShow or PlayerHasToy(id)) then
			return
		end
		local isUsable = ignUse or C_ToyBox.IsToyUsable(id)
		if isUsable == nil then
			isUsable, uq[id] = lastUsability[id], 1
			GetItemInfo(id)
		elseif not ignUse then
			lastUsability[id] = isUsable
		end
		if not (forceShow or isUsable) then
			mid = nil
		elseif mid == nil then
			mid = AB:CreateActionSlot(toyHint, id, wrapCondition(ignUse, "attribute", "type","toy", "toy",id))
			map[id] = mid
		end
		return mid
	end
	local function describeToy(id)
		if type(id) ~= "number" then return end
		local _, name, tex = C_ToyBox.GetToyInfo(id)
		return L"Toy", name, tex, nil, callMethod.SetToyByItemID, id
	end
	AB:RegisterActionType("toy", createToy, describeToy, {"forceShow"})
	RW:SetCommandHint(SLASH_USE_TOY1, 60, function(_, _, clause, target)
		if clause and clause ~= "" then
			local _, link = GetItemInfo(clause)
			local iid = link and tonumber(link:match("item:([x%x]+)"))
			if iid then
				return true, toyHint(iid, nil, target)
			end
		end
	end)
end
do -- disenchant: iid
	local map, DISENCHANT_SID = {}, 13262
	local DISENCHANT_SN = GetSpellInfo(DISENCHANT_SID)
	local ICON_PREFIX = "|TInterface/Buttons/UI-GroupLoot-DE-Up:0:0|t "
	local SLASH_SPELL_TARGET_ITEM1 = '/spelltargetitem' do
		local wn = NewWidgetName("AB:I!")
		local w = T.TenSABT(CreateFrame("Button", wn, nil, "SecureActionButtonTemplate"))
		w:Hide()
		SecureHandlerWrapScript(w, "OnClick", w, [[return nil, 'post']], [[self:SetAttribute("target-item", nil)]])
		local er = {u="\\117", ["{"]="\\123", ["}"]="\\125"}
		local function escape(s)
			return ("%q"):format(s):gsub('[{u}]', er):sub(2,-2)
		end
		w:SetAttribute("RunSlashCmd", ([[-- AB_SPELLTARGET_ITEM_RUN 
			local cmd, v = ...
			if cmd == "%s" and v then
				self:SetAttribute("target-item", v)
				return "%s"
			end
		]]):format(escape(SLASH_SPELL_TARGET_ITEM1), escape(SLASH_CLICK1 .. " " .. wn)))
		RW:RegisterCommand(SLASH_SPELL_TARGET_ITEM1, true, false, w)
	end
	local function disenchantTip(self, iid)
		self:SetItemByID(iid)
		self:AddLine(ICON_PREFIX .. DISENCHANT_SN, 0, 1, 0)
		self:Show()
	end
	local function disenchantHint(ident)
		local count = GetItemCount(ident, false, false, false)
		local usable = IsPlayerSpell(DISENCHANT_SID) and count > 0
		local name = GetItemInfo(ident)
		local qual = MODERN and ident and (C_TradeSkillUI.GetItemReagentQualityByItemInfo(ident) or C_TradeSkillUI.GetItemCraftedQualityByItemInfo(ident))
		qual = qual and qual > 0 and qual < 8 and (qual * 16384) or 0
		local time, cdStart, cdLength = GetTime(), GetSpellCooldown(DISENCHANT_SID)
		local cdLeft = (cdStart or 0) > 0 and (cdStart + cdLength - time) or 0
		local state = (IsCurrentItem(ident) and 1 or 0) + (usable and 0 or 1024) + qual + 131072
		local disName = ICON_PREFIX .. (name or ("item:" .. ident))
		return not not (usable and (cdLength or 0) == 0), state, GetItemIcon(ident), disName, count,
			cdLeft or 0, cdLength or 0, disenchantTip, ident
	end
	local function createDisenchant(iid)
		if not (IsPlayerSpell(13262) and type(iid) == "number" and GetItemCount(iid) > 0) then
			return
		end
		local mid = map[iid]
		if not mid then
			local macrotext = ("%s\n%s [@none] spell:%d\n%s item:%d\n%1$s"):format(SLASH_STOPSPELLTARGET1, SLASH_CAST1, DISENCHANT_SID, SLASH_SPELL_TARGET_ITEM1, iid)
			mid = AB:CreateActionSlot(disenchantHint, iid, "recall", RW:seclib(), "RunMacro", macrotext)
			map[iid] = mid
		end
		return mid
	end
	local function describeDisenchant(iid)
		if type(iid) ~= "number" then return end
		local icon, name = GetItemIcon(iid), GetItemInfo(iid)
		return DISENCHANT_SN, name or ("item:" .. iid), icon, nil, disenchantTip, iid
	end
	AB:RegisterActionType("disenchant", createDisenchant, describeDisenchant)
end