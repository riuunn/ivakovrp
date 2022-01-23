fx_version 'bodacious'
games { 'gta5' }

author 'Amin1992#8211'


client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'client/main.lua',
	'config.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'server/server.lua',
	'config.lua'
}

ui_page('ui/ui.html')

files {
    'ui/ui.html',
    'ui/panel.css',
	'ui/panel.js',
	'ui/sound3.mp3',
	'ui/panel2.jpg'
}







