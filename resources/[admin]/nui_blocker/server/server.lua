local webhook = 'https://discord.com/api/webhooks/818369157171118090/jCSVSob51ECAhZ8dUFQurRf-087GrqpEXkoNIGAAunnpZRdm3f01h23EAU7JTv8br2pO'


RegisterServerEvent('IlovePlayingWithMyCockinNUIDEVTOOLS')
AddEventHandler('IlovePlayingWithMyCockinNUIDEVTOOLS', function()
    print('detekted ' .. GetPlayerName(source))
    sendToDiscord("Asshole Logged", GetPlayerName(source).." tried to use nui_devtools at "..os.time())
    DropPlayer(source, 'Hmm, what you wanna do in this inspector?')
end)

function sendToDiscord(name, args, color)
    local connect = {
          {
              ["color"] = 16711680,
              ["title"] = "".. name .."",
              ["description"] = args,
              ["footer"] = {
                  ["text"] = "Made by TassieRP",
              },
          }
      }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Asshole Log", embeds = connect, avatar_url = "https://miro.medium.com/max/1000/1*MqFcwBk0Vr8UsFDVV-1Zfg.gif"}), { ['Content-Type'] = 'application/json' })
end



