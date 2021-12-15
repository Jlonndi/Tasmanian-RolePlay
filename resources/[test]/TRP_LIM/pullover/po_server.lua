RegisterServerEvent('ticket')
AddEventHandler('ticket', function(string)
  TriggerClientEvent('chatMessage', -1, string)
end)

local pisVersion = "1.0.5"

print("")
print("----------------[TRPLIM]----------------")
print("TRPLIM:SYSTEM - TRPLIM SUCCESFULLY LOADED")
print("TRPLIM:SYSTEM - RUNNING ON v" .. pisVersion)
print("---------------------------------------")

TriggerClientEvent('chatMessage', -1, "TRPLIM ^6v" .. pisVersion, { 0, 0, 0}, " SUCCESFULLY LOADED!")