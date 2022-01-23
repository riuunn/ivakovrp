fx_version 'cerulean'
game 'gta5'

author 'jaksam1074'

version '4.5'

client_scripts {
    'callbacks/cl_callbacks.lua',

    -- Integrations
    'integrations/sh_integrations.lua',
    'integrations/cl_integrations.lua',

    'utils/sh_utils.lua',
    'utils/cl_utils.lua',

    'locales/*.lua',

    'client/boat_selling.lua',
    'client/plane_selling.lua',
    'client/npc_selling.lua',

    'client/main.lua',
    'client/drugs_effects.lua',
    'client/narcos.lua',
    'client/pushers.lua',

    'client/harvestable_items.lua',
    'client/interaction_points.lua',
    'client/crafting_recipes.lua',
    'client/laboratories.lua',
    'client/fields.lua'
}

server_scripts{
    '@mysql-async/lib/MySQL.lua',

    'callbacks/sv_callbacks.lua',

    -- Integrations
    'integrations/sh_integrations.lua',
    'integrations/sv_integrations.lua',

    'utils/sh_utils.lua',
    'utils/sv_utils.lua',

    'locales/*.lua',
    
    'server/database.lua',
    'server/main.lua',
    'server/drugs_effects.lua',
    'server/police.lua',
    
    'server/harvestable_items.lua',
    'server/crafting_recipes.lua',
    'server/laboratories.lua',
    'server/fields.lua',

    -- Sellings
    'server/plane_selling.lua',
    'server/boat_selling.lua',
    'server/npc_selling.lua',
    'server/narcos.lua',
    'server/pushers.lua',
}

ui_page "html/index.html"

files {
    "html/index.html",
    "html/index.css",
    "html/index.js",
    "html/menu_translations/*.json"
}

lua54 "yes"

dependencies {
    'es_extended',
    '/server:4752',
    '/onesync'
}

escrow_ignore {
    "locales/*.lua",
    "integrations/*.lua"
}