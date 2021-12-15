------------------------------------------------------------------
--                 ESX SECTION CHECK IF JOB EXIST?              --
------------------------------------------------------------------
local CurrentActionData, handcuffTimer, dragStatus, blipsCops, currentTask = {}, {}, {}, {}, {}

ESX								= nil
PlayerData = {}
isCuffed = false
isDead = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
	end
  Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:setJob')

AddEventHandler('esx:setJob', function(job)

  	PlayerData.job = job

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    PlayerData = playerData
end)


local showMenu = false      

local playing_emote = false

local handsup = false

RegisterNetEvent('ishandsup')
AddEventHandler('ishandsup', function(RobPlayer, closestPlayer)
    if handsup then 
    TriggerServerEvent('canRob', closestPlayer, RobPlayer)
    print(RobPlayer)
    print(closestPlayer)
    else 
    TriggerServerEvent('cannotRob', RobPlayer)  
    end
end)
RegisterNetEvent('CannotRobPerson')
AddEventHandler('CannotRobPerson', function()
  TriggerEvent("pNotify:SendNotification",{

    text = "<h2>Notification</h2>" .. "<h1>SYSTEM:</h1><p>TipRat AlerT!!!!!</p>",
     
    type = "success",
     
    timeout = (5000),
     
    layout = "centerLeft",
     
    queue = "global"
     
  })
end)
RegisterNetEvent('RobPerson')
AddEventHandler('RobPerson', function(ClosestPlayer)
  OpenBodySearchMenuRob(ClosestPlayer)
end)


Citizen.CreateThread(function()
  local dict = "missminuteman_1ig_2"
RequestAnimDict(dict)
while not HasAnimDictLoaded(dict) do
  Citizen.Wait(100)
end
  handsup = false
while true do
  Citizen.Wait(0)
  if not isDead and not isCuffed then
    if IsControlJustPressed(1, 323) then
              if not IsPedInAnyVehicle(PlayerPedId()) then
          if not handsup then
                      if IsPedArmed(PlayerPedId(), 6) then
                          SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED" ,true)
                          Citizen.Wait(1000)
                      end
            TaskPlayAnim(PlayerPedId(), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
            handsup = true
            print(handsup)
          else
            handsup = false
            print(handsup)
            ClearPedTasks(PlayerPedId())
          end
              end
    end
  end
  end
end)


------------------------------------------------------------------
--                          Functions
------------------------------------------------------------------


function Crosshair(enable)

  SendNUIMessage({
    crosshair = enable
  })

end


function TimeToDoSomeSketchyShitDoDaDoDa() -- hides menu

  SendNUIMessage({menu = false})

  SetNuiFocus(false, false)

  Crosshair(false)

end


RegisterCommand("hidemenu", function(source, args, rawCommand)

TimeToDoSomeSketchyShitDoDaDoDa()

end)


RegisterNUICallback('disablenuifocus', function(data)

  showMenu = data.nuifocus

  SetNuiFocus(data.nuifocus, data.nuifocus)

	TransitionFromBlurred(500)

end)


-- TRP CUSTOM POST EVENTS BY CX


RegisterNUICallback('showid', function(data)
 
ESX.TriggerServerCallback("trp:core:getNames", function(Name)

TriggerServerEvent('showid1234', Name)

  end)
  
end)


RegisterNUICallback('showlicense', function(data)
  
  print('ShowLicense Debugging') -- prints ingame console command

end)


RegisterKeyMapping('interactionmenu', 'interactionmenu', 'keyboard', 'grave')


RegisterCommand("interactionmenu", function(source, args, rawCommand)

  if showMenu == true then

    TriggerEvent('TRP:HIDEMENU')

  else

  TriggerEvent('TRP:SHOWMENU')

  end

end)


RegisterNetEvent('TRP:SHOWMENU')

AddEventHandler('TRP:SHOWMENU', function()

  local Ped = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
  Crosshair(true)

    showMenu = true

    SetNuiFocus(true, true)

    SendNUIMessage({

      menu = 'user', -- menu is done in HTML / js with post events

      idEntity = 2 -- workaround forces a static entity general interaction menu Leave at 2 

    })

end)


RegisterNetEvent('TRP:HIDEMENU')

AddEventHandler('TRP:HIDEMENU', function()

  local Ped = PlayerPedId()

  SendNUIMessage({

    menu = false

  })

  Crosshair(false)

end)

RegisterNUICallback('mainmenu', function(data)

	playerPed = PlayerPedId()
	SetNuiFocus(false, false)
	SendNUIMessage({
	  menu = false
	})
	Crosshair(false)
	showMenu = false

	Crosshair(true)

	showMenu = true
	SetNuiFocus(true, true)
  SendNUIMessage({

    menu = 'user', -- menu is done in HTML / js with post events

    idEntity = 2 -- workaround forces a static entity general interaction menu Leave at 2 

  })

end)

RegisterNUICallback('jobmenu', function(data)
  if PlayerData.job.name == "police" then
    playerPed = PlayerPedId()
    SetNuiFocus(false, false)
    SendNUIMessage({
      menu = false
    })
    Crosshair(false)
    showMenu = false
    Crosshair(true)
    showMenu = true
    SetNuiFocus(true, true)
    SendNUIMessage({
      menu = 'police',

    })
  end
  if PlayerData.job.name == "ambulance" then
      playerPed = PlayerPedId()
      SetNuiFocus(false, false)
      SendNUIMessage({
        menu = false
      })
      Crosshair(false)
      showMenu = false
      Crosshair(true)
      showMenu = true
      SetNuiFocus(true, true)
      SendNUIMessage({
        menu = 'ambulance',
  
      })
  end
  if PlayerData.job.name == "barista" then
    --baristaBill
    playerPed = PlayerPedId()
    SetNuiFocus(false, false)
    SendNUIMessage({
      menu = false
    })
    Crosshair(false)
    showMenu = false
    Crosshair(true)
    showMenu = true
    SetNuiFocus(true, true)
    SendNUIMessage({
      menu = 'barista',

    })
  end
end)


-- Police Callbacks
RegisterNUICallback('carcontrols', function(data)

SendNUIMessage({

  menu = false

})

Crosshair(false)

showMenu = false
unfocusNUI()
Citizen.Wait(300) -- avoids fuckery <3 
TriggerEvent('TRP:CARCONTROL')
end)



RegisterNUICallback('baristaBill', function(data)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  if closestPlayer ~= -1 and closestDistance <= 3.0 then
  OpenBillingMenu(closestPlayer)
  unfocusNUI()
  else
  exports['mythic_notify']:SendAlert('error', 'No Players Nearby', 2500, { ['background-color'] = '#e62615', ['color'] = '#FFFFFF' }) -- cocks
  end
end)

function OpenBillingMenu()
  		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification(_U('no_players'))
				return
			end

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_coffee_sell_amount', {
				title = 'Invoice Amount'
			}, function(data2, menu2)
				local amount = tonumber(data2.value)

				if amount == nil then
					ESX.ShowNotification('Invalid Amount')
				else
					menu2.close()
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification('no Players Nearby')
					else
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_barista', 'Bean Machine Coffee', tonumber(data2.value))
					end
				end
			end, function(data2, menu2)
				menu2.close()
			end)
