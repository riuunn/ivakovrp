ESX = nil
local lastSkin, playerLoaded, cam, isCameraActive
local firstSpawn, zoomOffset, camOffset, heading = true, 0.0, 0.0, 90.0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenMenu(submitCb, cancelCb, restrict)
	local playerPed = PlayerPedId()

	TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkin = skin
	end)

	TriggerEvent('skinchanger:getData', function(components, maxVals)
		local elements    = {}
		local _components = {}

		-- Restrict menu
		if restrict == nil then
			for i=1, #components, 1 do
				_components[i] = components[i]
			end
		else
			for i=1, #components, 1 do
				local found = false

				for j=1, #restrict, 1 do
					if components[i].name == restrict[j] then
						found = true
					end
				end

				if found then
					table.insert(_components, components[i])
				end
			end
		end

		-- Insert elements
		for i=1, #_components, 1 do
			local value       = _components[i].value
			local componentId = _components[i].componentId

			if componentId == 0 then
				value = GetPedPropIndex(playerPed, _components[i].componentId)
			end

			local data = {
				label     = _components[i].label,
				name      = _components[i].name,
				value     = value,
				min       = _components[i].min,
				textureof = _components[i].textureof,
				zoomOffset= _components[i].zoomOffset,
				camOffset = _components[i].camOffset,
				type      = 'slider'
			}

			for k,v in pairs(maxVals) do
				if k == _components[i].name then
					data.max = v
					break
				end
			end

			table.insert(elements, data)
		end

		CreateSkinCam()
		zoomOffset = _components[1].zoomOffset
		camOffset = _components[1].camOffset

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'skin', {
			title    = _U('skin_menu'),
			align    = 'top-left',
			css 	 = 'skin',
			elements = elements
		}, function(data, menu)
			TriggerEvent('skinchanger:getSkin', function(skin)
				lastSkin = skin
			end)

			submitCb(data, menu)
			DeleteSkinCam()
		end, function(data, menu)
			menu.close()
			DeleteSkinCam()
			TriggerEvent('skinchanger:loadSkin', lastSkin)

			if cancelCb ~= nil then
				cancelCb(data, menu)
			end
		end, function(data, menu)
			local skin, components, maxVals

			TriggerEvent('skinchanger:getSkin', function(getSkin)
				skin = getSkin
			end)

			zoomOffset = data.current.zoomOffset
			camOffset = data.current.camOffset

			if skin[data.current.name] ~= data.current.value then
				-- Change skin element
				TriggerEvent('skinchanger:change', data.current.name, data.current.value)

				-- Update max values
				TriggerEvent('skinchanger:getData', function(comp, max)
					components, maxVals = comp, max
				end)

				local newData = {}

				for i=1, #elements, 1 do
					newData = {}
					newData.max = maxVals[elements[i].name]

					if elements[i].textureof ~= nil and data.current.name == elements[i].textureof then
						newData.value = 0
					end

					menu.update({name = elements[i].name}, newData)
				end

				menu.refresh()
			end
		end, function(data, menu)
			DeleteSkinCam()
		end)
	end)
end


function CreateSkinCam()
	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	end

	SetCamActive(cam, true)
	RenderScriptCams(true, true, 500, true, true)

	isCameraActive = true
	SetCamRot(cam, 0.0, 0.0, 270.0, true)
	SetEntityHeading(playerPed, 90.0)
end

function DeleteSkinCam()
	isCameraActive = false
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 500, true, true)
	cam = nil
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isCameraActive then
			DisableControlAction(2, 30, true)
			DisableControlAction(2, 31, true)
			DisableControlAction(2, 32, true)
			DisableControlAction(2, 33, true)
			DisableControlAction(2, 44, true)
			DisableControlAction(2, 35, true)
			DisableControlAction(0, 25, true) -- Input Aim
			DisableControlAction(0, 24, true) -- Input Attack

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			local angle = heading * math.pi / 180.0
			local theta = {
				x = math.cos(angle),
				y = math.sin(angle)
			}

			local pos = {
				x = coords.x + (zoomOffset * theta.x),
				y = coords.y + (zoomOffset * theta.y)
			}

			local angleToLook = heading - 140.0
			if angleToLook > 360 then
				angleToLook = angleToLook - 360
			elseif angleToLook < 0 then
				angleToLook = angleToLook + 360
			end

			angleToLook = angleToLook * math.pi / 180.0
			local thetaToLook = {
				x = math.cos(angleToLook),
				y = math.sin(angleToLook)
			}

			local posToLook = {
				x = coords.x + (zoomOffset * thetaToLook.x),
				y = coords.y + (zoomOffset * thetaToLook.y)
			}

			SetCamCoord(cam, pos.x, pos.y, coords.z + camOffset)
			PointCamAtCoord(cam, posToLook.x, posToLook.y, coords.z + camOffset)

			-- ESX.ShowHelpNotification(_U('use_rotate_view'))
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	local angle = 90

	while true do
		Citizen.Wait(0)

		if isCameraActive then
			if IsControlPressed(0, 108) or IsControlPressed(0, 34) then
				angle = angle - 1
			elseif IsControlPressed(0, 109) or IsControlPressed(0, 9) then
				angle = angle + 1
			end

			if angle > 360 then
				angle = angle - 360
			elseif angle < 0 then
				angle = angle + 360
			end

			heading = angle + 0.0
		else
			Citizen.Wait(500)
		end
	end
end)

function OpenSaveableMenu(submitCb, cancelCb, restrict)
	TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkin = skin
	end)

	OpenMenu(function(data, menu)
		menu.close()
		DeleteSkinCam()

		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerServerEvent('esx_skin:save', skin)

			if submitCb ~= nil then
				submitCb(data, menu)
			end
		end)

	end, cancelCb, restrict)
