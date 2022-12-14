local ADDON_NAME, private = ...

local Garrison = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)

local debugPrint, charInfo, timers = Garrison.debugPrint, Garrison.charInfo, Garrison.timers
local garrisonDb, globalDb, configDb

local _G = getfenv(0)

local pairs, time, C_Garrison, GetCurrencyInfo, tostring, math, C_Vignettes, InCombatLockdown = _G.pairs, _G.time, _G.C_Garrison, _G.GetCurrencyInfo, _G.tostring, _G.math, _G.C_Vignettes, _G.InCombatLockdown

Garrison.shipmentUpdate = {}

function Garrison:GARRISON_MISSION_COMPLETE_RESPONSE(event, missionID, canComplete, succeeded, overmaxSucceeded, followerDeaths)
    if (globalDb.data[charInfo.realmName][charInfo.playerName].missions[missionID]) then
        debugPrint("Removed Mission: " .. missionID .. " (" .. event .. ")")
        globalDb.data[charInfo.realmName][charInfo.playerName].missions[missionID] = nil
    else
        debugPrint("Unknown Mission: " .. missionID .. " (" .. event .. ")")
    end

    Garrison:Update()
end

function Garrison:GetInProgressMissions()
    local garrisonMission = {}

    local types = {
        LE_FOLLOWER_TYPE_GARRISON_7_0,
        LE_FOLLOWER_TYPE_GARRISON_6_0,
        LE_FOLLOWER_TYPE_SHIPYARD_6_2
    }

    for key, type in pairs(types) do
        local localMission = {}
        C_Garrison.GetInProgressMissions(localMission, type)
        for i = 1, #localMission do
            garrisonMission[#garrisonMission + 1] = localMission[i]
        end
    end

    return garrisonMission
end

function Garrison:GetCompleteMissions()
    local garrisonMission = {}

    local types = {
        LE_FOLLOWER_TYPE_GARRISON_7_0,
        LE_FOLLOWER_TYPE_GARRISON_6_0,
        LE_FOLLOWER_TYPE_SHIPYARD_6_2
    }

    for key, type in pairs(types) do
        local localMission = {}
        C_Garrison.GetCompleteMissions(garrisonMission, type)
        for i = 1, #localMission do
            garrisonMission[#garrisonMission + 1] = localMission[i]
        end
    end

    return garrisonMission
end

function Garrison:GARRISON_MISSION_STARTED(event, missionID, start)

    local startTime = time()

    if start ~= nil then
        startTime = start
    end

    for key, garrisonMission in pairs(Garrison:GetInProgressMissions()) do
        if (garrisonMission.missionID == missionID) then
            local mission = {
                id = garrisonMission.missionID,
                name = garrisonMission.name,
                start = startTime,
                duration = garrisonMission.durationSeconds,
                notification = 0,
                timeLeft = garrisonMission.timeLeft,
                type = garrisonMission.type,
                typeAtlas = garrisonMission.typeAtlas,
                level = garrisonMission.level,
                followers = {},
                rewards = garrisonMission.rewards,
                followerTypeID = garrisonMission.followerTypeID
            }

            debugPrint("Added Mission: " .. missionID)

            -- get followers
            --local followers = {}

            for i = 1, #garrisonMission.followers do
                local followerId = garrisonMission.followers[i]

                local tmpAbilites = C_Garrison.GetFollowerAbilities(followerId)
                local tmpFollower = C_Garrison.GetFollowerInfo(followerId)

                local name, portraitIconID, classIcon = tmpFollower.name, tmpFollower.portraitIconID, tmpFollower.classAtlas

                mission.followers[i] = {
                    id = followerId,
                    name = tmpFollower.name,
                    iconId = tmpFollower.portraitIconID,
                    classIcon = tmpFollower.classAtlas,
                    abilities = {},
                }

                for abilityNum, tmpAbility in pairs(tmpAbilites) do
                    local abilityId, abilityName, abilityIcon = tmpAbility.id, tmpAbility.name, tmpAbility.icon
                    mission.followers[i].abilities[abilityNum] = {
                        id = tmpAbility.id,
                        name = tmpAbility.name,
                        icon = tmpAbility.icon,
                    }

                    local missionModifier = Garrison.missionModifier[tmpAbility.id]
                    if start == nil and missionModifier then
                        -- modified mission time
                        if not mission.durationOriginal then
                            mission.durationOriginal = mission.duration
                        end
                        mission.duration = math.floor((mission.duration * Garrison.missionModifier[tmpAbility.id] + 0.5))
                        debugPrint(("Mission modifier detected (%s): %s - duration: %s (old: %s)"):format(tmpAbility.name, tostring(missionModifier), tostring(mission.duration), tostring(mission.durationOriginal)))
                    end
                end
            end

            globalDb.data[charInfo.realmName][charInfo.playerName].missions[missionID] = mission
        end
    end

    Garrison:Update()
end

function Garrison:GARRISON_MISSION_FINISHED(event, followerTypeID, missionID)
    if (globalDb.data[charInfo.realmName][charInfo.playerName].missions[missionID]) then
        debugPrint("Finished Mission: " .. missionID)
        if globalDb.data[charInfo.realmName][charInfo.playerName].missions[missionID].start ~= -1 then
            globalDb.data[charInfo.realmName][charInfo.playerName].missions[missionID].start = 0
        end
    else
        debugPrint("Unknown Mission: " .. missionID)
    end

    Garrison:Update()
end

function Garrison:GARRISON_SHOW_LANDING_PAGE(...)
    Garrison:UpdateConfig()

    Garrison:UpdateUnknownMissions(true)
end

function Garrison:GARRISON_MISSION_NPC_OPENED(...)
    Garrison:UpdateConfig()

    Garrison:UpdateUnknownMissions(true)
end

function Garrison:IsNearCache()
    _G.SetMapToCurrentZone()
    local posX, posY = _G.GetPlayerMapPosition("player");
    local instanceMapID = _G.select(8, _G.GetInstanceInfo())

    if Garrison.instanceId[instanceMapID] then
        local garrisonInfo = Garrison.instanceId[instanceMapID]
        local distX = math.abs(garrisonInfo.x - posX)
        local distY = math.abs(garrisonInfo.y - posY)

        local nearCache = (distX < 0.015 and distY < 0.015)

        debugPrint(("X %s Y %s => %s"):format(tostring(distX), tostring(distY), tostring(nearCache)))

        return true
    end

    return false
end

function Garrison:IsInGarrison()
    local mapName = _G.GetRealZoneText()

    if (mapName and Garrison.location.garrisonMapName and mapName == Garrison.location.garrisonMapName) then
        return true
    end

    local instanceMapID = _G.select(8, _G.GetInstanceInfo())

    if Garrison.instanceId[instanceMapID] then
        return true
    end

    return false
end

function Garrison:DisableInInstance()
    local inInstance, instanceType = _G.IsInInstance()

    if inInstance then
        if configDb.notification.general.disableInParty and
                (instanceType == 'scenario'
                        or instanceType == 'party') then
            debugPrint(("InInstance (%s) - No Notifications"):format(instanceType))
            return true
        end

        if configDb.notification.general.disableInRaid and
                (instanceType == 'raid') then
            debugPrint(("InInstance (%s) - No Notifications"):format(instanceType))
            return true
        end

        if configDb.notification.general.disableInPvP and
                (instanceType == 'scenario'
                        or instanceType == 'party') then
            debugPrint(("InInstance (%s) - No Notifications"):format(instanceType))
            return true
        end
    end

    return false
end

function Garrison:UpdateLocation()
    --Garrison.location.mapName = _G.GetRealZoneText()
    --Garrison.location.inGarrison = Garrison:IsInGarrison()
    debugPrint(("ZoneUpdate: %s (%s)"):format(Garrison.location.mapName or "-", _G.tostring(Garrison.location.inGarrison)))

    Garrison.location.inGarrison = C_Garrison.IsPlayerInGarrison(LE_GARRISON_TYPE_6_0);
    Garrison.location.inOrderHall = C_Garrison.IsPlayerInGarrison(LE_GARRISON_TYPE_7_0);
end

function Garrison:ZoneUpdate(...)
    Garrison:UpdateLocation()
end

function Garrison:GetShipmentData(buildingID)
    local name, texture, shipmentCapacity, shipmentsReady, shipmentsTotal, creationTime, duration, timeleftString, itemName, itemIcon, itemQuality, itemID = C_Garrison.GetLandingPageShipmentInfo(buildingID)

    local tmpShipment = {
        name = name,
        texture = texture,
        shipmentCapacity = shipmentCapacity,
        shipmentsReady = shipmentsReady,
        shipmentsTotal = shipmentsTotal,
        creationTime = creationTime,
        duration = duration,
        timeleftString = timeleftString,
        itemName = itemName,
        itemQuality = itemQuality,
        itemID = itemID
    }

    return tmpShipment
end

function Garrison:UpdatePlotSize()
    local plots = C_Garrison.GetPlots(LE_FOLLOWER_TYPE_GARRISON_6_0)

    if plots and #plots > 0 then
        for plotID, buildingData in pairs(globalDb.data[charInfo.realmName][charInfo.playerName].buildings) do

            for k, v in pairs(plots) do
                if v.id == plotID then
                    buildingData.plotSize = v.size
                    debugPrint(("[%s] found size %s"):format(buildingData.name, _G.tostring(v.size)))
                    break
                end
            end
        end
    end
end

function Garrison:GetBuildingData(plotID)    
    local id, name, texPrefix, icon, rank, isBuilding, timeStart, buildTime, canActivate, canUpgrade, isPrebuilt = C_Garrison.GetOwnedBuildingInfoAbbrev(plotID)

    local hasFollowerSlot = _G.select(17, C_Garrison.GetOwnedBuildingInfo(plotID))

    --local plots = C_Garrison.GetPlots()

    local tmpBuilding = {
        plotID = plotID,
        id = id,
        name = name,
        texPrefix = texPrefix,
        icon = icon,
        rank = rank,
        isBuilding = isBuilding,
        canActivate = canActivate,
        timeStart = timeStart,
        buildTime = buildTime,
        hasFollowerSlot = hasFollowerSlot,
    }

    return tmpBuilding
end

function Garrison:GetFollowerData(plotID)
    local followerName, level, quality, displayID, followerID, garrFollowerID, status, portraitIconID = C_Garrison.GetFollowerInfoForBuilding(plotID);

    local tmpFollower = {}

    if followerName then
        tmpFollower = {
            followerName = followerName,
            level = level,
            quality = quality,
            displayID = displayID,
            followerID = followerID,
            garrFollowerID = garrFollowerID,
            status = status,
            portraitIconID = portraitIconID,
        }

        debugPrint(("(%s): Added Follower (%s)"):format(plotID, followerName))
    end

    return tmpFollower
end

function Garrison:UpdateBuildingShipment(buildingID, shipmentData)
    Garrison.shipmentUpdate.success = false

    local tmpShipment = {}
    if buildingID then
        tmpShipment = Garrison:GetShipmentData(buildingID)

        if shipmentData then
            if shipmentData.shipmentsTotal and shipmentData.shipmentsTotal > 0 then

                tmpShipment.notificationValue = shipmentData.notificationValue or 0
                tmpShipment.notificationDismissed = shipmentData.notificationDismissed or false
                tmpShipment.notification = shipmentData.notification

                -- remember total shipments
                if tmpShipment.shipmentsTotal == nil then
                    tmpShipment.shipmentsTotal = shipmentData.shipmentsTotal
                end

                if tmpShipment.name and tmpShipment.notificationValue then
                    debugPrint(("Update Shipment (%s, %s) - NotificationValue=%s, ShipmentsTotal=%s (%s)"):format(tmpShipment.name, tostring(buildingID), tmpShipment.notificationValue, tostring(tmpShipment.shipmentsTotal), tostring(shipmentData.shipmentsTotal)))
                end
            end
        end
    end

    return tmpShipment
end

function Garrison:UpdateBuilding(plotID)

    local tmpBuilding = Garrison:GetBuildingData(plotID)

    local buildingData = globalDb.data[charInfo.realmName][charInfo.playerName].buildings[plotID]

    local shipmentData = nil

    if buildingData then
        tmpBuilding.notificationDismissed = buildingData.notificationDismissed
        tmpBuilding.notification = buildingData.notification

        if buildingData.plotSize then
            tmpBuilding.plotSize = buildingData.plotSize
        end

        shipmentData = buildingData.shipment
    end

    tmpBuilding.shipment = Garrison:UpdateBuildingShipment(tmpBuilding.id, shipmentData)

    if tmpBuilding.hasFollowerSlot then
        tmpBuilding.follower = Garrison:GetFollowerData(plotID)
    end

    return tmpBuilding
end

function Garrison:UpdateTalent(talentData)
    -- Filter?
    local tmpTalent
    --if talentData and not(
    --	talentData.talentAvailability == LE_GARRISON_TALENT_AVAILABILITY_UNAVAILABLE_TIER_UNAVAILABLE
    --	or talentData.talentAvailability == LE_GARRISON_TALENT_AVAILABILITY_UNAVAILABLE_PLAYER_CONDITION
    --) then
    tmpTalent = talentData
    --end

    return tmpTalent
end

function Garrison:UpdateCategory(categoryData)
    -- Filter?
    local tmpCategory = categoryData

    return tmpCategory
end


function Garrison:FullUpdateCategories()
    local tmpCategories = {}
    local categories = C_Garrison.GetClassSpecCategoryInfo(LE_FOLLOWER_TYPE_GARRISON_7_0)

    for i = 1, #categories do
        local category = categories[i]

        debugPrint(category)

        local tmpCategory = Garrison:UpdateCategory(category)

        local categoryId = tmpCategory.id

        debugPrint(("UpdateCategory: %s / %s"):format(i or "-1", tmpCategory.name))

        tmpCategories[i] = tmpCategory
    end

    globalDb.data[charInfo.realmName][charInfo.playerName].categories = tmpCategories
end

function Garrison:FullUpdateTalents()
    local tmpTalents = {}
    local talentArr = C_Garrison.GetTalentTrees(LE_GARRISON_TYPE_7_0, select(3, UnitClass("player")))

    if talentArr ~= nil then
        local talents = talentArr[1];

        for i = 1, #talents do
            local talent = talents[i]
            local tmpTalent = Garrison:UpdateTalent(talent)

            if tmpTalent ~= nil then
                local talentId = tmpTalent.id
                debugPrint(("UpdateTalent: %s / %s"):format(talentId or "-1", talent.name))
                tmpTalents[talentId] = tmpTalent
            end
        end

        globalDb.data[charInfo.realmName][charInfo.playerName].talents = tmpTalents
    end
end

function Garrison:UpdateShipment(containerId)
    local name, texture, shipmentCapacity, shipmentsReady, shipmentsTotal, creationTime, duration, timeleftString, _, _, _, _, followerID = C_Garrison.GetLandingPageShipmentInfoByContainerID(containerId);

    local tmpShipment

    if (name and shipmentCapacity > 0) then
        tmpShipment = {
            name = name,
            texture = texture,
            shipmentCapacity = shipmentCapacity,
            shipmentsReady = shipmentsReady,
            shipmentsTotal = shipmentsTotal,
            creationTime = creationTime,
            duration = duration,
            timeleftString = timeleftString,
            followerID = followerID
        }
    end

    return tmpShipment
end

function Garrison:FullUpdateShipments()

    local SHIPMENT_TYPE_BUILDING = 1;
    local SHIPMENT_TYPE_FOLLOWER = 2;
    local SHIPMENT_TYPE_TALENT = 3;
    local SHIPMENT_TYPE_LOOSE = 4;

    local maxShipments = 10
    local shipmentIndex = 0

    local tmpShipments = {}

    local followerShipments = C_Garrison.GetFollowerShipments(LE_GARRISON_TYPE_7_0);
    for i = 1, #followerShipments do
        local name, texture, shipmentCapacity, shipmentsReady, shipmentsTotal, creationTime, duration, timeleftString, _, _, _, _, followerID = C_Garrison.GetLandingPageShipmentInfoByContainerID(followerShipments[i]);
        if (name and shipmentCapacity > 0 and shipmentIndex < maxShipments) then
            shipmentIndex = shipmentIndex + 1;

            local tmpShipment = Garrison:UpdateShipment(followerShipments[i])

            if tmpShipment ~= nil then
                tmpShipments[i] = Garrison:UpdateShipment(followerShipments[i])
            end
        end
    end

    globalDb.data[charInfo.realmName][charInfo.playerName].followerShipments = tmpShipments

    tmpShipments = {}
    shipmentIndex = 0

    local looseShipments = C_Garrison.GetLooseShipments(LE_GARRISON_TYPE_7_0);
    for i = 1, #looseShipments do
        local name, texture, shipmentCapacity, shipmentsReady, shipmentsTotal, creationTime, duration, timeleftString = C_Garrison.GetLandingPageShipmentInfoByContainerID(looseShipments[i]);
        if (name and shipmentCapacity > 0 and shipmentIndex < maxShipments) then
            shipmentIndex = shipmentIndex + 1;

            local tmpShipment = Garrison:UpdateShipment(looseShipments[i])

            if tmpShipment ~= nil then
                tmpShipments[i] = Garrison:UpdateShipment(looseShipments[i])
            end
        end
    end

    globalDb.data[charInfo.realmName][charInfo.playerName].looseShipments = tmpShipments
end

function Garrison:FullUpdateBuilding(updateType)

    C_Garrison.RequestLandingPageShipmentInfo()

    local buildings = C_Garrison.GetBuildings(LE_GARRISON_TYPE_6_0)
    local tmpBuildings = {}

    if #buildings == 0 then
        return false
    end

    debugPrint(("FullUpdate (%s): %s"):format(updateType, #buildings))

    for i = 1, #buildings do
        local buildingID = buildings[i].buildingID
        local plotID = buildings[i].plotID

        if updateType == Garrison.TYPE_BUILDING then
            debugPrint(("FullUpdate: %s / %s"):format(plotID or "0", buildingID or "0"))
            tmpBuildings[plotID] = Garrison:UpdateBuilding(plotID)
        end
        if updateType == Garrison.TYPE_SHIPMENT then
            local buildingData = globalDb.data[charInfo.realmName][charInfo.playerName].buildings[plotID]

            if not buildingData then
                debugPrint("UpdateShipment: Unknown Building: " .. buildingID)
            else
                --debugPrint(("#1UpdateShipment (%s) NotificationValue: %s (Total: %s)"):format(tostring(buildingData.shipment.name), tostring(buildingData.shipment.notificationValue), tostring(buildingData.shipment.shipmentsTotal)))

                local tmpShipment = Garrison:UpdateBuildingShipment(buildingID, buildingData.shipment)

                --debugPrint(("#2UpdateShipment (%s) NotificationValue: %s (Total: %s)"):format(tostring(tmpShipment.name), tostring(tmpShipment.notificationValue), tostring(tmpShipment.shipmentsTotal)))

                globalDb.data[charInfo.realmName][charInfo.playerName].buildings[plotID].shipment = tmpShipment
            end
        end
    end

    if updateType == Garrison.TYPE_BUILDING then
        globalDb.data[charInfo.realmName][charInfo.playerName].buildings = tmpBuildings

        Garrison:UpdatePlotSize()
    end

    return true
end

function Garrison:GetPlotID(buildingID)
    if globalDb.data[charInfo.realmName][charInfo.playerName].buildings then
        for buildingPlotID, buildingData in pairs(globalDb.data[charInfo.realmName][charInfo.playerName].buildings) do
            if buildingData and buildingData.id and buildingData.id == buildingID then
                return buildingPlotID
            end
        end
    end

    return nil
end

function Garrison:BuildingUpdate(event, ...)
    if event == "GARRISON_BUILDING_PLACED" then
        local plotID, newPlacement = ...;

        local tmpBuilding = Garrison:GetBuildingData(plotID)
        if newPlacement then
            debugPrint(("New Building (%s): %s (%s)"):format(tmpBuilding.name, tmpBuilding.rank, tmpBuilding.id))
            globalDb.data[charInfo.realmName][charInfo.playerName].buildings[plotID] = tmpBuilding
        else
            if globalDb.data[charInfo.realmName][charInfo.playerName].buildings and globalDb.data[charInfo.realmName][charInfo.playerName].buildings[plotID] then
                local currentBuilding = globalDb.data[charInfo.realmName][charInfo.playerName].buildings[plotID]
                -- Already exists, check for update

                if currentBuilding.id == tmpBuilding.id then
                    -- Ignore
                else
                    -- Upgrade
                    debugPrint(("BuildingUpgrade (%s): %s (%s) -> %s (%s)"):format(tmpBuilding.name, currentBuilding.rank, currentBuilding.id, tmpBuilding.rank, tmpBuilding.id))

                    globalDb.data[charInfo.realmName][charInfo.playerName].buildings[plotID] = tmpBuilding
                end
            end
        end
    elseif event == "GARRISON_BUILDING_REMOVED" then
        local plotID, buildingID = ...;
        debugPrint(("Removed Building %s"):format(buildingID))
        globalDb.data[charInfo.realmName][charInfo.playerName].buildings[plotID] = nil
    elseif event == "GARRISON_BUILDING_ACTIVATED" then
        local plotID = ...;
        local tmpBuilding = Garrison:UpdateBuilding(plotID)

        --debugPrint(("BuildingEvent: %s (%s): %s / %s"):format(event, plotID, tostring(tmpBuilding), tostring(tmpBuilding.name)))

        if tmpBuilding and tmpBuilding.name then
            debugPrint(("GARRISON_BUILDING_ACTIVATED %s (%s)"):format(plotID, tmpBuilding.name or '-'))

            globalDb.data[charInfo.realmName][charInfo.playerName].buildings[plotID] = tmpBuilding
        end
    elseif event == "GARRISON_BUILDING_UPDATE" then
        local buildingID = ...;

        -- BuildingID => PlotID
        local plotID = Garrison:GetPlotID(buildingID)

        if plotID then
            local tmpBuilding = Garrison:UpdateBuilding(plotID)
            if tmpBuilding and tmpBuilding.name then
                debugPrint(("GARRISON_BUILDING_UPDATE %s (%s)"):format(plotID, tmpBuilding.name or '-'))

                globalDb.data[charInfo.realmName][charInfo.playerName].buildings[plotID] = tmpBuilding
            end
        end

    else
        debugPrint(("BuildingUpdate (%s)"):format(_G.tostring(event)))
        Garrison:FullUpdateBuilding(Garrison.TYPE_BUILDING)
    end

    Garrison:UpdatePlotSize()
end


function Garrison:VignetteEvent(event, ...)
    if Garrison.location.inGarrison then
        if event == "VIGNETTE_ADDED" then
            local vignetteInstanceId, arg2 = ...
            local ofsX, ofsY, name, objectIcon = C_Vignettes.GetVignetteInfoFromInstanceID(vignetteInstanceId)
            debugPrint(("VignetteAdded: %s %s %s %s %s"):format(vignetteInstanceId, tostring(ofsX), tostring(ofsX), name, objectIcon))
        end
        if event == "VIGNETTE_REMOVED" then
            local arg = ...
            debugPrint(("VignetteRemoved: %s"):format(arg))
        end
    end
end

function Garrison:LootToastEvent(event, ...)
    --local typeIdentifier, itemLink, quantity = ...
    local typeIdentifier, itemLink, quantity, specID, sex, isPersonal, lootSource = ...;

    if lootSource == Garrison.LOOT_SOURCE_GARRISON_CACHE then --
    --if Garrison:IsNearCache() then
    debugPrint(("Looted %s (amount: %s) of %s"):format(tostring(typeIdentifier), tostring(quantity), tostring(itemLink)))
    --if typeIdentifier == "currency" and itemLink then
    --	local currencyType = string.match(itemLink, "currency:([%-?%d:]+)")

    --	if currencyType ~= nil and currencyType == tostring(Garrison.GARRISON_CURRENCY) then
    globalDb.data[charInfo.realmName][charInfo.playerName].garrisonCacheLastLooted = time()

    --	end
    --end
    end
end

function Garrison:SetCacheSize(size)
    local currentSize = globalDb.data[charInfo.realmName][charInfo.playerName].cacheSize
    if (currentSize ~= nil and size ~= nil and currentSize < size) then
        globalDb.data[charInfo.realmName][charInfo.playerName].cacheSize = size
    end
end

function Garrison:CheckInvasionAvailable()
    if not globalDb.data[charInfo.realmName][charInfo.playerName].invasion then
        globalDb.data[charInfo.realmName][charInfo.playerName].invasion = { available = false }
    end

    globalDb.data[charInfo.realmName][charInfo.playerName].invasion.available = C_Garrison.IsInvasionAvailable() and not _G.IsQuestFlaggedCompleted(37640) -- Available and not completed gold invasion quest
end

function Garrison:CheckNumBonusRollQuests()
    local count = 0

    for _, value in ipairs(Garrison.bonusRollItemQuestId) do
        if (_G.IsQuestFlaggedCompleted(value)) then
            count = count + 1
        end
    end

    if not globalDb.data[charInfo.realmName][charInfo.playerName].trackWeekly then
        globalDb.data[charInfo.realmName][charInfo.playerName].trackWeekly = {}
    end
    globalDb.data[charInfo.realmName][charInfo.playerName].trackWeekly["BONUS_ROLL_QUESTS"] = count

    return count;
end



function Garrison:CheckBuildingInfo()
    if Garrison.buildingInfo then
        for buildingName, buildingInfo in pairs(Garrison.buildingInfo) do

            for indicatorIndex, indicatorData in pairs(buildingInfo.indicator) do

                if indicatorData.trackCustomId and indicatorData.trackCustom ~= nil then
                    local result = indicatorData.trackCustom()
                    debugPrint(("BuildingInfo (%s): %s"):format(buildingName, tostring(result)))

                    if indicatorData.weekly then
                        if not globalDb.data[charInfo.realmName][charInfo.playerName].trackWeekly then
                            globalDb.data[charInfo.realmName][charInfo.playerName].trackWeekly = {}
                        end
                        globalDb.data[charInfo.realmName][charInfo.playerName].trackWeekly[indicatorData.trackCustomId] = result
                    elseif indicatorData.daily then
                        if not globalDb.data[charInfo.realmName][charInfo.playerName].trackDaily then
                            globalDb.data[charInfo.realmName][charInfo.playerName].trackDaily = {}
                        end
                        globalDb.data[charInfo.realmName][charInfo.playerName].trackDaily[indicatorData.trackCustomId] = result
                    end
                end
            end
        end
    end
end

function Garrison:QuestHandling()
    for _, realmData in pairs(globalDb.data) do
        for playerName, playerData in pairs(realmData) do

            local lootedNextReset = playerData.lootedNextReset
            local weeklyNextReset = playerData.weeklyNextReset

            local now = _G.time()
            --debugPrint(playerName)
            --debugPrint(lootedNextReset)

            if not lootedNextReset or now >= lootedNextReset then
                playerData.lootedNextReset = Garrison.GetNextDailyResetTime()
                playerData.lootedToday = {}
                playerData.trackDaily = {}
            end

            if not weeklyNextReset or now >= weeklyNextReset then
                playerData.weeklyNextReset = Garrison.GetNextWeeklyResetTime()
                playerData.trackWeekly = {}
                playerData.invasion = {}
            end
        end
    end
end

function Garrison:GetParsedStartTime(missionTime, duration)
    local missionTime = Garrison:ParseMissionTime(missionTime)

    return _G.time() - (duration - missionTime)
end

function Garrison:ParseMissionTime(missionTime)
    for _, durationData in pairs(Garrison.DURATION_PATTERN) do

        if not durationData.pattern then
            durationData.pattern, durationData.captureIndices = Garrison.patternFromFormat(durationData.format)
            debugPrint(("Pattern compile (%s): %s"):format(durationData.format, durationData.pattern))
        end

        local result1, result2 = nil, nil

        local retVal = 0

        local result0, result1, result2, result3 = Garrison.superFind(missionTime, durationData.pattern, durationData.captureIndices)

        debugPrint(("%s (%s): %s, %s, %s, %s"):format(missionTime, durationData.pattern, tostring(result0), tostring(result1), tostring(result2), tostring(result3)))

        if result2 ~= nil and durationData.factor[0] then

            retVal = retVal + (result2 * durationData.factor[0])
            debugPrint(("Calc1: %s * %s = %s"):format(result2, durationData.factor[0], (result2 * durationData.factor[0])))
        end

        if result3 ~= nil and durationData.factor[1] then
            retVal = retVal + (result3 * durationData.factor[1])
            debugPrint(("Calc2: %s * %s = %s"):format(result3, durationData.factor[1], (result3 * durationData.factor[1])))
        end

        if retVal ~= 0 then
            return retVal
        end
    end

    return 0
end

function Garrison:ChatLootEvent(event, ...)
    local message = ...

    if Garrison:IsInGarrison() then

        debugPrint("Loot: IsInGarrison")

        for _, lootData in pairs(Garrison.LOOT_PATTERN) do

            if not lootData.pattern then
                lootData.pattern, lootData.captureIndices = Garrison.patternFromFormat(lootData.format)
                debugPrint(("Pattern compile (%s): %s"):format(lootData.format, lootData.pattern))
            end

            local _, _, lootedItemLink, lootedAmount = Garrison.superFind(message, lootData.pattern, lootData.captureIndices)

            if lootedItemLink ~= nil then
                local itemId = Garrison.itemIdFromLink(lootedItemLink)

                if lootedAmount == nil then
                    lootedAmount = 1
                end

                if itemId then
                    if not globalDb.data[charInfo.realmName][charInfo.playerName].lootedToday then
                        globalDb.data[charInfo.realmName][charInfo.playerName].lootedToday = {}
                    end

                    for _, trackedItem in pairs(Garrison.GARRISON_TRACK_LOOT_ITEM) do
                        if trackedItem.itemId == itemId then
                            globalDb.data[charInfo.realmName][charInfo.playerName].lootedToday[itemId] = (globalDb.data[charInfo.realmName][charInfo.playerName].lootedToday[itemId] or 0) + lootedAmount
                            debugPrint(("Looted [%s] (%s) - Total Today: %s"):format(trackedItem.name, lootedAmount, globalDb.data[charInfo.realmName][charInfo.playerName].lootedToday[itemId]))
                        end
                    end
                end

                break
            end
        end
    end
end


function Garrison:GetLootInfoForPlayer(playerData)

    local retValue = ""

    for buildingName, buildingData in pairs(playerData.buildings) do
        retValue = retValue .. Garrison:GetLootInfoForBuilding(playerData, buildingData, true)
    end

    return retValue
end

function Garrison:GetLootInfoForBuilding(playerData, buildingData, collapsedView)
    local retValue = ""

    for buildingName, buildingInfo in pairs(Garrison.buildingInfo) do
        if buildingInfo.level then
            local buildingLevel = buildingInfo.level[buildingData.id]

            if not playerData.trackWeekly then
                playerData.trackWeekly = {}
            end
            if not playerData.trackDaily then
                playerData.trackDaily = {}
            end

            for indicatorIndex, indicatorData in pairs(buildingInfo.indicator) do

                if not collapsedView or indicatorData.showCollapsed then

                    if buildingLevel and indicatorData.trackLootItemId ~= nil and playerData.lootedToday then
                        local lootedToday = playerData.lootedToday[indicatorData.trackLootItemId] or 0
                        if indicatorData.minLooted and lootedToday > indicatorData.minLooted then
                            retValue = retValue .. " " .. Garrison.ICON_CHECK
                        else
                            retValue = retValue .. " " .. Garrison.ICON_CHECK_WAITING
                        end
                    end

                    if buildingLevel and indicatorData.trackCustomId ~= nil and playerData.trackWeekly and playerData.trackDaily then
                        if indicatorData.minLevel and ((buildingLevel > indicatorData.minLevel)
                                or (not (buildingData.isBuilding or buildingData.canActivate) and buildingLevel == indicatorData.minLevel))
                        then
                            local complete
                            if indicatorData.weekly then
                                complete = playerData.trackWeekly[indicatorData.trackCustomId]
                            elseif indicatorData.daily then
                                complete = playerData.trackDaily[indicatorData.trackCustomId]
                            end

                            if complete then
                                retValue = retValue .. " " .. (indicatorData.customIcon and indicatorData.icon.T or Garrison.ICON_CHECK)
                            else
                                retValue = retValue .. " " .. (indicatorData.customIcon and indicatorData.icon.F or Garrison.ICON_CHECK_WAITING)
                            end
                        end
                    end
                end
            end
        end
    end

    return retValue
end

function Garrison:ShipmentStatusUpdate(event, shipmentStarted)
    if shipmentStarted then
        debugPrint("ShipmentStatusUpdate")
        C_Garrison.RequestLandingPageShipmentInfo()

        Garrison.shipmentUpdate.success = true

        --timers.shipment_update = Garrison:ScheduleTimer("UpdateShipmentInfo", 20)
    end
end

function Garrison:GARRISON_TALENT_COMPLETE(...)
    debugPrint(...)
    C_Garrison.RequestClassSpecCategoryInfo(LE_FOLLOWER_TYPE_GARRISON_7_0);
    Garrison:UpdateTalents()
end

function Garrison:GARRISON_TALENT_UPDATE(...)
    debugPrint(...)
    C_Garrison.RequestClassSpecCategoryInfo(LE_FOLLOWER_TYPE_GARRISON_7_0);
    Garrison:UpdateTalents()
end

function Garrison:GARRISON_FOLLOWER_CATEGORIES_UPDATED(...)
    debugPrint(...)
    Garrison:UpdateCategories()
end

function Garrison:GARRISON_FOLLOWER_ADDED(...)
    debugPrint(...)
    Garrison:UpdateCategories()
end

function Garrison:GARRISON_FOLLOWER_REMOVED(...)
    debugPrint(...)
    Garrison:UpdateCategories()
end

function Garrison:UpdateTalents()
    --debugPrint(Garrison:GetTalentData())
end

function Garrison:UpdateCategories()
    Garrison:FullUpdateCategories()
end

function Garrison:UpdateCurrency()
    local _, amount, _ = GetCurrencyInfo(Garrison.GARRISON_CURRENCY)
    local _, amountApexis, _ = GetCurrencyInfo(Garrison.GARRISON_CURRENCY_APEXIS)
    local _, amountSealOfTemperedFate, _ = GetCurrencyInfo(Garrison.GARRISON_CURRENTY_SEAL_OF_TEMPERED_FATE)
    local _, amountOil, _ = GetCurrencyInfo(Garrison.GARRISON_CURRENTY_OIL)
    local _, amountSealOfInevitableFate, _ = GetCurrencyInfo(Garrison.GARRISON_CURRENTY_SEAL_OF_INEVITABLE_FATE)
  

    local _, amountOrderResources, _ = GetCurrencyInfo(Garrison.GARRISON_CURRENCY_ORDER_RESOURCES);
    local _, amountAncientMana, _ = GetCurrencyInfo(Garrison.GARRISON_CURRENCY_ANCIENT_MANA);

    globalDb.data[charInfo.realmName][charInfo.playerName].currencyAmount = amount
    globalDb.data[charInfo.realmName][charInfo.playerName].currencyApexisAmount = amountApexis
    globalDb.data[charInfo.realmName][charInfo.playerName].currencySealOfTemperedFateAmount = amountSealOfTemperedFate
    globalDb.data[charInfo.realmName][charInfo.playerName].currencySealOfInevitableFateAmount = amountSealOfInevitableFate
    globalDb.data[charInfo.realmName][charInfo.playerName].currencyOil = amountOil

    -- 7.0
    globalDb.data[charInfo.realmName][charInfo.playerName].currencyOrderResourcesAmount = amountOrderResources
    globalDb.data[charInfo.realmName][charInfo.playerName].currencyAncientManaAmount = amountAncientMana

    Garrison:Update()

    Garrison:CheckNumBonusRollQuests()
end

function Garrison:QuickUpdate()
    if configDb.general.updateInCombat or not InCombatLockdown() then
        Garrison:QuestHandling()

        if not configDb.general.highAccuracy then
            if configDb.general.showSeconds then
                Garrison:UpdateLDB()
            end
        end

        if Garrison.location.inGarrison then
            -- in garrison - full update (quick)
            Garrison:Update()
        end
    end
end

function Garrison:LDBUpdate()
    if configDb.general.updateInCombat or not InCombatLockdown() then

        Garrison:HandleNotificationQueue()

        if configDb.general.highAccuracy then
            Garrison:UpdateLDB()
        end
    end
end

function Garrison:SlowUpdate()
    if configDb.general.updateInCombat or not InCombatLockdown() then

        if not configDb.general.highAccuracy then
            if not configDb.general.showSeconds then
                Garrison:UpdateLDB()
            end
        end

        Garrison:CheckInvasionAvailable()
        Garrison:CheckBuildingInfo()
        Garrison:CheckNumBonusRollQuests()

        if not Garrison.location.inGarrison then
            -- not in garrison - full update (slow)
            Garrison:Update()
        end
    end
end

function Garrison:CheckAddonLoaded(event, addon)
    if addon == "Blizzard_GarrisonUI" then
        -- Addon Loaded: Garrison UI - Hook AlertFrame
        debugPrint("Event: Blizzard_GarrisonUI loaded")
        Garrison:OnDependencyLoaded()
        self:UnregisterEvent("ADDON_LOADED")
    end
end

function Garrison:MissionAlert(missionID)
    if configDb.notification.mission.hideBlizzardNotification then
        debugPrint("Blizzard notification hidden: " .. missionID)
    else
        debugPrint("Show blizzard notification" .. missionID)
        self.hooks.AddAlert(missionID)
    end
end

function Garrison:BuildingAlert(...)
    if configDb.notification.building.hideBlizzardNotification then
        debugPrint("Blizzard notification hidden: ")
    else
        debugPrint("Show blizzard notification")
        self.hooks.AddAlert(...)
    end
end

function Garrison:GarrisonMinimapBuilding_ShowPulse()
    if configDb.notification.building.hideMinimapPulse then
        debugPrint("Hide Pulse (Building)")
    else
        debugPrint("Play Pulse (Building)")
        self.hooks.GarrisonMinimapBuilding_ShowPulse(_G.GarrisonLandingPageMinimapButton)
    end
end

function Garrison:GarrisonMinimapShipmentCreated_ShowPulse()
    if configDb.notification.shipment.hideMinimapPulse then
        debugPrint("Hide Pulse (Shipment)")
    else
        debugPrint("Play Pulse (Shipment)")
        self.hooks.GarrisonMinimapShipmentCreated_ShowPulse(_G.GarrisonLandingPageMinimapButton)
    end
end

function Garrison:GarrisonMinimapMission_ShowPulse(_, missionID)
    if configDb.notification.mission.hideMinimapPulse then
        debugPrint("Hide Pulse (Mission)")
    else
        debugPrint("Play Pulse (Mission)")
        self.hooks.GarrisonMinimapMission_ShowPulse(_G.GarrisonLandingPageMinimapButton, missionID)
    end
end

function Garrison:RecruitFollower(...)
    local tmp = ...
    debugPrint("RecruitFollower" .. tostring(tmp))

    globalDb.data[charInfo.realmName][charInfo.playerName].trackWeekly["INN_FOLLOWER"] = true
end

--function Garrison:GarrisonCapacitiveDisplayFrame_Update()
function Garrison:GarrisonCapacitiveDisplayFrame_Update(obj, success, maxShipments, plotID)
    if success then
        --debugPrint(("Update: %s - %s - %s"):format(tostring(success), maxShipments, plotID))
        Garrison.shipmentUpdate.plotID = plotID
        --Garrison.shipmentUpdate.numPending = C_Garrison.GetNumPendingShipments()

        --debugPrint(("numPending: %s"):format(Garrison.shipmentUpdate.numPending or "0"))
    end

    local numPending = C_Garrison.GetNumPendingShipments() or 0 -- TODO: Test and implement failsafe (~30second timeout) to prevent deadlock

    if Garrison.shipmentUpdate.success then
        debugPrint(("numPending: %s"):format(numPending or "0"))
        Garrison:FullUpdateShipments();

        local buildingData = globalDb.data[charInfo.realmName][charInfo.playerName].buildings[Garrison.shipmentUpdate.plotID]

        if buildingData and buildingData.shipment then
            if numPending ~= nil and buildingData.shipment.shipmentsTotal ~= nil then
                if numPending >= buildingData.shipment.shipmentsTotal then
                    debugPrint(("Update Shipment (%s): %s"):format(buildingData.name, numPending))
                    buildingData.shipment.shipmentsTotal = numPending

                    Garrison.shipmentUpdate.success = false
                end
            else
                Garrison.shipmentUpdate.success = false
            end
        else
            -- Data inconsistency - schedule full building update
            Garrison.shipmentUpdate.success = false

            timers.full_update = Garrison:ScheduleTimer("FullUpdateBuilding", 5, Garrison.TYPE_BUILDING)
        end
    end
end


function Garrison:InitEvent()
    garrisonDb = self.DB
    configDb = garrisonDb.profile
    globalDb = garrisonDb.global
end