end
--  end

RegisterNUICallback('policeID', function(data)

  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

  if closestPlayer ~= -1 and closestDistance <= 2.0 then

  OpenIdentityCardMenu(closestPlayer)

  unfocusNUI()

  else
  
  exports['mythic_notify']:SendAlert('error', 'No Players Nearby', 2500, { ['background-color'] = '#e62615', ['color'] = '#FFFFFF' })

  end

end)

RegisterNUICallback('policeDrag', function(data)
TriggerEvent('TRP:DRAG')
end)
RegisterNUICallback('policePutVehicle', function(data)
TriggerEvent('TRP:PUTVEHICLE')
end)

RegisterNUICallback('policePullVehicle', function(data)
  TriggerEvent('TRP:PULLVEHICLE')
  end)
  

RegisterNUICallback('RobPlayer', function(data)

  if not isDead or not isCuffed or not handsup then

    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    
    if closestPlayer == -1 or closestPlayerDistance > 3.0 then
      
			TriggerEvent("pNotify:SendNotification",{

        text = "<h2>Notification</h2>" .. "<h1>SYSTEM:</h1><p>There are no players nearby.</p>",
        
        type = "success",
        
        timeout = (5000),
        
        layout = "centerLeft",
        
        queue = "global"
        
      })
      
    else
      
      if IsPedArmed(PlayerPedId(), 6) then
         TriggerServerEvent('CheckHandsUpRob', GetPlayerServerId(closestPlayer))
      --  OpenBodySearchMenu(closestPlayer) ---- IMPORTANT FUNCTION FOR ROB
          -- add event to trigger event on client
        
          unfocusNUI()
          SendNUIMessage({

            menu = false

          })

          Crosshair(false)

          showMenu = false

      else
        
				TriggerEvent("pNotify:SendNotification",{

          text = "<h2>Notification</h2>" .. "<h1>SYSTEM:</h1><p>You must be armed to rob someone!</p>",
          
          type = "success",
          
          timeout = (5000),
          
          layout = "centerLeft",
          
          queue = "global"
          
        })
        
      end
      
    end
    
	end
 
end)


RegisterNUICallback('policeBodySearch', function(data)
  
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

  if closestPlayer ~= -1 and closestDistance <= 2.0 then

    SendNUIMessage({
      menu = false
    })
    Crosshair(false)
    showMenu = false
    unfocusNUI()
Citizen.Wait(300)


  OpenBodySearchMenu(closestPlayer)
  else
  
  exports['mythic_notify']:SendAlert('error', 'No Players Nearby', 2500, { ['background-color'] = '#e62615', ['color'] = '#FFFFFF' })

  end

end)


