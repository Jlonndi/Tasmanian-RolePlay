local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
 }
function Draw3DText(x, y, z, text, scale)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local pX, pY, pZ = table.unpack(GetGameplayCamCoord())
  SetTextScale(scale, scale)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextEntry("STRING")
  SetTextCentre(true)
  SetTextColour(255, 255, 255, 215)
  AddTextComponentString(text)
  DrawText(_x, _y)
  local factor = (string.len(text)) / 700
  DrawRect(_x, _y + 0.0150, 0.10 + factor, 0.03, 41, 11, 41, 100)
end

--Citizen.CreateThread(function()
   -- local sleep = 500
     -- while true do
      -- Citizen.Wait(sleep)
        --  local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        --  local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 280.6681, -964.3648, 29.41467)
         -- if IsControlPressed(0, Keys['LEFTALT']) then
          --if dist <= 3 then
           -- sleep = 0
            --  if dist <= 2 then 
             -- Draw3DText(280.6681,-964.3648, 29.41467+0.4, "~y~Glass Door", 0.4)
          -- end
      -- end
      --end
  --end
--end)
--Citizen.CreateThread(function()
--  local sleep = 500
  --  while true do
  --   Citizen.Wait(sleep)
    --    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    --    local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 278.611, -960.2374, 29.38098)
     --   if IsControlPressed(0, Keys['LEFTALT']) then
      --  if dist <= 3 then
       --   sleep = 0
        --    if dist <= 2 then 
         --   Draw3DText(278.611, -960.2374, 29.38098+0.5, "~y~Tree", 0.4)
        -- end
     --end
    --end
--end
--end)
Citizen.CreateThread(function() -- chair 1
  local sleep = 500
    while true do
     Citizen.Wait(sleep)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 279.6791, -958.9583, 29.86963)
        if IsControlPressed(0, Keys['LEFTALT']) then
        if dist <= 3 then
          sleep = 0
            if dist <= 2 then 
            Draw3DText(279.6791, -958.9583, 29.86963-0.4, "~y~Chair", 0.4)
         end
     end
    end
end
end)
Citizen.CreateThread(function() -- chair 2
  local sleep = 500
    while true do
     Citizen.Wait(sleep)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 281.1824, -960.6594, 29.986963)
        if IsControlPressed(0, Keys['LEFTALT']) then
        if dist <= 3 then
          sleep = 0
            if dist <= 2 then 
            Draw3DText(281.1824, -960.6594, 29.86963-0.4, "~y~Chair", 0.4)
         end
     end
    end
end
end)
Citizen.CreateThread(function() -- chair 3
  local sleep = 500
    while true do
     Citizen.Wait(sleep)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 282.8835, -958.9846, 29.85278)
        if IsControlPressed(0, Keys['LEFTALT']) then
        if dist <= 3 then
          sleep = 0
            if dist <= 2 then 
            Draw3DText(282.8835, -958.9846, 29.85278-0.4, "~y~Chair", 0.4)
         end
     end
    end
end
end)
--Citizen.CreateThread(function() --table 1
--  local sleep = 500
 --   while true do
  --   Citizen.Wait(sleep)
     --   local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
      --  local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 281.4066, -959.1693, 29.85278)
     --   if IsControlPressed(0, Keys['LEFTALT']) then
      --  if dist <= 2 then
      --    sleep = 0
       --     if dist <= 1.5 then 
       --     Draw3DText(281.4066, -959.1693, 29.85278-0.2, "~y~Table", 0.4)
    --  --   end
   --  end
--  --  end
-- end
--end)         
  Citizen.CreateThread(function() --refrigerator for offduty/civs
      local sleep = 500
        while true do
         Citizen.Wait(sleep)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 279.4945, -971.8945, 29.41467)
            if IsControlPressed(0, Keys['LEFTALT']) then
              if dist <= 3 then
              sleep = 0
                if dist <= 2 then 
                Draw3DText(279.4945, -971.8945, 29.41467+0.7, "~y~Refrigerator", 0.4)
             end
         end
        end
    end
  end)
  --Citizen.CreateThread(function() --Painting
    --  local sleep = 500
    --    while true do
     --    Citizen.Wait(sleep)
     --       local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
      --      local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 283.9517, -968.0308, 30.15601)
      --      if IsControlPressed(0, Keys['LEFTALT']) then
      --        if dist <= 3 then
      --        sleep = 0
      --          if dist <= 2 then 
       --         Draw3DText(283.9517, -968.0308, 30.15601+0.7, "~y~Painting", 0.4)
      --       end
      --   end
   --   --  end
   -- end
 -- end)
 -- Citizen.CreateThread(function() --Outside Plant
    --  local sleep = 500
     --   while true do
      --   Citizen.Wait(sleep)
         --   local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
         --   local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 282.9363, -964.0483, 30.61096)
         --   if IsControlPressed(0, Keys['LEFTALT']) then
         --     if dist <= 3 then
         --     sleep = 0
         --       if dist <= 2 then 
        --        Draw3DText(282.9363, -964.0483, 30.61096-0.5, "~y~Shrubs", 0.4)
        --     end
      --   end
    --  --  end
   -- end
 -- end)
  Citizen.CreateThread(function() --inside chair 
      local sleep = 500
        while true do
         Citizen.Wait(sleep)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 279.5868, -966.422, 29.86963)
            if IsControlPressed(0, Keys['LEFTALT']) then
              if dist <= 3 then
              sleep = 0
                if dist <= 2 then 
                Draw3DText(279.5868, -966.422, 29.86963-0.5, "~y~Couch", 0.4)
             end
         end
        end
    end
  end)
  --Citizen.CreateThread(function() --inside table
     -- local sleep = 500
      --  while true do
         --Citizen.Wait(sleep)
         --   local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
         --   local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 279.8901, -967.7275, 29.88647)
         --   if IsControlPressed(0, Keys['LEFTALT']) then
        --      if dist <= 3 then
        --      sleep = 0
        --        if dist <= 2 then 
        --        Draw3DText(279.8901, -967.7275, 29.88647-0.5, "~y~Large Table", 0.4)
        --     end
       --  end
    --  --  end
   -- end
