ESX = nil
local Doors = {}
local hackingDoors = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function()
	local _source = source
	
	for doorIndex,hacker in pairs(hackingDoors) do
		if hacker == _source then
			hackingDoors[doorIndex] = nil
			TriggerClientEvent('esx_doorlock:killBlip', -1, doorIndex)
		end
	end
end)	

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM doorlock', {}, function(result)
		Doors = result
		for i=1, #Doors, 1 do
			Doors[i].doorID = Doors[i].id
			Doors[i].door1_coords = json.decode(Doors[i].door1_coords)
			Doors[i].door1_hash = tonumber(Doors[i].door1_hash)
			if tonumber(Doors[i].door1_heading == 0) then
				Doors[i].door1_heading = 0.0
			else
				Doors[i].door1_heading = tonumber((Doors[i].door1_heading) / 1.0)
			end
			
			if Doors[i].door2_coords then
				Doors[i].door2_coords = json.decode(Doors[i].door2_coords)
				Doors[i].door2_hash = tonumber(Doors[i].door2_hash)

				if tonumber(Doors[i].door2_heading) == 0 then
					Doors[i].door2_heading = 0.0
				else
					Doors[i].door2_heading = tonumber((Doors[i].door2_heading) / 1.0)
				end
			end
			
			Doors[i].text_coords = json.decode(Doors[i].text_coords)
			Doors[i].authorized_jobs = Split(Doors[i].authorized_jobs, ",")
			
			if Doors[i].isgate == 1 then
				Doors[i].isgate = true
			else
				Doors[i].isgate = false
			end
			
			if Doors[i].unlockable == 1 then
				Doors[i].unlockable = true
			else
				Doors[i].unlockable = false
			end

			if Doors[i].locked == 1 then
				Doors[i].locked = true
			else
				Doors[i].locked = false
			end
		end
		TriggerClientEvent("advanced_locksystem:loadDoors", -1, Doors)
	end)
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	TriggerClientEvent("advanced_locksystem:loadDoors", playerId, Doors)
end)

RegisterServerEvent('advanced_locksystem:deleteDoor')
AddEventHandler('advanced_locksystem:deleteDoor', function(DoorID)
	local _source = source

	MySQL.Async.execute('delete from doorlock where id = @id', {
		['@id'] = DoorID
	}, function(status)
		if status == 1 then
			for i=1, #Doors, 1 do
				if Doors[i] and Doors[i].doorID == DoorID then
					table.remove(Doors, i)
				end
			end
			
			TriggerClientEvent('esx:showNotification', _source, _U('success_delete'))
			TriggerClientEvent("advanced_locksystem:loadDoors", -1, Doors)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('wrong_id'))
		end
	end)
end)

RegisterServerEvent('advanced_locksystem:makingdoor')
AddEventHandler('advanced_locksystem:makingdoor', function(data)
	if data.door2Info ~= nil and data.door2Info.coords then
		MySQL.Async.execute('INSERT INTO doorlock (door1_coords, door2_coords, door1_heading, door2_heading, door1_hash, door2_hash, text_coords, authorized_jobs, isgate, pincode, unlockable, locked, size, distance) VALUES(@door1_coords, @door2_coords, @door1_heading ,@door2_heading ,@door1_hash, @door2_hash, @text_coords, @authorized_jobs, @isgate, @pincode, @unlockable, @locked, @size, @distance)', {
			['@door1_coords'] = json.encode(data.door1Info.coords),
			['@door2_coords'] = json.encode(data.door2Info.coords),
			['@door1_heading'] = data.door1Info.heading,
			['@door2_heading'] = data.door2Info.heading,
			['@door1_hash'] = data.door1Info.hash,
			['@door2_hash'] = data.door2Info.hash,
			['@text_coords'] = json.encode(data.textCoords),
			['@authorized_jobs'] = data.authorized_jobs,
			['@isgate'] = data.isgate,
			['@pincode'] = data.pincode,
			['@unlockable'] = data.unlockable,
			['@locked'] = data.locked,
			['@size'] = data.size,
			['@distance'] = data.distance,
		}, function()
			AddNewDoor()
		end)
	
	else
		MySQL.Async.execute('INSERT INTO doorlock (door1_coords, door1_heading, door1_hash, text_coords, authorized_jobs, isgate, pincode, unlockable, locked, size, distance) VALUES(@door1_coords, @door1_heading ,@door1_hash, @text_coords, @authorized_jobs, @isgate, @pincode, @unlockable, @locked, @size, @distance)', {
			['@door1_coords'] = json.encode(data.door1Info.coords),
			['@door1_heading'] = data.door1Info.heading,
			['@door1_hash'] = data.door1Info.hash,
			['@text_coords'] = json.encode(data.textCoords),
			['@authorized_jobs'] = data.authorized_jobs,
			['@isgate'] = data.isgate,
			['@pincode'] = data.pincode,
			['@unlockable'] = data.unlockable,
			['@locked'] = data.locked,
			['@size'] = data.size,
			['@distance'] = data.distance,
		}, function()
			AddNewDoor()
		end)
	end
end)

