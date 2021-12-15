ESX               = nil
local PlayerData              = {}


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

local firstSpawn = true
local componentScroller = 0
local subComponentScroller = 0
local textureScroller = 0
local paletteScroller = 0
local removeScroller = 0
local opacityScroller = 0
local colourScroller = 0
local clothing_shops2 = {
	vector3(1931.35, 3727.62, 33.12),
	vector3(1694.00, 4818.54, 42.33),
	vector3(126.57, -223.22, 54.70),
	vector3(-709.42, -152.45, 37.50),
	vector3(-818.42, -1071.88, 11.50),
	vector3(-1194.42, -768.17, 17.48),
	vector3(1.21, 6509.88, 32.00),
	vector3(425.04, -810.61, 29.75),
	vector3(473.65, -993.74, 25.73), -- Mission Row PD
	vector3(1848.54, 3696.44, 34.27), -- Sandy PD
	vector3(-452.17, 6011.80, 32.00), -- Paleto PD
	vector3(2038.49, 3016.93, -72.7), -- IAA Building
	vector3(119.89, -727.19, 242.20), -- FIB Building
	vector3(-572.97, 285.58, 79.18), -- Tequilala
	vector3(1987.8, 3047.47, 50.5), --ReapersMC Club House
	vector3(-37.95, 6383.7, 31.6), --ForgivenMC Club House
	vector3(301.85, -599.61, 43.30), -- Pillbox Hospital
	vector3(75.94, -1388.54, 29.64),
	vector3(-1449.45, -237.8, 49.90),
	vector3(-164.18, -303.04, 39.85),
	vector3(1198.85, 2709.15, 38.25),
	vector3(-1098.00, 2712.94, 19.23),
	vector3(1840.45, 3677.16, 29.02), -- Sandy Hospital
	vector3(-262.18, 6316.7, 32.46), -- Paleto Hospital
	vector3(-443.16, -309.07, 34.91), -- Mount Zonah Hospital
}

Citizen.CreateThread(function()
	for k, v in pairs(clothing_shops2) do
		local marker = {
			name = v,
			type = 2,
			customDraw = 5,
			coords =v,
			colour = { r = 55, b = 255, g = 55 },
			size = vector3(1.5, 1.5, 0.75),
			msg = "Press [~g~E~w~] to add ~g~extras",
			show3D = true,
			action = function()
				GUI.maxVisOptions = 20
				titleTextSize = {0.85, 0.80} ------------ {p1, Size}
				titleRectSize = {0.23, 0.085} ----------- {Width, Height}
				optionTextSize = {0.5, 0.5} ------------- {p1, Size}
				optionRectSize = {0.23, 0.035} ---------- {Width, Height}
				menuX = 0.745 ----------------------------- X position of the menu
				menuXOption = 0.11 --------------------- X postiion of Menu.Option text
				menuXOtherOption = 0.06 ---------------- X position of Bools, Arrays etc text
				menuYModify = 0.1500 -------------------- Default: 0.1174   ------ Top bar
				menuYOptionDiv = 4.285 ------------------ Default: 3.56   ------ Distance between buttons
				menuYOptionAdd = 0.21 ------------------ Default: 0.142  ------ Move buttons up and down
				clothing_menu = not clothing_menu
				OpenClothes()
			end,
			shouldDraw = function()
				return true
			end

		}
		TriggerEvent('og-base:registerMarker', marker)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if clothing_menu then
			Menu.DisplayCurMenu()
		end
	end
end)

function OpenClothes()
    Menu.SetupMenu("clothing_main","Clothing")
    Menu.Switch(nil, "clothing_main")
		if PlayerData.job.name ~= 'police' then
    for k,v in pairs(menu_options) do
        Menu.addOption("clothing_main", function()
            if(Menu.Option(v.name))then
                 v.f(v.name,v.param)
            end
        end)
			end
    else
			for k,v in pairs(menu_options_police) do
	        Menu.addOption("clothing_main", function()
	            if(Menu.Option(v.name))then
	                 v.f(v.name,v.param)
	            end
	        end)
				end
			end
end

function listModels(title, table)
    Menu.SetupMenu("clothing_models", title)
    Menu.Switch("clothing_main", "clothing_models")
    for k,v in pairs(table) do
        Menu.addOption("clothing_models", function()
            if(Menu.Option(v))then
                TriggerEvent("clothes:changemodel", v)
            end
        end)
    end
end


function civilianPed()

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

		local model = nil

		if skin.sex == 0 then

			model = GetHashKey("mp_m_freemode_01")

		else

			model = GetHashKey("mp_f_freemode_01")

		end

		RequestModel(model)

		while not HasModelLoaded(model) do

			RequestModel(model)
			Citizen.Wait(0)

		end

		SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
		TriggerEvent('skinchanger:loadSkin', skin)
		TriggerEvent('esx:restoreLoadout')

    end)
