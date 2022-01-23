local GARAGE_TYPE = "owned_garage"

local function openPlayerVehicles(markerId)
    TriggerServerCallback('esx_job_creator:garage_owned:getVehicles', function(vehicles, spawnData)
        local plyPed = PlayerPedId()
        
        local elements = {}

        for k, vehicleData in pairs(vehicles) do
            local vehicleProps = json.decode(vehicleData.vehicle)

            local vehicleLabel = getVehicleNameFromModel(vehicleProps.model)

            local isVehicleOutside = vehicleData.stored == 0 or not vehicleData.stored

            if(vehicleData.plate) then
                vehicleLabel = vehicleLabel .. " - " .. vehicleData.plate 
            end

            if(isVehicleOutside) then
                vehicleLabel =  getLocalizedText('buyable_vehicle:outside', vehicleLabel)
            end

            table.insert(elements, {
                label = vehicleLabel,
                vehicleName = vehicleProps.model,
                vehicleProps = vehicleProps,
                vehiclePlate = vehicleData.plate,
                isOutside = isVehicleOutside
            })
        end

        if(#elements == 0) then
            table.insert(elements, {label = getLocalizedText('no_vehicles_in_garage')})
        end

        ESX.UI.Menu.CloseAll()

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'job_garage_owned', {
            title = getLocalizedText('garage'),
            align = config.menuPosition,
            elements = elements
        },
        function(data, menu)
            local vehicleName = data.current.vehicleName
            
            if(not vehicleName) then return end

            if(data.current.isOutside) then
                notifyClient(getLocalizedText('vehicle_outside'))
                return
            end
            
            local vehicleProps = data.current.vehicleProps
            local vehicleId = data.current.vehicleId
            local vehiclePlate = data.current.vehiclePlate

            local coords = vector3(tonumber(spawnData.spawnCoords.x), tonumber(spawnData.spawnCoords.y), tonumber(spawnData.spawnCoords.z))

            ESX.Game.SpawnVehicle(vehicleName, coords, spawnData.heading, function(vehicle)
                TriggerServerEvent('esx_job_creator:garage_owned:spawnedVehicle', vehiclePlate)

                SetEntityAsMissionEntity(vehicle, true, true)
                
                ESX.Game.SetVehicleProperties(vehicle, vehicleProps)

                if(vehiclePlate) then
                    SetVehicleNumberPlateText(vehicle, vehiclePlate)
                end

                TaskEnterVehicle(plyPed, vehicle, 1000, -1, 2.0, 16, 0)

                addVehicleToOutsideVehicles(GARAGE_TYPE, vehicle)
            end)

            openedMenu = nil
            ESX.UI.Menu.CloseAll()
        end,
        function(data, menu)
            openedMenu = nil
            menu.close()
        end)
    end, markerId)
end

function openGarageOwned(markerId)
    local plyPed = PlayerPedId()

    ESX.UI.Menu.CloseAll()

    local elements = {
        {label = getLocalizedText('garage'), value = "garage"},
    }

    local vehicleToDelete = IsPedInAnyVehicle(plyPed, false) and GetVehiclePedIsIn(plyPed, false) or getOutsideVehicleInRange(GARAGE_TYPE)

    if (vehicleToDelete) then
        table.insert(elements, 1, {
            label = getLocalizedText('park_vehicle'),
            value = "deposit"
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_owned_options', {
        title = getLocalizedText('garage'),
        align = config.menuPosition,
        elements = elements
    },
    function(data, menu)
        local action = data.current.value

        if(action == "garage") then
            openPlayerVehicles(markerId)
        elseif(action == "deposit") then
            if(DoesEntityExist(vehicleToDelete)) then
                local props = ESX.Game.GetVehicleProperties(vehicleToDelete)
                local plate = GetVehicleNumberPlateText(vehicleToDelete)
                
                TriggerServerCallback('esx_job_creator:garage_owned:updateVehicleProps', function(isSuccessful) 
                    if(isSuccessful) then
                        if(DoesEntityExist(vehicleToDelete)) then
                            DeleteVehicle(vehicleToDelete)
            
                            deleteVehicleFromOutsideVehicles(GARAGE_TYPE, vehicleToDelete)

                            openedMenu = nil
                            menu.close()
                        end
                    end
                end, markerId, props, plate)
            end
        end
    end,
    function(data, menu)
        openedMenu = nil
        menu.close()
    end)
end