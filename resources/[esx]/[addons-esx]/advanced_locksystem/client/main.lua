ESX = nil
blipDoorHack = {}
Doors = {}
local enablePanel = false
local isLockpicking = false
local showDoorID = false

local infoOn = false
local coordsText = "" 
local headingText = ""
local modelText = ""

local aimInfo = {}
local door1Info = {}
local door2Info = {}
local textCoords

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while not ESX.GetPlayerData().job do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('advanced_locksystem:loadDoors')
AddEventHandler('advanced_locksystem:loadDoors', function(doors)
	Doors = doors
end)

RegisterNetEvent('advanced_locksystem:setBlip')
AddEventHandler('advanced_locksystem:setBlip', function(position, doorNumber)

	blipDoorHack[doorNumber] = nil
	blipDoorHack[doorNumber] = AddBlipForCoord(position.x, position.y, position.z)

	SetBlipSprite(blipDoorHack[doorNumber], 161)
	SetBlipScale(blipDoorHack[doorNumber], 2.0)
	SetBlipColour(blipDoorHack[doorNumber], 5)

	PulseBlip(blipDoorHack[doorNumber])
end)

RegisterNetEvent('advanced_locksystem:killBlip')
AddEventHandler('advanced_locksystem:killBlip', function(doorNumber)
	RemoveBlip(blipDoorHack[doorNumber])
end)

RegisterNetEvent('advanced_locksystem:currentlyhacking')
AddEventHandler('advanced_locksystem:currentlyhacking', function(mycb)
	mycb = true
	TriggerEvent("mhacking:show") --This line is where the hacking event starts
	TriggerEvent("mhacking:start",3,19,mycb1) --This line is the difficulty and tells it to start. First number is how long the blocks will be the second is how much time they have is.
end)

