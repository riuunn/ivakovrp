Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 102, g = 0, b = 102 }
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.ReviveReward               = 0  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders
Config.Locale = 'fr'

local second = 2000
local minute = 60 * second

-- How much time before auto respawn at hospital
-- Config.RespawnDelayAfterRPDeath   =  5 * minute 
Config.RespawnDelayAfterRPDeath   =  minute 

-- How much time before a menu opens to ask the player if he wants to respawn at hospital now
-- The player is not obliged to select YES, but he will be auto respawn
-- at the end of RespawnDelayAfterRPDeath just above.
Config.RespawnToHospitalMenuTimer   = true
Config.MenuRespawnToHospitalDelay   = 1.30 * minute

Config.EnablePlayerManagement       = true
Config.EnableSocietyOwnedVehicles   = false

Config.RemoveWeaponsAfterRPDeath    = false
Config.RemoveCashAfterRPDeath       = false
Config.RemoveItemsAfterRPDeath      = false

-- Will display a timer that shows RespawnDelayAfterRPDeath time remaining
Config.ShowDeathTimer               = true

-- Will allow to respawn at any time, don't use with RespawnToHospitalMenuTimer enabled!
Config.EarlyRespawn                 = false
-- The player can have a fine (on bank account)
Config.RespawnFine                  = false
Config.RespawnFineAmount            = 500

Config.Blip = {
 	Pos     = { x = -451.9799999999814, y = -335.64000000001397, z = 33.36000000000058 },
 	Sprite  = 61,
 	Display = 4,
 	Scale   = 1.2,
 	Colour  = 2,
 }

--Config.HelicopterSpawner = {
--	Spawner    = { x = 343.32, y = -587.69, z = 74.16 },
--	SpawnPoint = { x = 342.58, y = -587.91, z = 74.16 },
--	Heading    = 0.0,
--}

-- https://wiki.fivem.net/wiki/Vehicles
Config.AuthorizedVehicles = {

	{
		model = 'ambulance',
		label = 'Ambulance'
	},
	{
		model = 'dodgeEMS',
		label = 'Dodge'
	}

}

Config.Zones = {

	--[[HospitalInteriorEntering1 = { -- Main entrance
		Pos	= { x = -448.0529, y = -340.9302, z = 33.5018 },
		Type = 1
	},]]

	HospitalInteriorInside1 = {
		Pos	= { x = -458.79, y = -284.29, z = 33.96 }, --Respawn
		Type = -1
	},

	--[[HospitalInteriorOutside1 = {
		Pos	= { x = -447.6010, y = -333.9351, z = 33.5018 },
		Type = -1
	},

	HospitalInteriorExit1 = {
		Pos	= { x = -458.3774, y = -367.2123, z = -187.4548 },
		Type = 1
	},

	HospitalInteriorEntering2 = { -- Lift go to the roof
		Pos	= { x = 247.1, y = -1371.4, z = 23.5 },
		Type = 1
	},

	HospitalInteriorInside2 = { -- Roof outlet
		Pos	= { x = 333.1,	y = -1434.9, z = 45.5 },
		Type = -1
	},

	HospitalInteriorOutside2 = { -- Lift back from roof
		Pos	= { x = 249.1,	y = -1369.6, z = 23.5 },
		Type = -1
	},

	HospitalInteriorExit2 = { -- Roof entrance
		Pos	= { x = 335.5, y = -1432.0, z = 45.5 },
		Type = 1
	},]]

	-- AmbulanceActions = { -- Cloakroom
	-- 	Pos	= { x = 335.88986206055, y = -579.3955078125, z = 27.791469573975 },
	-- 	Type = 1
	-- },

	-- VehicleSpawner = {
	-- 	Pos	= { x = 328.96701049805, y = -558.71502685547, z = 27.743446350098 },
	-- 	Type = 1
	-- },

	-- VehicleSpawnPoint = {
	-- 	Pos	= { x = 329.373535515625, y = -541.77667236328, z = 27.7434425354 },
	-- 	Type = -1
	-- },

	-- VehicleDeleter = {
	-- 	Pos	= { x = 316.55816650391, y = -550.78698730469, z = 27.743434906006 },
	-- 	Type = 1
	-- },

	Pharmacy = {
		Pos	= { x = -490.7, y = -339.82, z = 41.37 },
		Type = 1
	},

	--[[ParkingDoorGoOutInside = {
		Pos	= { x = 234.56, y = -1373.77, z = 20.97 },
		Type = 1
	},

	ParkingDoorGoOutOutside = {
		Pos	= { x = 320.98, y = -1478.62, z = 28.81 },
		Type = -1
	},

	ParkingDoorGoInInside = {
		Pos	= { x = 238.64, y = -1368.48, z = 23.53 },
		Type = -1
	},

	ParkingDoorGoInOutside = {
		Pos	= { x = 317.97, y = -1476.13, z = 28.97 },
		Type = 1
	},

	StairsGoTopTop = {
		Pos	= { x = 251.91, y = -1363.3, z = 38.53 },
		Type = -1
	},

	StairsGoTopBottom = {
		Pos	= { x = 237.45, y = -1373.89, z = 26.30 },
		Type = -1
	},

	StairsGoBottomTop = {
		Pos	= { x = 256.58, y = -1357.7, z = 37.30 },
		Type = -1
	},

	StairsGoBottomBottom = {
		Pos	= { x = 235.45, y = -1372.89, z = 26.30 },
		Type = -1
	}]]

}