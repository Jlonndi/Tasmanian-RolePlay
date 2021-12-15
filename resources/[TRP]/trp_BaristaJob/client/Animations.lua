RegisterNetEvent('CoffeeMakeAnimation')
AddEventHandler('CoffeeMakeAnimation', function()
    isMakingCoffee = false 
    isMakingCoffee = true
    loadAnimDict('anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal')
    controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = true,
        disableCombat = true,
    }
    while isMakingCoffee do
     if not IsEntityPlayingAnim(PlayerPedId(), 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal', 'pour_one', 8.0, -8,3750, 2, 0, 0, 0, 0) then
      TaskPlayAnim(PlayerPedId(), 'anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal', 'pour_one', 8.0, -8,3750, 2, 0, 0, 0, 0)
      Citizen.Wait(3500)
      ClearPedTasks(PlayerPedId())
     end
     Citizen.Wait(1)
    end
    ClearPedTasks(PlayerPedId())
   end)
   
   function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
     Citizen.Wait(5)
    end
   end
   
RegisterNetEvent('CoffeeMakeAnimation2')
AddEventHandler('CoffeeMakeAnimation2', function()
      isMakingCoffee = false 
      isMakingCoffee = true
      loadAnimDict('oddjobs@shop_robbery@rob_till')
      controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = true,
          disableCombat = true,
      }
      while isMakingCoffee do
          if not IsEntityPlayingAnim(PlayerPedId(), "oddjobs@shop_robbery@rob_till", "enter", 3) then
              TaskPlayAnim(PlayerPedId(), "oddjobs@shop_robbery@rob_till", "enter", 0.5, 0.5, 2.0, 2, 2.0, 0, 0, 0)
        Citizen.Wait(3000)
        ClearPedTasks(PlayerPedId())
       end
       Citizen.Wait(1)
      end
      ClearPedTasks(PlayerPedId())
     end)
     
     function loadAnimDict(dict)
      RequestAnimDict(dict)
      while not HasAnimDictLoaded(dict) do
       Citizen.Wait(5)
      end
     end