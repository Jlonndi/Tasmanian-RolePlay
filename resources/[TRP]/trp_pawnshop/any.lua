function wee(doom, fuck,) --Doom = notification text  Fuck = PlayerID 
    TriggerClientEvent('esx:showNotification', doom, fuck)
end

trp_pawnshop
local Item (ps5)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
If xPlayer.inventory >0 ps5 
then wee ('You dont have a ps5', xplayer.source)
    if xPlayer.Inventory <0 ps5
    then wee('you have a fucking ps5 cunt and its gone')
    end






function Text(doom, fuck, cunt, whore, bitch, slut, whale, bail) 
    --doom = notification text, fuck = PlayerID cunt = 

    -- Example OF A FUNCTION......

    --Lets say you have function Text(Message, Player)
    -- The function Text its self is definied by what you want it to be 
    -- example You could have it say function NUB or Function Goodbye and it will
    -- Still work in the exact same way, Explained more below... But before we continue with that
    -- The in bracket (Message, Player) can also be whatever you'd like example below
    -- function NUB(Different, Text) This function is the exact same as
    -- function Text(Message, Player) The thing that specifies that difference
    -- is the actual local used.... Example below
    --
    --function Text(message, Player)
    -- TriggerClientEvent('TRP:KillPlayer, 1')
    -- end
    -- TRP:KillPlayer
    -- local _source = source
    -- local xPlayer = ESX.GetPlayerFromId(_source)
    --
    -- The Local _source = source AND xPlayer = ESX.GetPlayerFromId(_source)
    -- Are what define the events inside the function being (Message, Player) 
    -- So Message would be local_source = source And
    -- Player would be local xPlayer = ESX.GetPlayerFromId(_source)
    -- And that's what defines the the functtion so again just to make sure
    -- you understand what is going on
    -- function Text(Message, Player) Can be function Nub (Different, Text) and it would
    -- work the same way Different would be local _source = source  and Text would be
    -- local xPlayer = ESX.GetPlayerFromId(_source)
    --- 
    -- So now lets trigger a full function using what we have read above
    -- we will do one with callouts that are obvious and understandable so we 
    -- dont get lost at first but then we will do one thats custom--
    -- lets start with the locals first --
    -- local _source = source
    -- local xPlayer = ESX.getPlayerFromId(_source)
    -- function Text(Message, Player)
    -- TriggerClientEvent(add:chat, Message, Player)
    --  Message('This is Our message that will be broadcasted')
    -- end 
    --- so what we just did was made a function which was "function Text(Message, Player)"
    --  and then we added that to the end of our TriggerClientEvent 
    -- and then we ran the Message('This is Our message that will be broadcasted') which
    -- used the TriggerClientEvent(add:chat) to broadcast to the chat through the 
    -- Message function we had  
    -- Now we will do one thats with different lettering for the function
    -- that will do the exact same thing as the last example
    -- local _source = source
    -- local xPlayer = ESX.getPlayerFromId(_source)
    -- function Boom(Sexy, Time)
    -- TriggerClientEvent(add:chat, Sexy, Time)
    -- Sexy('This Is Our Message That Will be Broadcasted')
    -- end
    -- So that's how you make and define and use functions!!!!






















































RegisterServerEvent('esx_pawnshop:sellps5')
AddEventHandler('esx_pawnshop:sellps5', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local ps5 = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "ps5" then
			ps5 = item.count
		end
	end
    if ps5 > 0 then
        xPlayer.removeInventoryItem('ps5', 1)
        xPlayer.addInventoryItem('money', 2000)
		weedzie('You sold a ps5....')
	else 
		weedzie('you dont have another ps5 to sell')
    end
end)
---- function acts as a fucking notification so function notification can be function dickhead and it will be the same
function weedzie(text)
    
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    TriggerClientEvent('esx:showNotification', xPlayer.source, text)
end

































RegisterServerEvent('esx_pawnshop:sellgta5')
AddEventHandler('esx_pawnshop:sellgta5', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local gta5 = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "gta5" then
			gta5 = item.count
		end
	end
    
    if gta5 > 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You dont have any gta5')
        xPlayer.removeInventoryItem('gta5', 1)
        xPlayer.addInventoryItem('money', 150)
    else 
     NubAndCx('sold ps5', xPlayer.source)
        --  TriggerClientEvent('esx:showNotification', xPlayer.source, 'You sold a gta5')
    end
end)

function NubAndCx(ThisISText, player)
    TriggerClientEvent('esx:showNotification', player, ThisISText)
end















function WeeWoo(ThisIsNotification, player)
 ('sold a ps5')
    TriggerClientEvent('esx:showNotification',ThisIsNotification, player)
    ('You dont have another ps5')