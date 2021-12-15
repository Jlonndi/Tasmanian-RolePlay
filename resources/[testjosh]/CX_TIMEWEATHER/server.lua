local Config = {
    apikey = "5e0d3175cfa449eb8de85836211103",
    city = "Tasmania",
    refreshTime = 10 * 60000, --min
}

local weatherType, windSpeed, windDirection

local apiString = "http://api.weatherapi.com/v1/current.json?key=" .. Config.apikey .. "&q=" .. Config.city

Citizen.CreateThread(function()
    while true do
    syncWeather()
    syncTime()
    Citizen.Wait(Config.refreshTime)
    end
end)

RegisterServerEvent('trp:core:syncWeather')
AddEventHandler('trp:core:syncWeather', function()
    TriggerClientEvent('trp:core:syncWeather', source, windSpeed, windDirection, weatherType)
end)

RegisterServerEvent('trp:core:syncTime')
AddEventHandler('trp:core:syncTime', function()
    local h, m, s = tonumber(os.date("%H")), tonumber(os.date("%M")), tonumber(os.date("%S"))
    local bigdick = os.date('%Y-%m-%d %H:%M:%S')
	TriggerClientEvent("trp:core:syncTime", source, "ChangeTime", h, m, s)
    print('-- TRP TIMEWEATHER SYNC --')
    print(bigdick) 
end)

function syncWeather()
    PerformHttpRequest(apiString, function (errorCode, resultData, resultHeaders)
        weatherType = json.decode(resultData).current.condition.code
        print(weatherType)
        windSpeed = json.decode(resultData).current.wind_mph
        windDirection = json.decode(resultData).current.wind_degree
        TriggerClientEvent('trp:core:syncWeather', -1, windSpeed, windDirection, weatherType)
    end)
end

function syncTime()
    local h, m, s = tonumber(os.date("%H")), tonumber(os.date("%M")), tonumber(os.date("%S"))
    local bigdick = os.date('%Y-%m-%d %H:%M:%S')
	TriggerClientEvent("trp:TimeSync", -1, "ChangeTime", h, m, s)
    print('-- TRP TIMEWEATHER SYNC --')
    print(bigdick) 
end