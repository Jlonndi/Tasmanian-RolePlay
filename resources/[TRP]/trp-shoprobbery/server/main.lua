local ESX

local cachedData = {}
local label = [[
                    #####
                  #########
                 ###########
                #############
               ###############
               ###############
               ###############
               ###############
                #############
                 ###########
     #####        ###########\
   ########        ############\
  ##########     ########     ##\
 ############   #########      # \
############## #########          |
########################      \   \
########################      o  o\\
########################     oo\ oo |    /###\
 ########################     oo  o |   /#`####
 ########################    \oo \o\ \__##`####
  ########## #####    ###     oo  oo /  #######
   ########  ###        ##  /~\o  \//   ######/
    #####    ##          #      \ /     \####/
             ##                            |
             ##    /\~~\                   |
              #    | \                     |
              #    |  \                   |
               |       \                 |
              ####      #               |
             ######     ###           |~
             #######   xxx##       / ~
             #########  xxxxx####/~
              ########  xxxxxx##\
              ######\##  xxxxx#  \
               ######\##       ###\
               #######\###    #####\
                #######|#######(((((((
                #######\####))))))))))))
                 #######\##))))))))))88)))
                  #######))))))8888))8888)))
                  ######)))))))88888))888))))
                   #####))))))))8888)))88)))))
                   ####..))))))))88)))))))))))
                    ##...)))))))))))))))))))))
                    ##...)))))))))))))))))))))
                    #...))))))))))))))))))))))
                    #...))))))))))))))))))))))
                    ).)))))))))))))))))))))))
                     )--/)))))))))))))))))))
                      ))))))))))))))))))))#
                      ))))))))))))  ))))###
                        )))))))))     ####
                         #####  #    #####
                        #####   #    #####
                        #####   #    #####
                       ######   #    #####
                       #####   #     ####
                      ######   #    #####
                      #####    #    #####
        /9999\    /99######   #   99####99
       99999999999|99#####9   #  999###99999
      9999999\99999\999##999 #   99999999999-999
     999999999-99999\-99999##  999999999999/999999
    99999999999\--9999999999   9999999999/-999999999
    99999999999999\999999999  9999999999/999999999999
    99999999999999999999999     999999999999999999999
      9999999999999999999         999999999999999999
        999999999999999             99999999999999
        Mickey Mouse Is TRP's Guardian! ]]
                        print(label)
TriggerEvent("esx:getSharedObject", function(obj) 
	ESX = obj 
end)

MySQL.ready(function()
	Citizen.Wait(500)

	local players = ESX.GetPlayers()

	if #players > 0 then
		TriggerClientEvent("TRP:core:StoreRobbery:eventHandler", players[1], "create_clerks")

		while not cachedData["networkedClerks"] do
			Citizen.Wait(0)
		end

		TriggerClientEvent("TRP:core:StoreRobbery:eventHandler", -1, "update_clerks", cachedData["networkedClerks"])
	end
end)

RegisterServerEvent("TRP:core:StoreRobbery:globalEvent")
AddEventHandler("TRP:core:StoreRobbery:globalEvent", function(options)
    TriggerClientEvent("TRP:core:StoreRobbery:eventHandler", -1, options["event"] or "none", options["data"] or nil)
end)

RegisterServerEvent("TRP:core:StoreRobbery:receiveBagmoney")
AddEventHandler("TRP:core:StoreRobbery:receiveBagmoney", function(cashAmount)	
	local player = ESX.GetPlayerFromId(source)
		if player then
		print('hi')
    if cashAmount > 800 then 
      print('hemust be cheating bruh')
    end
    if cashAmount < 800 then 
			player.addInventoryItem('money', cashAmount)
		print('yashouldberichnow')
		TriggerClientEvent("esx:showNotification", source, "You grabbed $" .. cashAmount .. ", added to your pocket.")
    end
	end
end)

ESX.RegisterServerCallback("TRP:core:StoreRobbery:createClerks", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if player then
		local players = ESX.GetPlayers()

		if #players > 0 then
			callback(true)
		elseif cachedData["networkedClerks"] then
			callback(cachedData["networkedClerks"])
		else
			callback(true)
		end
	else
		callback(false)
	end
end)

ESX.RegisterServerCallback("TRP:core:StoreRobbery:updateClerks", function(source, callback, networkedClerks)
	local player = ESX.GetPlayerFromId(source)

	if player then
		if networkedClerks then
			cachedData["networkedClerks"] = networkedClerks

			callback(true)
		else
			callback(false)
		end
	else
		callback(false)
	end
end)