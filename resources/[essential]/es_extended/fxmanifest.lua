fx_version 'adamant'
game 'gta5'

ui_page 'html/ui.html'

client_scripts {
	'locale.lua',
	'locales/fr.lua',
	'config.lua',
	'config.weapons.lua',
	'client/common.lua',
	'client/entityiter.lua',
	'client/functions.lua',
	'client/wrapper.lua',
	'client/main.lua',
	'client/modules/death.lua',
	'client/modules/scaleform.lua',
	'client/modules/streaming.lua',
	'common/modules/math.lua',
	'common/modules/table.lua',
	'client/mapping/client.lua',
	'common/functions.lua'
}

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'locale.lua',
	'locales/fr.lua',
	'config.lua',
	'config.weapons.lua',
	'server/common.lua',
	'server/classes/player.lua',
	'server/functions.lua',
	'server/paycheck.lua',
	'server/main.lua',
	'server/commands.lua',
	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua'
}


exports 'getSharedObject'

server_exports 'getSharedObject'

dependencies {
	'mysql-async',
	'essentialmode',
	'esplugin_mysql',
	'async'
}