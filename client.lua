ESX = exports["es_extended"]:getSharedObject()

local isSet = false

CreateThread(function()
    while true do
        local sleep = 200
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local vehicle = GetVehiclePedIsIn(playerPed, false) 

        for k, v in pairs(Config.Zones) do
            local pos = v.pos
            local dist = #(pos - playerCoords)

            if dist <= v.radius and not isSet then
                isSet = true
                setEngineFailure(vehicle, v)
            elseif dist > v.radius and isSet then
                isSet = false
            end
        end
        
        Wait(sleep)
    end
end)

setEngineFailure = function(vehicle, v)
    if ESX.PlayerData and ESX.PlayerData.job and not table.contains(v.allowedJobs, ESX.PlayerData.job.name) then
        ESX.ShowAdvancedNotification(v.Notify.header, v.Notify.subject, v.Notify.msg:format(v.time), v.Notify.mugshot, v.Notify.iconType)
        Wait(v.time * 1000)

        if GetVehicleClass(vehicle) == 16 or GetVehicleClass(vehicle) == 15 then
            SetVehicleEngineHealth(vehicle, 500)
            Wait(v.timeLow * 1000)
            SetVehicleEngineHealth(vehicle, 300)
            Wait(v.timeLow * 1000)
            SetVehicleEngineOn(vehicle, false, true, true)
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