end

function customise(title)
    Menu.SetupMenu("clothing_customise", title)
    Menu.Switch("clothing_main", "clothing_customise")
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        componentScroller = 0
        subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
        textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
        paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarString({"Head","Mask","Hair","Arms","Pants","Parachutes","Shoes","Necklace & Ties","Undershirt","Body Armour","Decals","Shirts"}, componentScroller, function(cb)  componentScroller = cb end)) then
                subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
                textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
                paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumberOfPedDrawableVariations(PlayerPedId(), componentScroller), function(cb)  subComponentScroller = cb end)) then
                if componentScroller == 0 then
                    SetPedHeadBlendData(PlayerPedId(), subComponentScroller, subComponentScroller, 0, subComponentScroller, subComponentScroller, 0, 0.5, 0.5, 0.0, false)
                end
                SetPedComponentVariation(PlayerPedId(), componentScroller, 0, 240, 0)
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
                textureScroller = 0
                paletteScroller = 0
            end
        end)
        Menu.addOption("clothing_customise", function()
            local textureMax = 0
            if componentScroller == 2 then textureMax = GetNumHairColors() else textureMax = GetNumberOfPedTextureVariations(PlayerPedId(), componentScroller, subComponentScroller) end
            if(Menu.ScrollBarInt("Textures", textureScroller, textureMax, function(cb)  textureScroller = cb end)) then
                if componentScroller == 2 then
                    SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, 0, 1)
                    SetPedHairColor(PlayerPedId(), textureScroller, textureScroller)
                    player_data.clothing.textures[3] = textureScroller
                else
                    SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
                end
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Colour Palette", paletteScroller, 2, function(cb)  paletteScroller = cb end)) then
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.Option("Remove Undershirt"))then
                SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.Option("Randomize"))then
                SetPedRandomComponentVariation(PlayerPedId(), true)
            end
        end)
    else
        componentScroller = 0
        subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
        textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
        paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_customise", function()
            local precomponentTable = {"Head","No idea","Hair","Shirts","Pants","No idea","No idea","No idea","Necklace & Ties","No idea","No idea","No idea"}
            local componentTable = {}
            for i = 0, 11 do
                if GetNumberOfPedDrawableVariations(PlayerPedId(), i) ~= 0 and GetNumberOfPedDrawableVariations(PlayerPedId(), i) ~= false then
                    componentTable[i+1] = precomponentTable[i+1]
                else
                    componentTable[i+1] = "Empty slot"
                end
            end
            if(Menu.ScrollBarString(componentTable, componentScroller, function(cb)  componentScroller = cb end)) then
                subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
                textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
                paletteScroller = GetPedPaletteVariation(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumberOfPedDrawableVariations(PlayerPedId(), componentScroller), function(cb)  subComponentScroller = cb end)) then
                SetPedComponentVariation(PlayerPedId(), componentScroller, 0, 240, 0)
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
                textureScroller = 0
                paletteScroller = 0
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Textures", textureScroller, GetNumberOfPedTextureVariations(PlayerPedId(), componentScroller, subComponentScroller), function(cb)  textureScroller = cb end)) then
                if componentScroller == 2 then player_data.clothing.textures[3] = textureScroller end
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.ScrollBarInt("Colour Palette", paletteScroller, 2, function(cb)  paletteScroller = cb end)) then
                SetPedComponentVariation(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, paletteScroller)
            end
        end)
        Menu.addOption("clothing_customise", function()
            if(Menu.Option("Randomize"))then
                SetPedRandomComponentVariation(PlayerPedId(), true)
            end
        end)
    end
end

