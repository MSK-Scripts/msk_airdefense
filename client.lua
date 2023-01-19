ESX = exports['es_extended']:getSharedObject()

CreateThread(function()
    while true do
        local wait = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local vehicle = GetVehiclePedIsIn(playerPed, false) 

        for k, v in pairs(Config.Zones) do
            local pos = v.pos
            local dist = #(playerCoords - vehicle)

            if dist <= v.radius then
                if ESX.PlayerData and ESX.PlayerData.job and table.contains(v.allowedJobs, ESX.PlayerData.job.name) then
                    if GetVehicleClass(vehicle) == 16 or GetVehicleClass(vehicle) == 15 then
                        -- SetVehicleEngineHealth(vehicle, 10)
                        SetVehicleEngineOn(vehicle, false, true, true)
                    end
                end
            end
        end
        
        Wait(wait)
    end
end)

table.contains = function(t, value)
    for k, v in pairs(t) do
        if v == value then 
            return true
        end
    end
    return false
end
