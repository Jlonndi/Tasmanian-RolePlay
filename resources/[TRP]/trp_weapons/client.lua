--[[       
####	Title:          	Weaponry - Realistic Gunplay
####	Description:     	FiveM Script that adds Recoil to weapons, ability to toggle the reticle 
####						and removes ammo from the hud
####
####	URL:				https://forum.fivem.net/t/weaponry-realistic-gunplay-recoil-no-ammo-hud-no-reticle/				
####	Author:		 		Lyrad
####	Release date:       15th of July, 2018.
####	Update date:		28th of June, 2019.
####	Contributors:		AdrineX and Spudgun
####	Version:        	v1.3  
]]--

----------------------------------------------------------------------------
--DANO CORONHADA //// PISTOL WHIPPING
----------------------------------------------------------------------------
Citizen.CreateThread(function()
	local sleep = 500
    while true do
        Citizen.Wait(sleep)
	local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
			sleep = 0
	       DisableControlAction(1, 140, true)
       	   DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
		else 
			sleep = 500
        end
    end
end)
local global_wait 		= 300 			-- Don't change this
local disable_reticle 	= true			-- Change this to false if you want a reticle
local camera_shake 		= 0.00			-- Set this between 0.0-1.0 
local scopedWeapons 	= {				-- Scoped weapons (Add's reticle back for them)
	100416529, 205991906, 177293209, 3342088282, -952879014 
}

function HashInTable(hash)
    for k, v in pairs(scopedWeapons) do 
        if (hash == v) then 
            return true 
        end 
    end 

    return false 
end 
--[[-----------------------------------------------------------------------|
Made by Cheleber - Hope you Enjoy
If you need my help or wanna help me, here is my Discord: https://discord.gg/HjrRg8N
--]]-----------------------------------------------------------------------|


local shot = false
local check = false
local check2 = false
local count = 0

Citizen.CreateThread(function()
	local sleep = 500
	while true do
		SetBlackout(false)
		Citizen.Wait(sleep)
		if IsPlayerFreeAiming(PlayerId()) then
		    if GetFollowPedCamViewMode() == 4 and check == false then
				sleep = 1
			    check = false
			else
			    SetFollowPedCamViewMode(4)
				sleep = 1
			    check = true
			end
		else
		    if check == true then
				sleep = 500
		        SetFollowPedCamViewMode(1)
				check = false
			end
		end
	end
end )



Citizen.CreateThread(function()
	local sleep = 500
	while true do
		SetBlackout(false)
		Citizen.Wait(sleep)
		
		if IsPedShooting(PlayerPedId()) and shot == false and GetFollowPedCamViewMode() ~= 4 then
			sleep = 1
			check2 = true
			shot = true
			SetFollowPedCamViewMode(4)
		end
		
		if IsPedShooting(PlayerPedId()) and shot == true and GetFollowPedCamViewMode() == 4 then
			sleep = 1
			count = 0
		end
		
		if not IsPedShooting(PlayerPedId()) and shot == true then
			sleep = 1
		    count = count + 1
		end

        if not IsPedShooting(PlayerPedId()) and shot == true then
			if not IsPedShooting(PlayerPedId()) and shot == true and count > 20 then
		        if check2 == true then
					sleep = 500
				    check2 = false
					shot = false
					SetFollowPedCamViewMode(1)
				end
			end
		end	    
	end
end )

function ManageReticle(i)
    local k, v = GetCurrentPedWeapon(i, true)
    if not HashInTable(v) then 
       HideHudComponentThisFrame(14)
	end 
end


local recoils = {
	-- Pistols
	[453432689] 		= 0.1, 		-- PISTOL
	[-1075685676] 		= 0.12, 		-- PISTOL MK2
	[1593441988] 		= 0.05, 		-- COMBAT PISTOL
	[-1716589765] 		= 0.1, 		-- PISTOL .50
	[-1076751822] 		= 0.05, 		-- SNS PISTOL
	[2009644972] 		= 0.1, 	-- SNS PISTOL MK2
	[-771403250] 		= 0.2, 		-- HEAVY PISTOL
	[137902532] 		= 0.14, 		-- VINTAGE PISTOL
	[-598887786] 		= 0.2, 		-- MARKSMAN PISTOL
	[-1045183535] 		= 0.1, 		-- HEAVY REVOLVER
	[-879347409] 		= 0.125, 	-- HEAVY REVOLVER MK2
	[584646201] 		= 0.1, 		-- AP PISTOL
	[911657153]			= 0.05, 	-- STUN GUN
	[1198879012] 		= 0.1, 		-- FLARE GUN

	-- Small Machine Guns (SMG)
	[324215364] 		= 0.12, 		-- MICRO SMG
	[-619010992] 		= 0.05, 		-- MACHINE PISTOL
	[-1121678507]		= 0.03,		-- MINI SMG
	[736523883] 		= 0.02, 		-- SMG
	[2024373456] 		= 0.02,		-- SMG MK2
	[-270015777] 		= 0.05,		-- ASSAULT SMG
	[171789620] 		= 0.06, 		-- COMBAT PDW
	[-1660422300] 		= 0.05, 	-- MG
	[2144741730] 		= 0.15, 	-- COMBAT MG
	[-608341376] 		= 0.15, 	-- COMBAT MG MK2
	[1627465347] 		= 0.2, 		-- GUSENBERG

	-- Assault Rifles (AR)
	[-1074790547] 		= 0.08, 		-- ASSAULT RIFLE
	[961495388]			= 0.08,		 -- ASSAULT RIFLE MK2
	[-2084633992] 		= 0.00001, 		-- CARBINE RIFLE 		
	[-86904375] 		= 0.08, 		-- CARBINE RIFLE MK2
	[-1357824103]		= 0.08, 		-- ADVANCED RIFLE
	[-1063057011] 		= 0.08, 		-- SPECIAL CARBINE
	[-1768145561]		= 0.08, 	-- SPECIAL CARBINE MK2
	[2132975508] 		= 0.08, 		-- BULLPUP RIFLE
	[-2066285827]		= 0.08,		 -- BULLPUP RIFLE MK2
	[1649403952] 		= 0.08, 		-- COMPACT RIFLE

	--- Snipers
	[100416529] 		= 0.5, 		-- SNIPER RIFLE
	[205991906] 		= 0.7, 		-- HEAVY SNIPER
	[177293209] 		= 0.7,		-- HEAVY SNIPER MK2
	[3342088282]		= 0.3, 		-- MARKSMAN RIFLE
	[-952879014] 		= 0.35, 	-- MARKSMAN RIFLE MK2

	--- Shotguns
	[487013001] 		= 0.4, 		-- PUMP SHOTGUN
	[1432025498] 		= 0.4, 		-- PUMP SHOTGUN MK2
	[2017895192] 		= 0.7, 		-- SAWNOFF SHOTGUN
	[-1654528753] 		= 0.2, 		-- BULLPUP SHOTGUN
	[-494615257] 		= 0.4, 		-- ASSAULT SHOTGUN
	[-1466123874] 		= 0.7, 		-- MUSKET
	[984333226] 		= 0.4, 		-- HEAVY SHOTGUN
	[4019527611] 		= 2.1, 		-- DOUBLE BARREL SHOTGUN
	[317205821]			= 0.7,		-- SWEEPER SHOTGUN

	--- BIG BANG! MUCH WOW!
	[-1568386805]		= 0.5,		-- GRENADE LAUNCHER
	[1305664598] 		= 1.0, 		-- GRENADE LAUNCHER SMOKE (Unsure if this is the right hash?)
	[-1312131151] 		= 0.2, 		-- RPG
	[1119849093] 		= 0.00001, 	-- MINIGUN
	[2138347493] 		= 0.2, 		-- FIREWORK LAUNCHER
	[1834241177] 		= 1.2, 		-- RAILGUN
	[1672152130] 		= 0.2, 		-- HOMING LAUNCHER
	[125959754] 		= 0.5, 		-- COMPACT GRENADE LAUNCHER	
}

Citizen.CreateThread(function()
	local wait = global_wait
	while true do
		Citizen.Wait(wait)
		local ped = PlayerPedId()
		if IsPedArmed(PlayerPedId(), 6) then
			wait = 0
				ManageReticle(ped)
		
		else
			wait = global_wait
		end
	end
end)