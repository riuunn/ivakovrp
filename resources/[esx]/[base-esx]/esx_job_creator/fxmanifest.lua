version '4.6.3'

author 'jaksam1074'

client_scripts {
    -- Callbacks
    'callbacks/cl_callbacks.lua',

    -- Integrations
    'integrations/cl_integrations.lua',
    'integrations/sh_integrations.lua',

    -- Shared files
    'utils/sh_utils.lua',
    'locales/*.lua',

    -- Utils
    'utils/cl_utils.lua',
    
    -- Actual client files
    'client/actions/*.lua',
    'client/markers/*.lua',
    'client/functions.lua',
    'client/events.lua',
    'client/main.lua',
    'client/nui_callbacks.lua'
}

server_scripts {
    -- Dependency
    '@mysql-async/lib/MySQL.lua',
    
    -- Callbacks
    'callbacks/sv_callbacks.lua',
    
    -- Integrations
    'integrations/sv_integrations.lua',
    'integrations/sh_integrations.lua',

    -- Shared files
    'utils/sh_utils.lua',
    'locales/*.lua',
    
    -- Utils
    'utils/sv_utils.lua',
    
    -- Actual server files
    'server/code_integrator.lua',
    'server/functions.lua',
    'server/actions.lua',
    'server/markers/*.lua',
    'server/database.lua',
    'server/esx_callbacks.lua',
    'server/main.lua',
}

ui_page 'html/index.html'

files {
    'html/menu_translations/*.json',
    'html/index.html',
    'html/index.js',
    'html/index.css',
}

fx_version 'cerulean'
game 'gta5'

dependencies {
    'es_extended',
    'esx_skin',
    'esx_society',
    'esx_addonaccount',
    'esx_addoninventory',
    'esx_datastore',
    '/onesync',
    '/server:4752'
}

lua54 'yes' 

escrow_ignore {
    -- Config files
    "default_config.json",
    "current_config.json",

    -- SQL File
    "sql/esx_job_creator.sql",

    -- Integration files
    "integrations/*.lua",

    -- Locales
    "locales/*.lua",

    -- Exceptions 
    "client/actions/actions.lua",
    "client/markers/garage_owned.lua",
    "server/markers/garage_owned.lua",
}