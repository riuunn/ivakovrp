ESX = nil

RegisterServerEvent('esx_taxijob:success')
AddEventHandler('esx_taxijob:success', function()
	math.randomseed(os.time())

	local xPlayer        = ESX.GetPlayerFromId(source)
	local total          = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max)
	local societyAccount = nil

	if xPlayer.job.grade >= 3 then
		total = total * 2
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_taxi', function(account)
		societyAccount = account
	end)

	if societyAccount ~= nil then

		local playerMoney  = math.floor(total / 100 * 30)
		local societyMoney = math.floor(total / 100 * 70)

		xPlayer.addMoney(playerMoney)
		societyAccount.addMoney(societyMoney)

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned', societyMoney, playerMoney))

	else
		xPlayer.addMoney(total)
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned', total))
	end

end)