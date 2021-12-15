ESX = nil

Citizen.CreateThread(function()

    while ESX == nil do

        TriggerEvent('esx:getSharedObject', function(obj)

            ESX = obj

        end)

        Citizen.Wait(0)

    end



    while ESX.GetPlayerData().job == nil do

        Citizen.Wait(300) -- does not need to spam lmao

    end

    ESX.PlayerData = ESX.GetPlayerData()

end)



local toghud = true



local og_toggle_hud = false



RegisterNetEvent('trp:core:toggleHud')

AddEventHandler('trp:core:toggleHud', function()

    if not og_toggle_hud then

        og_toggle_hud = true

        SendNUIMessage({

			action = "togglehud",

			show = false

		})

    else

        og_toggle_hud = false

        SendNUIMessage({

			action = "togglehud",

			show = true

		})

    end

end)



Citizen.CreateThread(function()

    while true do

        if not og_toggle_hud then

            TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)

                TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)

                    local myhunger = hunger.getPercent()

                    local mythirst = thirst.getPercent()



                    SendNUIMessage({

                        action = "updateStatusHud",

                        show = toghud,

                        hunger = myhunger,

                        thirst = mythirst,

                        stress = mystress,

                    })

                end)

            end)

        end

        Citizen.Wait(5000)

    end

end)



local numbah = 10



RegisterNetEvent("trp:core:setOxyLevel")

AddEventHandler("trp:core:setOxyLevel", function(newMax)

	numbah = newMax

end)



Citizen.CreateThread(function()
local sleep = 500 
    while true do

        Citizen.Wait(sleep)

        if not og_toggle_hud then
 sleep = 100
            local player = PlayerPedId()

            local health = (GetEntityHealth(player) - 100)

            local armor = GetPedArmour(player)

            local oxy = ESX.Math.Round((GetPlayerUnderwaterTimeRemaining(PlayerId())/numbah)*100)

    		local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId())



            SendNUIMessage({

                action = 'updateStatusHud',

                show = toghud,

                health = health,

                armour = armor,

                oxygen = oxy,

                stress = stamina,

            })

        end

        sleep = 500

    end

end)



--[[

Citizen.CreateThread(function()



	while true do



		Citizen.Wait(1000)



		local directions = { [0] = 'updateHeadingNorth', [45] = 'updateHeadingNorthWest', [90] = 'updateHeadingWest', [135] = 'updateHeadingSouthWest', [180] = 'updateHeadingSouth', [225] = 'updateHeadingSouthEast', [270] = 'updateHeadingEast', [315] = 'updateHeadingNorthEast', [360] = 'updateHeadingNorth', }



		for k,v in pairs(directions)do

			direction = GetEntityHeading(PlayerPedId())

			if(math.abs(direction - k) < 22.5)then

				direction = v

				break

			end

		end



		SendNUIMessage({action = direction})

	end

end)]]

