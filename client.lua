ESX = exports['es_extended']:getSharedObject()

CreateThread(function()
    while true do
        local wait = 1000

			local pPos = GetEntityCoords(PlayerPedId())
			local pedVeh = GetVehiclePedIsIn(PlayerPedId(), false) 

			for k,v in pairs(Config.Zone) do
				local pos = v.pos
				local dst = Vdist(pos.x, pos.y, pos.z, pPos.x, pPos.y, pPos.z)

				if dst <= v.radius then
					wait = 0
					for a,b in pairs(v.AllowJob) do
						if ESX.PlayerData.job and ESX.PlayerData.job.name ~= b then
							if GetVehicleClass(pedVeh) == 16 or GetVehicleClass(pedVeh) == 15 then
								--[[ SetVehicleEngineHealth(pedVeh, 10) ]]
								SetVehicleEngineOn(pedVeh, false, true, true)
								print(SetVehicleEngineHealth)
							end
						end
					end
				end
			end
		
        Wait(wait)
    end
end)
