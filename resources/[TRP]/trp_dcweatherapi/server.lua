--SEVER WEATHER DO NOT TOUCH IN LUE WITH SIMPLEWEATHER FOR DISCORD API


local cityid = "2147291" -- State of Tasmania, AU
local apikey = "44b725a412bf0edd617ce16afa03dc00"
local GetWeather = "http://api.openweathermap.org/data/2.5/weather?id="..cityid.."&lang=en&units=metric&APPID="..apikey

function sendToDiscordMeteo (type, name,message,color)
    local DiscordWebHook = "https://discordapp.com/api/webhooks/756685306572308611/TrBU3ynh5XmDHVFjV60B8xgL0qvC0B8ygV2wlu4d2d1WpiN8rypvGEnqRHLbZuvw7-ln"

    local avatar = "https://i.imgur.com/HbYoo0e.png"


    local embeds = {
        {

            ["title"]=message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  {
            ["text"]= "-------------------------------------------------------------------------------------------------------------------",
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds,avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
end

function checkMeteo(err,response)
    local data = json.decode(response)
    local type = data.weather[1].main
    local id = data.weather[1].id
    local description = data.weather[1].description
    local wind = math.floor(data.wind.speed)
    local windrot = data.wind.deg
    local meteo = "EXTRASUNNY"
    local ville = data.name
    local temp = math.floor(data.main.temp)
    local tempmini = math.floor(data.main.temp_min)
    local tempmaxi = math.floor(data.main.temp_max)
    local emoji = ":white_sun_small_cloud:"
    if type == "Thunderstorm" then
        meteo = "THUNDER"
        emoji = ":cloud_lightning:"
    end
    if type == "Rain" then
        meteo = "RAIN"
        emoji = ":cloud_rain:"
    end
    if type == "Drizzle" then
        meteo = "CLEARING"
        emoji = ":white_sun_rain_cloud:"
        if id == 608  then
            meteo = "OVERCAST"
        end
    end
    if type == "Clear" then
        meteo = "CLEAR"
        emoji = ":sun_with_face:"
    end
    if type == "Clouds" then
        meteo = "CLOUDS"
        emoji = ":cloud:"
        if id == 804  then
            meteo = "OVERCAST"
        end
    end
    if type == "Snow" then
        meteo = "SNOW"
        emoji = ":cloud_snow:"
        if id == 600 or id == 602 or id == 620 or id == 621 or id == 622 then
            meteo = "XMAS"
        end
    end

    Data = {
        ["KANGA"] = meteo,
        ["Predkosc Wiatru"] = wind,
        ["Kierunek Wiatru"] = windrot
    }
    TriggerClientEvent("meteo:actu", -1, Data)
    sendToDiscordMeteo(1,('KANGA'), emoji.." Current weather on the island is "..description..". \n:thermometer: It is now "..temp.."°C  Minimum Temperature "..tempmini.."°C Max Temperature "..tempmaxi.."°C. \n:wind_blowing_face: Current wind speed is "..wind.."m/s.",16711680)
    SetTimeout(30*30*250, checkMeteoHTTPRequest)
end

function checkMeteoHTTPRequest()
    PerformHttpRequest(GetWeather, checkMeteo, "GET")
end

checkMeteoHTTPRequest()

RegisterServerEvent("meteo:sync")
AddEventHandler("meteo:sync",function()
    TriggerClientEvent("meteo:actu", source, Data)
end)

--[[
"EXTRASUNNY"
"SMOG"
"CLEAR"
"CLOUDS"
"FOGGY"
"OVERCAST"
"RAIN"
"THUNDER"
"CLEARING"
"NEUTRAL"
"SNOW"
"BLIZZARD"
"SNOWLIGHT"
"XMAS"
]]