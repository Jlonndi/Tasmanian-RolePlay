ESX = nil
local admin = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


local show = false
function openGui()
  if show == false then
    show = true
    SetNuiFocus(true, true)

    SendNUIMessage(
      {
        show = true
      }
    )
  end
end

function closeGui()
  show = false
  SetNuiFocus(false)
  SendNUIMessage({show = false})
end

--RegisterCommand('report', function(source)
--	openGui()
--end)

RegisterNetEvent("reportUI:openGui")
AddEventHandler("reportUI:openGui", function(user_id)
	user_id = user_id
    openGui()
end)

RegisterNUICallback("sendSuggestion", function(data)
  description = data['data'][1]
  ESX.TriggerServerCallback('ticket:executeAction', function(resp)
    if resp.success then
      TriggerEvent('customNotification', 'Your ticket has been sent to the administration, please be patient as we handle the tickets in an chronological order.')
    end
  end, {action = 'create', content = description}) -- sends ingame too
    TriggerServerEvent("reportUI:sendSuggestion", description)
end)


RegisterNetEvent("reportUI:suggestionSent")
AddEventHandler("reportUI:suggestionSent", function(user_id)
	user_id = user_id
    closeGui()
end)


RegisterNUICallback("emptyFields", function()
  TriggerServerEvent("reportUI:emptyFields")
end)

RegisterNUICallback("close", function()
	closeGui()
end)