--  end)
  Citizen.CreateThread(function() --inside chair2
      local sleep = 500
        while true do
         Citizen.Wait(sleep)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 279.4813, -969.0725, 29.86963)
            if IsControlPressed(0, Keys['LEFTALT']) then
              if dist <= 3 then
              sleep = 0
                if dist <= 2 then 
                Draw3DText(279.4813, -969.0725, 29.86963-0.5, "~y~Couch", 0.4)
             end
         end
        end
    end
  end)
  Citizen.CreateThread(function() --inside chair3
      local sleep = 500
        while true do
         Citizen.Wait(sleep)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 283.1868, -964.9714, 29.86963)
            if IsControlPressed(0, Keys['LEFTALT']) then
              if dist <= 3 then
              sleep = 0
                if dist <= 2 then 
                Draw3DText(283.1868, -964.9714, 29.86963-0.5, "~y~Couch", 0.4)
             end
         end
        end
    end
  end)
  --Citizen.CreateThread(function() --inside table2
     -- local sleep = 500
       -- while true do
        -- Citizen.Wait(sleep)
            --local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            --local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 283.0286, -966.356, 29.88647)
            --if IsControlPressed(0, Keys['LEFTALT']) then
            --  if dist <= 3 then
             -- sleep = 0
             --   if dist <= 2 then 
                Draw3DText(283.0286, -966.356, 29.88647-0.5, "~y~Large Table", 0.4)
             --end
         --end
       -- end
    --end
  --end)
  Citizen.CreateThread(function() --inside chair4
      local sleep = 500
        while true do
         Citizen.Wait(sleep)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 283.3319, -967.556, 29.86963)
            if IsControlPressed(0, Keys['LEFTALT']) then
              if dist <= 3 then
              sleep = 0
                if dist <= 2 then 
                Draw3DText(283.3319, -967.556, 29.86963-0.5, "~y~Couch", 0.4)
             end
         end
        end
    end
  end)
  Citizen.CreateThread(function() --inside chair5
      local sleep = 500
        while true do
         Citizen.Wait(sleep)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 283.1472, -968.5978, 29.86963)
            if IsControlPressed(0, Keys['LEFTALT']) then
              if dist <= 3 then
              sleep = 0
                if dist <= 2 then 
                Draw3DText(283.1472, -968.5978, 29.86963-0.5, "~y~Couch", 0.4)
             end
         end
        end
    end
  end)
 --Citizen.CreateThread(function() --inside table3
    --local sleep = 500
       -- while true do
        -- Citizen.Wait(sleep)
         --   local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
           -- local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 283.0417, -969.8373, 29.88647)
            --if IsControlPressed(0, Keys['LEFTALT']) then
             -- if dist <= 3 then
             -- sleep = 0
              --  if dist <= 2 then 
             -- -  Draw3DText(283.0417, -969.8373, 29.88647-0.5, "~y~Large Table", 0.4)
             --end
         --end
        --end
    --end
  
--end)
  Citizen.CreateThread(function() --inside chair6
      local sleep = 500
        while true do
         Citizen.Wait(sleep)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 283.3846, -971.1693, 29.86963)
            if IsControlPressed(0, Keys['LEFTALT']) then
              if dist <= 3 then
              sleep = 0
                if dist <= 2 then 
                Draw3DText(283.3846, -971.1693, 29.86963-0.5, "~y~Couch", 0.4)
             end
         end
        end
    end
  end)
 
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
 
 -- Citizen.CreateThread(function() --cash register steal function 
   --   local sleep = 500
    --  while true do
      --   Citizen.Wait(sleep)
        ----    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
           -- local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, 280.9055, -972.6857, 30.67834)
           -- if IsControlPressed(0, Keys['LEFTALT']) then
             -- if dist <= 3 then
             -- sleep = 0
              --  if dist <= 2 then 
                --  Draw3DText(280.9055, -972.6857, 30.67834-0.6, "~y~Cash Register ~w~ Press ~g~E~w~ To ~r~ Rob Cash Register", 0.4)
                  --if IsControlJustPressed(0, Keys['E']) then 
                  --    isMakingCoffee = false
                   --   TriggerServerEvent('BaristaRobRegister')
                  --TriggerEvent('CoffeeMakeAnimation2')
                 -- Citizen.Wait(15000)
                 -- isMakingCoffee = false
                 -- Citizen.Wait(500000)
               -- end
              --end
       -- end
     -- end
      --end
 -- end)