RegisterNetEvent('advanced_locksystem:setDoorState')
AddEventHandler('advanced_locksystem:setDoorState', function(index, state, electric) 
	if Doors[index] ~= nil then
		Doors[index].locked = state
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		letSleep = true
		
		local playerCoords = GetEntityCoords(PlayerPedId())
		
		if isLockpicking then
			letSleep = false
			if IsControlJustReleased(0, 73) or IsPedDeadOrDying(GetPlayerPed(-1)) then
				isLockpicking = false
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				exports['progressBars']:closeUI()
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.0, 'lockpick', 0.0)
			end
		end
		
		for doorIndex ,doorItem in pairs(Doors) do
			if doorItem.door2_coords then -- is double door
				if doorItem.door1_object == nil or doorItem.door1_object == 0 or not DoesEntityExist(doorItem.door1_object) or doorItem.door2_object == nil or doorItem.door2_object == 0 or not DoesEntityExist(doorItem.door2_object) then
					doorItem.door1_object = GetClosestObjectOfType(doorItem.door1_coords.x, doorItem.door1_coords.y, doorItem.door1_coords.z, 1.0, doorItem.door1_hash, false, false, false)
					doorItem.door2_object = GetClosestObjectOfType(doorItem.door2_coords.x, doorItem.door2_coords.y, doorItem.door2_coords.z, 1.0, doorItem.door2_hash, false, false, false)
				else
					if DoesEntityExist(doorItem.door1_object) and DoesEntityExist(doorItem.door2_object) then
						doorItem.distanceToPlayer = #(playerCoords - GetEntityCoords(doorItem.door1_object))
						
						if doorItem.distanceToPlayer <= 50 then
							letSleep = false
							
							if doorItem.locked and doorItem.door1_heading and ESX.Math.Round(GetEntityHeading(doorItem.door1_object)) ~= doorItem.door1_heading then
								SetEntityHeading(doorItem.door1_object, doorItem.door1_heading)
							end
							
							if doorItem.locked and doorItem.door2_heading and ESX.Math.Round(GetEntityHeading(doorItem.door2_object)) ~= doorItem.door2_heading then
								SetEntityHeading(doorItem.door2_object, doorItem.door2_heading)
							end
							
							FreezeEntityPosition(doorItem.door1_object, doorItem.locked)
							FreezeEntityPosition(doorItem.door2_object, doorItem.locked)
						end							
						
					end
				end
			else
				if doorItem.door1_object == nil or doorItem.door1_object == 0 or not DoesEntityExist(doorItem.door1_object) then
					doorItem.door1_object = GetClosestObjectOfType(doorItem.door1_coords.x, doorItem.door1_coords.y, doorItem.door1_coords.z, 1.0, doorItem.door1_hash, false, false, false)
				else
					if DoesEntityExist(doorItem.door1_object) then
						doorItem.distanceToPlayer = #(playerCoords - GetEntityCoords(doorItem.door1_object))
						if doorItem.distanceToPlayer <= 50 then
							letSleep = false

							if not doorItem.isgate and doorItem.locked and doorItem.door1_heading and ESX.Math.Round(GetEntityHeading(doorItem.door1_object)) ~= doorItem.door1_heading then
								SetEntityHeading(doorItem.door1_object, doorItem.door1_heading)
							end
							FreezeEntityPosition(doorItem.door1_object, doorItem.locked)
						end
					end
				end
			end
			
			if doorItem.distanceToPlayer and doorItem.distanceToPlayer < doorItem.distance then
				letSleep = false
				
				local size, displayText = 1, _U('unlocked')

				if doorItem.size then
					size = doorItem.size 
				end
				
				if doorItem.locked then
					displayText = _U('locked') 
				end
				
				if doorItem.pincode ~= '' then
					if doorItem.locked then
						if isAuthorized(doorItem) then
							displayText = _U('press_button', 'Enter Password ' .. _U('locked'))
						else
							if doorItem.unlockable then
								DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.6, 'Press [H] For Hack', 0.50)
							end
							displayText = _U('press_button', 'Enter Password ' .. _U('locked'))
						end
					else
						displayText = _U('press_button', 'Enter Password ' .. _U('unlocked'))
					end
					
				else
					if isAuthorized(doorItem) then
						displayText = _U('press_button', displayText)
					else
						if doorItem.locked and doorItem.unlockable then
							if doorItem.isgate or doorItem.pincode ~= '' then
								DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.6, 'Press [H] For Hack', 0.50)
							else
								DrawText3D(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 0.6, 'Press [H] For LockPick', 0.50)
							end	
						end
					end
				end
				
				if showDoorID then
					ESX.Game.Utils.DrawText3D(vector3(doorItem.text_coords.x, doorItem.text_coords.y, doorItem.text_coords.z - 1.0), '~y~ID : ' .. doorItem.doorID, 1)
				end
				
				ESX.Game.Utils.DrawText3D(doorItem.text_coords, displayText, size)

				function mycb1(success, timeremaining)
					if success then
						doorItem.locked = not doorItem.locked
						TriggerServerEvent('advanced_locksystem:updateState', doorIndex, doorItem.locked, true)
						TriggerEvent('mhacking:hide')
					else
						TriggerServerEvent('advanced_locksystem:fail', doorIndex)
						TriggerEvent('mhacking:hide')
					end
				end
				
				if IsControlJustReleased(0, Config.HackAndLockpickKey) and doorItem.unlockable then
					if doorItem.locked == true then
						ESX.TriggerServerCallback("advanced_locksystem:checkPlayerInventory", function(result)
							if result ~= false then
								if result == "lockpick" then
									LockPick(doorIndex)
								else
									if Config.KeycardCanBeBreak then
										local chance = math.random(1,100)
										if chance < Config.KeycardChance then
											TriggerServerEvent('advanced_locksystem:hack', doorItem.door1_coords, doorIndex)
										else
											TriggerServerEvent('advanced_locksystem:removeItem', 'keycard')
											ESX.ShowNotification(_U('keycard_broken'))						
										end
									else
										TriggerServerEvent('advanced_locksystem:hack', doorItem.door1_coords, doorIndex)
									end
								end
							end
						end, doorItem.pincode, doorItem.isgate)
					end
				end
				
				if IsControlJustReleased(0, 38) then
					if doorItem.pincode ~= '' then
						toggleField(true, doorItem.pincode, doorIndex, doorItem.locked, false)
					else
						if isAuthorized(doorItem) then
							doorItem.locked = not doorItem.locked
							TriggerServerEvent('advanced_locksystem:updateState', doorIndex, doorItem.locked, false) -- Broadcast new state of the door to everyone
						end
					end	
				end
			end	
		end	
		
        if infoOn then                                      -- If the info is on then...
            letSleep = false                                -- Only loop every 5ms (equivalent of 200fps).
            local player = GetPlayerPed(-1)                 -- Get the player.
            if IsPlayerFreeAiming(PlayerId()) then          -- If the player is free-aiming (update texts)...
                local entity = getEntity(PlayerId())        -- Get what the player is aiming at. This isn't actually the function, that's below the thread.
                local coords = GetEntityCoords(entity)      -- Get the coordinates of the object.
                local heading = GetEntityHeading(entity)    -- Get the heading of the object.
                local model = GetEntityModel(entity)        -- Get the hash of the object.
                coordsText = coords                         -- Set the coordsText local.
                headingText = heading                       -- Set the headingText local.
                modelText = model                           -- Set the modelText local.
				aimInfo = {
					coords  = coords,
					heading = heading,
					hash    = model
				}
            end
			
			DrawInfos("Coordinates : " .. coordsText .. "\nHeading : " .. headingText .. "\nHash : " .. modelText)
        end
		
		if letSleep then
			Citizen.Wait(1000)
		end
	end