RegisterNUICallback('policeFines', function(data) -- Open Police Fine Menu

  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

  if closestPlayer ~= -1 and closestDistance <= 2.0 then

  TriggerEvent('TRP:FineMenu', closestPlayer)
  --OpenFineMenu(closestPlayer)
  unfocusNUI()

  else
  
  exports['mythic_notify']:SendAlert('error', 'No Players Nearby', 2500, { ['background-color'] = '#e62615', ['color'] = '#FFFFFF' })

  end

end)


RegisterNUICallback('policeManageLicenses', function(data) -- check licenses code
  
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

  if closestPlayer ~= -1 and closestDistance <= 2.0 then

  ShowPlayerLicense(closestPlayer)

  unfocusNUI()

  else

  exports['mythic_notify']:SendAlert('error', 'No Players Nearby', 2500, { ['background-color'] = '#e62615', ['color'] = '#FFFFFF' })

  end

end)

RegisterNetEvent('TRP:DV')

AddEventHandler('TRP:DV', function()

local vehicle = ESX.Game.GetVehicleInDirection()

ImpoundVehicle(vehicle)

end)
RegisterNUICallback('policeDV', function(data) -- Police Impound

  local playerPed = PlayerPedId()

  local vehicle = ESX.Game.GetVehicleInDirection()
  
  unfocusNUI()

  TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

  exports['progressBars']:startUI(10000, "Impounding Vehicle")

  Citizen.Wait(10000)

  ClearPedTasks(playerPed)
TriggerEvent('esx:deleteVehicle', cockssss)
--

end)


RegisterNUICallback('policeJailSuspekt', function(data) -- Police Jail

  TriggerEvent("esx-qalle-jail:openJailMenu")
      
  unfocusNUI()

end)




function ShowPlayerLicense(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(playerData)
		if playerData.licenses then
			for i=1, #playerData.licenses, 1 do
				if playerData.licenses[i].label and playerData.licenses[i].type then
					table.insert(elements, {
						label = playerData.licenses[i].label,
						type = playerData.licenses[i].type
					})
				end
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
      title    = "Revoke License",
      align    = 'bottom-right',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification('licence_you_revoked', data.current.label, playerData.name)
			TriggerServerEvent('esx_policejob:message', GetPlayerServerId(player), 'license_revoked', data.current.label)

			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)

			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end


function unfocusNUI() -- global function for un-NUI focus

  SetNuiFocus(false, false)

  SendNUIMessage({

    menu = false

      })

        Crosshair(false)

          showMenu = false 
          
end


function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		title    = "Fines",
  align    = 'bottom-right',
		elements = {
      {label = 'Minor Traffic/Vehicle Offences', value = 0},
      {label = 'Serious Traffic/Vehicle Offences', value = 1},
      {label = 'Minor/Generic Offences', value = 2},
      {label = 'Weapon Offences', value = 3},
	}}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end


function OpenBodySearchMenu(player)
	TriggerEvent("trp_inventoryhud:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
end

function OpenBodySearchMenuRob(player)
	TriggerEvent("trp_inventoryhud:openPlayerInventory", player, '')
end

function OpenIdentityCardMenu(player)

	ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)

		local elements    = {}
		local nameLabel   = "Name: " .. data.name
		local jobLabel    = nil
		local sexLabel    = nil
		local dobLabel    = nil
		local heightLabel = nil
		local idLabel     = nil

		if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
			jobLabel = 'Job - ' .. data.job.label .. ' - ' .. data.job.grade_label
		else
			jobLabel = 'Job - ' .. data.job.label
		end



			nameLabel = "Name: " .. data.firstname .. ' ' .. data.lastname

			if data.sex ~= nil then
				if string.lower(data.sex) == 'm' then
					sexLabel = 'Sex - Male'
				else
					sexLabel = 'Sex - Female'
				end
			else
				sexLabel = 'Sex - Unknown'
			end

			if data.dob ~= nil then
				dobLabel = 'DOB - ' .. data.dob
			else
				dobLabel = 'DOB - Unknown'
			end

			if data.height ~= nil then
				heightLabel = 'Height - ' .. data.height
			else
				heightLabel = 'Height - Unknown'
			end

			if data.name ~= nil then
				idLabel = 'ID - ' .. data.name
			else
				idLabel = 'ID - Unknown'
			end



		local elements = {
			{label = nameLabel, value = nil},
			{label = jobLabel,  value = nil},
		}


			table.insert(elements, {label = sexLabel, value = nil})
			table.insert(elements, {label = dobLabel, value = nil})
			table.insert(elements, {label = heightLabel, value = nil})
			table.insert(elements, {label = idLabel, value = nil})


		if data.drunk ~= nil then
			table.insert(elements, {label = "BAC: " .. data.drunk, value = nil})
		end

		if data.licenses ~= nil then

			table.insert(elements, {label =' --- Licenses ---', value = nil})

			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label, value = nil})
			end

		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
		{
			title    = "Civilian Identification",
			align    = 'bottom-right',
			elements = elements,
		}, function(data, menu)

		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))

end

