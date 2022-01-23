-- Density values from 0.0 to 1.0.

DensityMultiplier = 0.5

Citizen.CreateThread(function()

	while true do

	    Citizen.Wait(0)

	    local playerPed = GetPlayerPed(-1)

		local playerLocalisation = GetEntityCoords(playerPed)

		ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)

	    SetVehicleDensityMultiplierThisFrame(DensityMultiplier)

	    SetPedDensityMultiplierThisFrame(DensityMultiplier)

	    SetRandomVehicleDensityMultiplierThisFrame(0.5)

	    SetParkedVehicleDensityMultiplierThisFrame(0.0)

	    SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)

	end

end)