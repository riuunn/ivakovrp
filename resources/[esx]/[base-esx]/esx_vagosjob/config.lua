Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 41
Config.MarkerSize                 = { x = 1.0, y = 2.0, z = 1.0 }
Config.MarkerColor                = { r = 285, g = 284, b = 285 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = false -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.vagosStations = {

  vagos = {

    Blip = {
      Pos     = {},
      Sprite  = -1,
      Display = 4,
      Scale   = 0.6,
      Colour  = 29,
    },

    AuthorizedWeapons = {
      { name = 'WEAPON_BAT',     price = 40 },
      { name = 'WEAPON_MACHETE',       price = 150 } 

    },

	  AuthorizedVehicles = {
		  { name = 'blazer4',    label = 'Quad Sport' },
		  { name = 'granger',  label = '4X4' },
		  { name = 'buffalo',     label = 'Buffalo' },
		  { name = 'manchez',     label = 'Moto' },
		  { name = 'bmx',     label = 'BMX' },
	  },

    Cloakrooms = {
      { x = 357.964, y = -2073.234, z = 21.64 }, -- fait
    },

    Armories = {
      { x = 333.0547, y = -2012.8203, z = 22.3949 }, -- fait
    },

    Vehicles = {
      {
        Spawner    = { x = 337.9230224609, y = -2035.9881591797, z = 21.387628555298 }, -- fait
        SpawnPoint = { x = 333.9230224609, y = -2035.9881591797, z = 21.387628555298 }, -- fait
        Heading    = 2, -- fait
      }
    },

    VehicleDeleters = {
      { x = 332.7152, y = -2043.1131, z = 20.9029 }, -- fait
    },

    BossActions = {
      { x = 360.7694, y = -2038.6475, z = 22.3949 } -- fait
    },

  },

}