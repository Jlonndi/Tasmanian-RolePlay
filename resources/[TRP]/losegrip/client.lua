

local ragdoll_chance = 0.32 -- edit this decimal value for chance of falling (e.g. 80% = 0.8    75% = 0.75    32% = 0.32)



-- code, not recommended to edit below this point

print('Fallover Nerd: ' .. ragdoll_chance)

Citizen.CreateThread(function()

	while true do

		Citizen.Wait(80) 

		local ped = PlayerPedId()

		if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then

			local chance_result = math.random()

			if chance_result < ragdoll_chance then 

				Citizen.Wait(600) -- roughly when the ped loses grip

                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05) -- change this float to increase/decrease camera shake

				SetPedToRagdoll(ped, 5000, 1, 2)

			else

				Citizen.Wait(1500) -- 1.5 seconds to stand up

			end

		end

	end

end)



-- v0.1