end)

-- Function to get the object the player is actually aiming at.
function getEntity(player)                                          -- Create this function.
    local result, entity = GetEntityPlayerIsFreeAimingAt(player)    -- This time get the entity the player is aiming at.
    return entity                                                   -- Returns what the player is aiming at.
end                                                                 -- Ends the function.

-- Function to draw the text.
function DrawInfos(text)
    SetTextColour(255, 255, 255, 255)   -- Color
    SetTextFont(4)                      -- Font
    SetTextScale(0.6, 0.6)              -- Scale
    SetTextWrap(0.0, 1.0)               -- Wrap the text
    SetTextCentre(false)                -- Align to center(?)
    SetTextDropshadow(0, 0, 0, 0, 255)  -- Shadow. Distance, R, G, B, Alpha.
    SetTextEdge(50, 0, 0, 0, 255)       -- Edge. Width, R, G, B, Alpha.
    SetTextOutline()                    -- Necessary to give it an outline.
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.015, 0.51)               -- Position
end

function DrawText3D(x, y, z, text, scale) local onScreen, _x, _y = World3dToScreen2d(x, y, z) local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) SetTextScale(scale, scale) SetTextFont(4) SetTextProportional(1) SetTextEntry("STRING") SetTextCentre(true) SetTextColour(255, 255, 255, 215) AddTextComponentString(text) DrawText(_x, _y) local factor = (string.len(text)) / 700 DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 41, 11, 41, 100) end

function isAuthorized(door)

	if not ESX or not ESX.PlayerData.job then
		return false
	end
	
	if door ~= true then

		for k,v in pairs(door.authorized_jobs) do
			if v == ESX.PlayerData.job.name then
				return true
			end
		end
	
	end

	return false
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result --Returns the result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

function toggleField(enable, pincode, k, locked, hacked)

  SetNuiFocus(enable, enable)
  enablePanel = enable

  SendNUIMessage({
    type = "enableui",
    enable = enable,
	pincode = pincode,
	doorindex = k,
	locked = locked,
	hacked = hacked,
  })

end

