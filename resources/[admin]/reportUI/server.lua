local discordwebhooklink = 'https://discord.com/api/webhooks/819373794577350657/xMpq3hoKkIvNqs0pnJgaQe7Fh5mfylvKiaqGfqHggYe7HaskTo3tH_cM-nFPI9XW_FAr'
local displayidentifiers = true -- Display the user identifiers in the embed? Steam id, discord id etc

function GetPlayerNeededIdentifiers(source)
		local ids = GetPlayerIdentifiers(source)
		for i,theIdentifier in ipairs(ids) do
			if string.find(theIdentifier,"license:") or -1 > -1 then
				license = theIdentifier
			elseif string.find(theIdentifier,"steam:") or -1 > -1 then
				steam = theIdentifier
			elseif string.find(theIdentifier,"discord:") or -1 > -1 then
				discord2 = theIdentifier
			end
		end
		if not steam then
			steam = "Not found"
		end
		if not discord2 then
			discord2 = "Not found"
		end
		return license, steam, discord2
	end


RegisterNetEvent("reportUI:sendSuggestion")
AddEventHandler("reportUI:sendSuggestion", function(data)
print(data)
  --discord = data['data'][1]
 -- description = data['data'][2]

	  local license, steam, discord2 = GetPlayerNeededIdentifiers(source)

if displayidentifiers then
  PerformHttpRequest(discordwebhooklink, function(err, text, headers) end, 'POST', json.encode(
    {
      username = "Reports",
      --avatar_url = Image,
      embeds = {
        {
          title = "New Report",
          color = 16754176,
          description = "**User:** ".. GetPlayerName(source) .. " **[ID:** ".. source .."**]**\n**Report:** ".. data .."\n**Steam:** ".. steam:gsub('steam:', '') .."\n**GameLicense:** ".. license:gsub('license:', '') .."\n**Discord UID:** ".. discord2:gsub('discord:', '') .."\n**Discord Tag:** <@!"..  discord2:gsub('discord:', '') .. ">",
        }
      },
    }), { ['Content-Type'] = 'application/json' })


  TriggerClientEvent("reportUI:suggestionSent", source)
  TriggerClientEvent("mythic_notify:client:SendAlert", source, { type = "inform", text = "Your Report was successfully sent to our Administrators", length = 7000})
else
  PerformHttpRequest(discordwebhooklink, function(err, text, headers) end, 'POST', json.encode(
    {
      username = "Suggestions",
      --avatar_url = Image,
      embeds = {
        {
          title = "New Suggestion",
          color = 16754176,
          description = "**User:** ".. GetPlayerName(source) .. " **[ID:** ".. source .."**]**\n**Suggestion:** ".. data .."",
        }
      },
    }), { ['Content-Type'] = 'application/json' })


  TriggerClientEvent("reportUI:suggestionSent", source)
  TriggerClientEvent("mythic_notify:client:SendAlert", source, { type = "inform", text = "Your Report was successfully sent to our Administrators", length = 7000})
  end
end)

RegisterNetEvent("reportUI:emptyFields")
AddEventHandler("reportUI:emptyFields", function(data)
	TriggerClientEvent("mythic_notify:client:SendAlert", source, { type = "inform", text = "Please fill out the required fields.", length = 7000})
end)

Citizen.CreateThread(function()
	if (GetCurrentResourceName() ~= "reports") then 
		print("[" .. GetCurrentResourceName() .. "] " .. "IMPORTANT: This resource must be named reportUi for it to work properly!");
		print("[" .. GetCurrentResourceName() .. "] " .. "IMPORTANT: This resource must be named reportUi for it to work properly!");
		print("[" .. GetCurrentResourceName() .. "] " .. "IMPORTANT: This resource must be named reportUi for it to work properly!");
		print("[" .. GetCurrentResourceName() .. "] " .. "IMPORTANT: This resource must be named reportUi for it to work properly!");
	end
end)

Citizen.CreateThread(function()
    if discordwebhooklink == "WEBHOOK_HERE" then
        print("[" .. GetCurrentResourceName() .. "] " .. "IMPORTANT: You need to change the webhook link in server.lua for it to work properly");
        print("[" .. GetCurrentResourceName() .. "] " .. "IMPORTANT: You need to change the webhook link in server.lua for it to work properly");
        print("[" .. GetCurrentResourceName() .. "] " .. "IMPORTANT: You need to change the webhook link in server.lua for it to work properly");
        print("[" .. GetCurrentResourceName() .. "] " .. "IMPORTANT: You need to change the webhook link in server.lua for it to work properly");
    end
end)
