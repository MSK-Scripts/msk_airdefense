ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)
        
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

CreateThread(function()
    for k, v in pairs(Config.Zones) do
        if not v.Blip.enable then return end

        local blip = AddBlipForRadius(v.pos, v.radius)
        SetBlipColour(blip, v.Blip.color)
        SetBlipAlpha(blip, v.Blip.alpha)
    end
end)

local isSet = false

CreateThread(function()
    while true do
        local sleep = 200        
        local inDistance, zone = isInDistance()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false) 

        if inDistance and not isSet and vehicle ~= 0 and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
            isSet = true
            setEngineFailure(vehicle, zone)
        elseif not inDistance and isSet then
            isSet = false
        elseif inDistance and isSet and vehicle ~= 0 and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then 
            setEngineFailure(vehicle, zone, true)
        end
        
        Wait(sleep)
    end
end)

isInDistance = function()
    local playerCoords = GetEntityCoords(PlayerPedId())

    for k, v in pairs(Config.Zones) do
        local dist = #(v.pos - playerCoords)

        if dist <= v.radius then
            return true, v
        end
    end
    return false
end

setEngineFailure = function(vehicle, v, curDist)
    if ESX.PlayerData and ESX.PlayerData.job and not table.contains(v.allowedJobs, ESX.PlayerData.job.name) then
        if curDist then
            if GetVehicleClass(vehicle) == 16 or GetVehicleClass(vehicle) == 15 then
                SetVehicleEngineHealth(vehicle, 100)
                SetVehicleEngineOn(vehicle, false, true, true)
            end
        else
            ESX.ShowAdvancedNotification(v.Notify.header, v.Notify.subject, v.Notify.msg:format(v.time), v.Notify.mugshot, v.Notify.iconType)
            Wait(v.time * 1000)
            local inDistance, zone = isInDistance()
            if not inDistance then return end

            if GetVehicleClass(vehicle) == 16 or GetVehicleClass(vehicle) == 15 then
                SetVehicleEngineHealth(vehicle, 500)
                Wait(v.timeLow * 1000)
                SetVehicleEngineHealth(vehicle, 300)
                Wait(v.timeLow * 1000)
                SetVehicleEngineOn(vehicle, false, true, true)
            end
        end
    end
end

table.contains = function(t, value)
    for k, v in pairs(t) do
        if v == value then 
            return true
        end
    end
    return false
end