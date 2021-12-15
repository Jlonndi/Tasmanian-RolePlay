ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_moneywash:withdraw')
AddEventHandler('esx_moneywash:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	amount = tonumber(amount)
	local accountMoney = 0
	accountMoney = xPlayer.getInventoryItem('black_money').count
	if amount == nil or amount <= 0 or amount > accountMoney then
		TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
	else
		xPlayer.removeInventoryItem('black_money', amount)
		xPlayer.addInventoryItem('money', amount)
		TriggerClientEvent('esx:showNotification', _source, _U('wash_money') .. amount .. '~s~.')
		TriggerClientEvent('esx_moneywash:closeWASH', _source)
	end
end)