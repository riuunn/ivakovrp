Config = {}
Config.Locale = 'en'

local seconds = 1000

Config.AlarmHacking         = true         -- when someone starts to hack a door it will trigger alarm to security
Config.ChanceOfAlarm        = 80           
Config.SecurityJob          = 'police'     -- the job name that gets alarm when someone starts to hack a door
Config.LockPickTimer        = 10 * seconds -- lockpick timer (default 10 seconds)
Config.LockpickChance       = 70           -- lockpick chance to open a door
Config.LockpickCanGetBroken = true         -- if lockpicking failed then break the item and remove it from player inventory
Config.KeycardCanBeBreak    = false        -- if it's true then hacker before uses his keycard it goes into a chance and if hacker loses the chance his keycard will break
Config.KeycardChance        = 90           -- chance of hack to be done successfully if the card did not break
Config.HackAndLockpickKey   = 74           -- H by default

--[[ commands

	aimdoor,
	savedoor1,
	savedoor2,
	cleardoors, -- for reseting the savemycoords, aimdoor, savedoor1, savedoor2 that already have value, so after using cleardoors commands all these parameters will be empty
	savemycoords,
	createdoor,
	showdoorid,
	deletedoor,

]]--