function accessories(title)
    Menu.SetupMenu("clothing_accessories", title)
    Menu.Switch("clothing_main", "clothing_accessories")
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        componentScroller = 0
        subComponentScroller = GetPedPropIndex(PlayerPedId(), componentScroller)
        textureScroller = GetPedPropTextureIndex(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarString({"Hats/Helmets","Glasses","Earrings","Empty slot","Empty slot","Empty slot","Left Wrist","Right Wrist"}, componentScroller, function(cb)  componentScroller = cb end)) then
                subComponentScroller = GetPedPropIndex(PlayerPedId(), componentScroller)
                textureScroller = GetPedPropTextureIndex(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumberOfPedPropDrawableVariations(PlayerPedId(), componentScroller), function(cb)  subComponentScroller = cb end)) then
                SetPedPropIndex(PlayerPedId(), componentScroller, 0, 240, 0)
                SetPedPropIndex(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, false)
                textureScroller = 0
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarInt("Textures", textureScroller, GetNumberOfPedPropTextureVariations(PlayerPedId(), componentScroller, subComponentScroller), function(cb)  textureScroller = cb end)) then
                SetPedPropIndex(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, false)
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarStringSelect({"Remove helmets","Remove glasses","Remove earrings","Remove left wrist","Remove right wrist"}, removeScroller, function(cb)  removeScroller = cb end)) then
                if removeScroller ~= 3 and removeScroller ~= 4 then
                    ClearPedProp(PlayerPedId(), tonumber(removeScroller))
                elseif removeScroller == 3 then
                    ClearPedProp(PlayerPedId(), 6)
                else
                    ClearPedProp(PlayerPedId(), 7)
                end
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.Option("Randomize"))then
                SetPedRandomProps(PlayerPedId())
            end
        end)
    else
        local precomponentTable = {"Hats/Helmets","Glasses","Earrings","Empty slot","Empty slot","Empty slot","Left Wrist","Right Wrist"}
        local componentTable = {}
        for i = 0, 7 do
            if GetNumberOfPedPropDrawableVariations(PlayerPedId(), i) ~= 0 and GetNumberOfPedPropDrawableVariations(PlayerPedId(), i) ~= false then
                componentTable[i+1] = precomponentTable[i+1]
            else
                componentTable[i+1] = "Empty slot"
            end
        end
        componentScroller = 0
        subComponentScroller = GetPedDrawableVariation(PlayerPedId(), componentScroller)
        textureScroller = GetPedTextureVariation(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarString(componentTable, componentScroller, function(cb)  componentScroller = cb end)) then
                subComponentScroller = GetPedPropIndex(PlayerPedId(), componentScroller)
                textureScroller = GetPedPropTextureIndex(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumberOfPedPropDrawableVariations(PlayerPedId(), componentScroller), function(cb)  subComponentScroller = cb end)) then
                SetPedPropIndex(PlayerPedId(), componentScroller, 0, 240, 0)
                SetPedPropIndex(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, false)
                textureScroller = 0
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarInt("Textures", textureScroller, GetNumberOfPedTextureVariations(PlayerPedId(), componentScroller, subComponentScroller), function(cb)  textureScroller = cb end)) then
                SetPedPropIndex(PlayerPedId(), componentScroller, subComponentScroller, textureScroller, false)
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.ScrollBarStringSelect({"Remove helmets","Remove glasses","Remove earrings","Remove left wrist","Remove right wrist"}, removeScroller, function(cb)  removeScroller = cb end)) then
                if removeScroller ~= 3 and removeScroller ~= 4 then
                    ClearPedProp(PlayerPedId(), tonumber(removeScroller))
                elseif removeScroller == 3 then
                    ClearPedProp(PlayerPedId(), 6)
                else
                    ClearPedProp(PlayerPedId(), 7)
                end
            end
        end)
        Menu.addOption("clothing_accessories", function()
            if(Menu.Option("Randomize"))then
                SetPedRandomProps(PlayerPedId())
            end
        end)
    end
end

function overlays(title)
    Menu.SetupMenu("clothing_overlays", title)
    Menu.Switch("clothing_main", "clothing_overlays")
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        componentScroller = 0
        subComponentScroller = GetPedHeadOverlayValue(PlayerPedId(), componentScroller)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarString({"Blemishes","Facial Hair","Eyebrows","Ageing","Makeup","Blush","Complexion","Sun Damage","Lipstick","Moles/Freckles","Chest hair","Body blemishes","Add Body blemishes"}, componentScroller, function(cb)  componentScroller = cb end)) then
                subComponentScroller = GetPedHeadOverlayValue(PlayerPedId(), componentScroller)
            end
        end)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarInt("Components", subComponentScroller, GetNumHeadOverlayValues(PlayerPedId(), componentScroller), function(cb)  subComponentScroller = cb end)) then
                SetPedHeadOverlay(PlayerPedId(), componentScroller, subComponentScroller, 1.0)
                opacityScroller = 1.0
            end
        end)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarInt("Opacity", opacityScroller, 10, function(cb)  opacityScroller = cb end)) then
                SetPedHeadOverlay(PlayerPedId(), componentScroller, subComponentScroller, tonumber(opacityScroller/10))
                player_data.overlays.opacity[componentScroller+1] = tonumber(opacityScroller/10)
            end
        end)
        Menu.addOption("clothing_overlays", function()
            if(Menu.ScrollBarInt("Colours", colourScroller, 63, function(cb)  colourScroller = cb end)) then
                local colourType = 0
                if componentScroller == 1 or componentScroller == 2 or componentScroller == 10 then colourType = 1 elseif componentScroller == 5 or componentScroller == 8 then colourType = 2 else colourType = 0 end
                SetPedHeadOverlayColor(PlayerPedId(), componentScroller, colourType, colourScroller, colourScroller)
                player_data.overlays.colours[componentScroller+1] = {colourType = colourType, colour = colourScroller}
            end
        end)
    else
    end
