TRP = nil
local PlayerData = {}
local hentaigirls = false
local fiddlemydiddle = nil

Citizen.CreateThread(function()
	while TRP == nil do
		TriggerEvent('esx:getSharedObject', function(obj) TRP = obj end)
		Citizen.Wait(0)
	end
	while PlayerData.job == nil do
		Citizen.Wait(1000)
		PlayerData = TRP.GetPlayerData()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function OpenRadioMenu()

	local elements = {}
		
	if PlayerData.job.name == 'police' then --If is police then he has the below frequencies
		table.insert(elements, { label = 'TASPD CITY', value = 1}) --Police
		table.insert(elements, { label = 'TASPD REGIONAL', value = 2}) --Police 2
		table.insert(elements, { label = 'EMS COMMS', value = 3}) --Ambulance
		table.insert(elements, { label = 'EMS REGIONAL', value = 4}) --Ambulance
	elseif PlayerData.job.name == 'ambulance' then --If is ambulance then he has the below frequencies
		table.insert(elements, { label = 'EMS COMMS', value = 3}) --Ambulance
		table.insert(elements, { label = 'EMS REGIONAL', value = 4}) --Ambulance
		table.insert(elements, { label = 'TASPD CITY', value = 1}) --Police
		table.insert(elements, { label = 'TASPD REGIONAL', value = 2}) --Police 2
	elseif PlayerData.job.name == 'bennys' then --If is mechanic then he has the below frequencies
		table.insert(elements, { label = 'BENNYS', value = 5}) --Mechanic
	end
		
	table.insert(elements, { label = 'Join an open frequency', value = 'avoin'}) --Join to a non private frequency
	table.insert(elements, { label = 'Turn off radio / leave channel', value = 'poistu'}) --Leave
	TRP.UI.Menu.CloseAll()

	TRP.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'radio',
		{
			title    = 'Radio frequency', --Frequency
			align    = 'bottom-right',
			elements = elements,
		},

		function(data, menu)
		
		menu.close()
		
		if fiddlemydiddle ~= nil then
			exports["mumble-voip-fivem-master"]:removePlayerFromRadio(fiddlemydiddle)
			fiddlemydiddle = nil
		end
		
		if data.current.value == 'avoin' then
			AddTextEntry('FMMC_KEY_TIP8', "Frequency between 5.1-99.9")
			DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 4)
			while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
				Citizen.Wait(0)
			end
			local WALLAH = GetOnscreenKeyboardResult()
			WALLAH = tonumber(WALLAH)
			Citizen.Wait(150)
			if WALLAH ~= nil and WALLAH > 5 and WALLAH < 100 then
				fiddlemydiddle = WALLAH
				exports["mumble-voip-fivem-master"]:addPlayerToRadio(fiddlemydiddle, true)
				TRP.ShowNotification('~g~You joined the radio frequency ~w~'..fiddlemydiddle..'') --You joined to radio frequency
			else
				TRP.ShowNotification('~r~Invalid radio frequency') -- Invalid radio frequency
			end
		elseif data.current.value == 'poistu' then
		else
			fiddlemydiddle = data.current.value
			exports["mumble-voip-fivem-master"]:addPlayerToRadio(fiddlemydiddle, true)
		end
		
		Currensrption     = 'radio'
		CurrensrptionMsg  = 'Radio Frequency'
		CurrensrptionData = {}

		end,
	
	function(data, menu)

		menu.close()

		Currensrption     = 'radio'
		CurrensrptionMsg  = 'Radio Frequency'
		CurrensrptionData = {}
	end)
end

--Checks if the person has a radio item
RegisterNetEvent('TRP_RadioComms:hentaigirls') 
AddEventHandler('TRP_RadioComms:hentaigirls', function(backintheday)
	hentaigirls = backintheday
	if not hentaigirls then
		if fiddlemydiddle ~= nil then
			exports["mumble-voip-fivem-master"]:removePlayerFromRadio(fiddlemydiddle)
		   	fiddlemydiddle = nil
		end
	end
end)

--Using the radio event
RegisterNetEvent('TRP_RadioComms:use')
AddEventHandler('TRP_RadioComms:use', function()
	OpenRadioMenu()
end)

--If player dies it removes him from radio
RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function()
	if fiddlemydiddle ~= nil then
		exports["mumble-voip-fivem-master"]:removePlayerFromRadio(fiddlemydiddle)
		fiddlemydiddle = nil
	end
end)