RegisterNUICallback('escape', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('try', function(data, cb)
    
	SetNuiFocus(false, false)
	
	local inserted_code = data.inserted_code
	local doorindex = data.doorindex
	local locked = not data.locked
	local hacked = data.hacked
	
	if inserted_code == data.pincode then
	
		TriggerServerEvent('advanced_locksystem:updateState', doorindex, locked, false) 
		
		cb('ok')
	else
		ESX.ShowNotification(_U('wrong_code'))
		cb('ok')
	end	
end)

function LockPick(doorIndex)
	isLockpicking = true
	local Timer = Config.LockPickTimer

	FreezeEntityPosition(PlayerPedId(), true)
	loaddict("mini@safe_cracking")
	TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "idle_base", 3.5, -8, -1, 2, 0, 0, 0, 0, 0)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.7)
	exports['progressBars']:startUI(Config.LockPickTimer, "Pick Locking")

	while Timer > 0 and isLockpicking do
		Timer = Timer - 1000
		Citizen.Wait(1000)
	end
	
	if isLockpicking then
		local chance = math.random(1,100)
		if chance < Config.LockpickChance then
			local door = Doors[doorIndex]
			TriggerServerEvent('advanced_locksystem:updateState', doorIndex, false, false)	
		else
			if Config.LockpickCanGetBroken then
				TriggerServerEvent('advanced_locksystem:removeItem', 'lockpick')
				ESX.ShowNotification(_U('broken_lockpick'))
			else
				ESX.ShowNotification(_U('failed_to_open'))
			end
		end
		
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.0, 'lockpick', 0.0)
		ClearPedTasks(PlayerPedId())
		FreezeEntityPosition(PlayerPedId(), false)
		isLockpicking = false
		
	end	
end

function loaddict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Wait(10)
	end
end

RegisterCommand('aimdoor', function(source, args)
	infoOn = true
end)

RegisterCommand('cleardoors', function(source, args)
	infoOn = false
	aimInfo = {}
	door1Info = {}
	door2Info = {}
	textCoords = nil
	ESX.ShowNotification(_U('all_doors_clear'))
end)

RegisterCommand('savedoor1', function(source, args)
	if aimInfo.coords ~= nil then
		door1Info = aimInfo
		ESX.ShowNotification(_U('door1_saved'))
	end
end)

RegisterCommand('savedoor2', function(source, args)
	if door1Info.coords ~= nil then
		if aimInfo.coords ~= nil then
			door2Info = aimInfo
			ESX.ShowNotification(_U('door2_saved'))
		end
	else
		ESX.ShowNotification(_U('need_set_door1'))	
	end
end)

RegisterCommand('savemycoords', function(source, args)
	local coords = GetEntityCoords(PlayerPedId())
	textCoords = vector3(coords.x, coords.y, coords.z + 1.0)
	ESX.ShowNotification(_U('you_have_set_coords'))
end)

RegisterCommand('createdoor', function(source, args)
	if door1Info.coords ~= nil then
		if textCoords then
			SetNuiFocus(true, true)
			
			if door2Info.coords ~= nil then
				SendNUIMessage({
					type = "createdoor",
					door1 = door1Info,
					door2 = door2Info,
					textCoords = textCoords,
					enable = true
				})
			else
				SendNUIMessage({
					type = "createdoor",
					door1 = door1Info,
					door2 = nil,
					textCoords = textCoords,
					enable = true
				})
			end
		else
			ESX.ShowNotification(_U('you_did_not_set_coords'))
		end
	else
		ESX.ShowNotification(_U('you_did_not_set_doors'))
	end
end)

RegisterNUICallback('makingdoor', function(data, cb)
	SetNuiFocus(false, false)
	
	TriggerServerEvent("advanced_locksystem:makingdoor", data)
	aimInfo = {}
	door1Info = {}
	door2Info = {}
	textCoords = nil
	infoOn = false
end)

RegisterNUICallback('cancelmakingdoor', function(data, cb)
	SetNuiFocus(false, false)
end)

RegisterCommand('showdoorid', function(source, args)
	showDoorID = not showDoorID
end)

RegisterCommand('deletedoor', function(source, args)
	if tonumber(args[1]) then
		TriggerServerEvent("advanced_locksystem:deleteDoor", tonumber(args[1]))
	else
		ESX.ShowNotification(_U('insert_correct_id'))
	end
end)