end

function save()
    player_data.model = GetEntityModel(PlayerPedId())
    player_data.new = false
    for i = 0, 11 do
        player_data.clothing.drawables[i+1] = GetPedDrawableVariation(PlayerPedId(), i)
        if i ~= 2 then
            player_data.clothing.textures[i+1] = GetPedTextureVariation(PlayerPedId(), i)
        end
        player_data.clothing.palette[i+1] = GetPedPaletteVariation(PlayerPedId(), i)
    end
    for i = 0, 7 do
        player_data.props.drawables[i+1] = GetPedPropIndex(PlayerPedId(), i)
        player_data.props.textures[i+1] = GetPedPropTextureIndex(PlayerPedId(), i)
    end
    for i = 0, 12 do
        player_data.overlays.drawables[i+1] = GetPedHeadOverlayValue(PlayerPedId(), i)
    end

    if player_data.clothing.drawables[12] == 55 and GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then player_data.clothing.drawables[12] = 56 SetPedComponentVariation(PlayerPedId(), 11, 56, 0, 2) end
    if player_data.clothing.drawables[12] == 48 and GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then player_data.clothing.drawables[12] = 49 SetPedComponentVariation(PlayerPedId(), 11, 49, 0, 2) end

    TriggerServerEvent("clothes:save", player_data)
    TriggerEvent('esx:restoreLoadout')
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

AddEventHandler("clothes:changemodel", function(skin)
    local model = GetHashKey(skin)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        if skin ~= "mp_f_freemode_01" and skin ~= "mp_m_freemode_01" then
            SetPedRandomComponentVariation(PlayerPedId(), true)
        else
            SetPedComponentVariation(PlayerPedId(), 11, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 11, 6, 1, 0)
        end
        SetModelAsNoLongerNeeded(model)
	    TriggerEvent('esx:restoreLoadout')
    else
    end
end)

--[[RegisterNetEvent("clothes:spawn")
AddEventHandler("clothes:spawn", function(data)
    player_data = data
    local model = player_data.model
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        if skin ~= "mp_f_freemode_01" and skin ~= "mp_m_freemode_01" then
            SetPedRandomComponentVariation(PlayerPedId(), true)
        else
            SetPedComponentVariation(PlayerPedId(), 11, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
            SetPedComponentVariation(PlayerPedId(), 11, 6, 1, 0)
        end
        SetModelAsNoLongerNeeded(model)
        if not player_data.new then
            TriggerEvent("clothes:setComponents")
        else
            TriggerServerEvent("clothes:loaded")
	        TriggerEvent('esx:restoreLoadout')
        end
    end
end)]]--

AddEventHandler("clothes:setComponents", function()
    if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
        for i = 0, 11 do
            if i == 0 then
                SetPedHeadBlendData(PlayerPedId(), player_data.clothing.drawables[i+1], player_data.clothing.drawables[i+1], 0, player_data.clothing.drawables[i+1], player_data.clothing.drawables[i+1], 0, 0.5, 0.5, 0.0, false)
            elseif i == 2 then
                SetPedComponentVariation(PlayerPedId(), i, player_data.clothing.drawables[i+1], 0, 1)
                SetPedHairColor(PlayerPedId(), player_data.clothing.textures[i+1], player_data.clothing.textures[i+1])
            else
                SetPedComponentVariation(PlayerPedId(), i, player_data.clothing.drawables[i+1], player_data.clothing.textures[i+1], player_data.clothing.palette[i+1])
            end
        end
        for i = 0, 7 do
            SetPedPropIndex(PlayerPedId(), i, player_data.props.drawables[i+1], player_data.props.textures[i+1], false)
        end
        for i = 0, 12 do
            SetPedHeadOverlay(PlayerPedId(), i, player_data.overlays.drawables[i+1], player_data.overlays.opacity[i+1])
            SetPedHeadOverlayColor(PlayerPedId(), i, player_data.overlays.colours[i+1].colourType, player_data.overlays.colours[i+1].colour, player_data.overlays.colours[i+1].colour)
        end
    else
        for i = 0, 11 do
            SetPedComponentVariation(PlayerPedId(), i, player_data.clothing.drawables[i+1], player_data.clothing.textures[i+1], player_data.clothing.palette[i+1])
        end
        for i = 0, 7 do
            SetPedPropIndex(PlayerPedId(), i, player_data.props.drawables[i+1], player_data.props.textures[i+1], false)
        end
    end
    TriggerServerEvent("clothes:loaded")
end)

AddEventHandler("playerSpawned", function()
    if firstSpawn then
        firstSpawn = false
        TriggerServerEvent("clothes:firstspawn")
    else
        TriggerServerEvent("clothes:spawn")
        TriggerEvent('esx:restoreLoadout')
    end
end)
