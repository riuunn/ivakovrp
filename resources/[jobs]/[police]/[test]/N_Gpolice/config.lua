Config                            = {}

config = {

    armurie = {
        {
            grade = "Recrue",
            weapons = {
                "weapon_flar",
                "weapon_flashlight",
                "weapon_stungun",
                "WEAPON_NIGHTSTICK",
            }
        },
        {
            grade = "Officier",
            weapons = {
                "weapon_flare",
                "weapon_flashlight",
                "weapon_stungun",
                "WEAPON_NIGHTSTICK",
                "WEAPON_PISTOL",
            }
        },
        {
            grade = "Sergent",
            weapons = {
                "weapon_flare",
                "weapon_flashlight",
                "weapon_stungun",
                "WEAPON_NIGHTSTICK",
                "WEAPON_PISTOL",
                "WEAPON_BZGAS",
                "WEAPON_PUMPSHOTGUN",
            }
        },
        {
            grade = "Brigadier",
            weapons = {
                "weapon_flare",
                "weapon_flashlight",
                "weapon_stungun",
                "WEAPON_NIGHTSTICK",
                "WEAPON_PISTOL",
                "WEAPON_PISTOL50",
                "WEAPON_BZGAS",
                "WEAPON_PUMPSHOTGUN",
                "WEAPON_SMG",
            }
        },
        {
            grade = "Lieutenant",
            weapons = {
                "weapon_flare",
                "weapon_flashlight",
                "weapon_stungun",
                "WEAPON_NIGHTSTICK",
                "WEAPON_PISTOL",
                "WEAPON_PISTOL50",
                "WEAPON_BZGAS",
                "WEAPON_PUMPSHOTGUN",
                "WEAPON_SMG",
                "WEAPON_CARBINERIFLE_MK2",
            }
        },
        {
            grade = "Capitaine",
            weapons = {
                "weapon_flare",
                "weapon_flashlight",
                "weapon_stungun",
                "WEAPON_NIGHTSTICK",
                "WEAPON_PISTOL",
                "WEAPON_PISTOL50",
                "WEAPON_BZGAS",
                "WEAPON_PUMPSHOTGUN",
                "WEAPON_SMG",
                "WEAPON_CARBINERIFLE_MK2",
            }
        },
        {
            grade = "Commandant",
            weapons = {
                "weapon_flare",
                "weapon_flashlight",
                "weapon_stungun",
                "WEAPON_NIGHTSTICK",
                "WEAPON_PISTOL",
                "WEAPON_PISTOL50",
                "WEAPON_BZGAS",
                "WEAPON_PUMPSHOTGUN",
                "WEAPON_SMG",
                "WEAPON_CARBINERIFLE_MK2",
            }
        },
    },

    serviceWeapons = { -- All weapons to remove when service out
        "weapon_nightstick",
        "weapon_stungun",
        "weapon_combatpistol",
        "weapon_pumpshotgun",
        "weapon_flare",
        "weapon_flashlight",
        "WEAPON_PISTOL",
        "WEAPON_PISTOL50",
        "WEAPON_BZGAS",
        "WEAPON_SMG",
        "WEAPON_CARBINERIFLE_MK2",
    },
    
    zone = {
        {"armurie", vector3(484.60690307617, -1003.6787719727, 24.734670639038), "Appuyer sur ~INPUT_PICKUP~ pour intéragir", function() OpenPoliceArmurieMenu() end, "s_m_y_cop_01", 6.0628008842468, true},
        {"garage", vector3(464.99691772461, -1012.8623657227, 28.050338745117), "Appuyer sur ~INPUT_PICKUP~ pour ouvrir le garage", function() OpenPoliceGarageMenu() end, "s_m_y_cop_01", 3.1009781360626, true},
    },
    garage = {
        vehs = {
            {label = "4x4 K-9 Police departement", veh = "police6"},
            {label = "Dodge Chargeur", veh = "police2"},
            {label = "4x4 Cruiser", veh = "police3"},
            {label = "Maserati - VIR", veh = "ghispo2"},
            {label = "Porsche - VIR", veh = "pol718"},
        },
        pos  = {
            {pos = vector3(463.83975219727, -1017.2585449219, 28.050968170166), heading = 273.0},
            
          
        },
    },
}