function AddNewDoor()

	MySQL.Async.fetchAll('SELECT * FROM doorlock order by id desc', {}, function(result)
		local temp = result
		temp[1].doorID = temp[1].id
		temp[1].door1_coords = json.decode(temp[1].door1_coords)
		temp[1].door1_hash = tonumber(temp[1].door1_hash)
		if tonumber(temp[1].door1_heading) == 0 then
			temp[1].door1_heading = 0.0
		else
			temp[1].door1_heading = tonumber((temp[1].door1_heading) / 1.0)
		end
		
		if temp[1].door2_coords then
			temp[1].door2_coords = json.decode(temp[1].door2_coords)
			temp[1].door2_hash = tonumber(temp[1].door2_hash)
			if tonumber(temp[1].door2_heading) == 0 then
				temp[1].door2_heading = 0.0
			else
				temp[1].door2_heading = tonumber((temp[1].door2_heading) / 1.0)
			end
		end
		
		temp[1].text_coords = json.decode(temp[1].text_coords)
		temp[1].authorized_jobs = Split(temp[1].authorized_jobs, ",")
		
		if temp[1].isgate == 1 then
			temp[1].isgate = true
		else
			temp[1].isgate = false
		end
		
		if temp[1].unlockable == 1 then
			temp[1].unlockable = true
		else
			temp[1].unlockable = false
		end

		if temp[1].locked == 1 then
			temp[1].locked = true
		else
			temp[1].locked = false
		end	
	
		table.insert(Doors, temp[1])
		TriggerClientEvent("advanced_locksystem:loadDoors", -1, Doors)
	end)
end	

function Split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(t, cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

RegisterServerEvent('advanced_locksystem:updateState')
AddEventHandler('advanced_locksystem:updateState', function(doorIndex, state, byHack)
	local xPlayer = ESX.GetPlayerFromId(source)

	if byHack == false then
		if hackingDoors[doorIndex] ~= nil then
			TriggerClientEvent('advanced_locksystem:killBlip', -1, doorIndex)
		end
		Doors[doorIndex].locked = state
		TriggerClientEvent('advanced_locksystem:setDoorState', -1, doorIndex, state)
	else 
		hackingDoors[doorIndex] = nil
		
		Doors[doorIndex].locked = state
		TriggerClientEvent('advanced_locksystem:setDoorState', -1, doorIndex, state)		
		
		if Config.AlarmHacking then
			if Config.ChanceOfAlarm then
				local chance = math.random(1,100)
				if chance > Config.ChanceOfAlarm then
					return
				end
			end
			
			local xPlayers = ESX.GetPlayers()
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == Config.SecurityJob then
					TriggerClientEvent('advanced_locksystem:killBlip', xPlayers[i], doorIndex)
					TriggerClientEvent('esx:showNotification', xPlayers[i], _U('hack_finished'))
				end
			end
		end

	end		
	
end)

RegisterServerEvent('advanced_locksystem:fail')
AddEventHandler('advanced_locksystem:fail', function(doorIndex)
	hackingDoors[doorIndex] = nil
	
	if Config.AlarmHacking then
		if Config.ChanceOfAlarm then
			local chance = math.random(1,100)
			if chance > Config.ChanceOfAlarm then
				return
			end
		end
		
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == Config.SecurityJob then
				TriggerClientEvent('advanced_locksystem:killBlip', xPlayers[i], doorIndex)
				TriggerClientEvent('esx:showNotification', xPlayers[i], _U('hacking_failed'))
			end
		end
	end
	
end)

ESX.RegisterServerCallback('advanced_locksystem:checkPlayerInventory', function(source, cb, pincode, isgate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local keycardItem = xPlayer.getInventoryItem('keycard')
	local lockpickItem = xPlayer.getInventoryItem('lockpick')
	
	if keycardItem.count > 0 or lockpickItem.count > 0 then
		if pincode == '' and isgate == false then
			if lockpickItem.count > 0 then
				cb("lockpick")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('dont_have_lockpick'))
				cb(false)
			end
		else
			if keycardItem.count > 0 then
				cb("hack")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('dont_have_keycard'))
				cb(false)
			end
		end
	else
		if pincode == '' and isgate == false then
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('dont_have_lockpick'))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('dont_have_keycard'))
		end
		
		cb(false)
	end
	
end)

function isAuthorized(jobName, doorObject)
	for k,job in pairs(doorObject.authorizedJobs) do
		if job == jobName then
			return true
		end
	end

	return false
end

RegisterServerEvent('advanced_locksystem:hack')
AddEventHandler('advanced_locksystem:hack', function(coords, doorIndex)
	local source = source
	local _doorIndex = doorIndex
	
	if hackingDoors[_doorIndex] == nil then
		
		hackingDoors[_doorIndex] = source
		
		local xPlayer = ESX.GetPlayerFromId(source)
		local xPlayers = ESX.GetPlayers()
		
		if xPlayer.getInventoryItem('keycard').count >= 1 then

			TriggerClientEvent('advanced_locksystem:currentlyhacking', source)
			
			if Config.AlarmHacking then
				if Config.ChanceOfAlarm then
					local chance = math.random(1,100)
					if chance > Config.ChanceOfAlarm then
						return
					end
				end
				
				local xPlayers = ESX.GetPlayers()
				
				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == Config.SecurityJob then
						TriggerClientEvent('esx:showNotification', xPlayers[i], _U('hacking_started'))
						TriggerClientEvent('advanced_locksystem:setBlip', xPlayers[i], coords, _doorIndex)
					end
				end
			end
		end
	else
		TriggerClientEvent('esx:showNotification', source, _U('someone_hacking'))
	end	
end)

RegisterServerEvent('advanced_locksystem:removeItem')
AddEventHandler('advanced_locksystem:removeItem', function(item)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem(item, 1)
end)