end

function OpenSaveableMenu2(submitCb, cancelCb, restrict)
	TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkin = skin
	end)

	OpenMenu(function(data, menu)
		menu.close()
		DeleteSkinCam()

		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerServerEvent('esx_skin:save', skin)

			if submitCb ~= nil then
				submitCb(data, menu)
			end
		end)

		DisplayRadar(false)
    	PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)

		DoScreenFadeOut(0)
		SetTimecycleModifier('rply_saturation')
		SetTimecycleModifier('rply_vignette')
		DoScreenFadeIn(1500)
		ClearPedTasks(GetPlayerPed(-1))

		TaskPedSlideToCoord(PlayerPedId(), -825.3, -113.76, 26.98, 114.5, 1.0)
		Citizen.Wait(7100)
		TaskPedSlideToCoord(PlayerPedId(), -831.74, -117.7, 27.04, 115.5, 1.0)
		Citizen.Wait(4000)
		TaskPedSlideToCoord(PlayerPedId(), -851.06, -127.53, 36.68, 122.5, 1.0)
		Citizen.Wait(13000)
		SetTimecycleModifier('')
		PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
		for i = 0, 357 do
			EnableAllControlActions(i)
		end
		DisplayRadar(true)
		ESX.ShowNotification("Bienvenue sur IvakovRP, passez un agréable moment avec nous !")

		ESX.Scaleform.ShowFreemodeMessage("~y~IvakovRP", "Bienvenue sur IvakovRP\nPassez un agréable moment parmis nous !", 8)

	end, cancelCb, restrict)
end

function OpenSaveableMenuPed(submitCb, cancelCb, restrict)
	TriggerEvent('skinchanger:getSkin', function(skin)
		lastSkin = skin
	end)

	OpenMenu(function(data, menu)
		menu.close()
		DeleteSkinCam()

		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerServerEvent('esx_skin:save', skin)

			if submitCb ~= nil then
				submitCb(data, menu)
			end
		end)

	end, cancelCb, restrict)
end

AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not playerLoaded do
			Citizen.Wait(100)
		end

		if firstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('skinchanger:loadSkin', {sex = 0})
				else
					TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)

			firstSpawn = false
		end
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	playerLoaded = true
end)

AddEventHandler('esx_skin:getLastSkin', function(cb)
	cb(lastSkin)
end)

AddEventHandler('esx_skin:setLastSkin', function(skin)
	lastSkin = skin
end)

RegisterNetEvent('esx_skin:openMenu')
AddEventHandler('esx_skin:openMenu', function(submitCb, cancelCb)
	OpenMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openRestrictedMenu')
AddEventHandler('esx_skin:openRestrictedMenu', function(submitCb, cancelCb, restrict)
	OpenMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:openRestrictedMenu1')
AddEventHandler('esx_skin:openRestrictedMenu1', function(submitCb, cancelCb)
  local restrict = {}
  restrict = {
    'tshirt_1',
    'tshirt_2',
    'torso_1',
    'torso_2',
    'decals_1',
    'decals_2',
    'arms',
    'pants_1',
    'pants_2',
    'shoes_1',
	'shoes_2',
	'bags_1',
	'bags_2',
	'watches_1',
	'watches_2',
	'bracelets_1',
	'chain_1',
	'chain_2',
    }
    OpenSaveableMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:openRestrictedMenu2')
AddEventHandler('esx_skin:openRestrictedMenu2', function(submitCb, cancelCb)
  local restrict = {}
  restrict = {
	'sex',
    'face',
    'skin',
    'age_1',
    'age_2',
    'beard_1',
    'beard_2',
    'beard_3',
    'beard_4',
    'hair_1',
    'hair_2',
    'hair_color_1',
    'hair_color_2',
    'eyebrows_1',
    'eyebrows_2',
    'eyebrows_3',
    'eyebrows_4',
    'makeup_1',
    'makeup_2',
    'makeup_3',
    'makeup_4',
    'lipstick_1',
    'lipstick_2',
    'lipstick_3',
    'lipstick_4',
    'tshirt_1',
    'tshirt_2',
    'torso_1',
    'torso_2',
    'decals_1',
    'decals_2',
    'arms',
    'pants_1',
    'pants_2',
    'shoes_1',
    'shoes_2',
    }
    OpenSaveableMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:openSaveableMenu')
AddEventHandler('esx_skin:openSaveableMenu', function(submitCb, cancelCb)
	OpenSaveableMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openSaveableMenu2')
AddEventHandler('esx_skin:openSaveableMenu2', function(submitCb, cancelCb)
	OpenSaveableMenu2(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openSaveableRestrictedMenu')
AddEventHandler('esx_skin:openSaveableRestrictedMenu', function(submitCb, cancelCb, restrict)
	OpenSaveableMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:requestSaveSkin')
AddEventHandler('esx_skin:requestSaveSkin', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_skin:responseSaveSkin', skin)
	end)
end)

function openCinematique()
    hasCinematic = not hasCinematic
    if not hasCinematic then -- show
        SendNUIMessage({openCinema = false})
        ESX.UI.HUD.SetDisplay(1.0)
        TriggerEvent('es:setMoneyDisplay', 1.0)
        TriggerEvent('esx_status:setDisplay', 1.0)
        DisplayRadar(true)
        TriggerEvent('ui:toggle', true)
    elseif hasCinematic then -- hide
        SendNUIMessage({openCinema = true})
        ESX.UI.HUD.SetDisplay(0.0)
        TriggerEvent('es:setMoneyDisplay', 0.0)
        TriggerEvent('esx_status:setDisplay', 0.0)
        DisplayRadar(false)
        TriggerEvent('ui:toggle', false)
    end
end