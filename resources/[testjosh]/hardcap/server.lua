local playerCount     = 0
local list            = {}
local ConnectLastName = ""
local ConnectTryCount = "0"
local TempBanName     = ""
local Text            = {}


RegisterServerEvent('hardcap:playerActivated')

CreateThread(function()
	Wait(0)
	for i=1, #Config.Text, 1 do
		if Config.Text[i].langname == Config.Lang then
			Text = Config.Text[i]
			break
		end
	end
end)

AddEventHandler('hardcap:playerActivated', function()
  if not list[source] then
    playerCount = playerCount + 1
    list[source] = true
  end
end)

AddEventHandler('playerDropped', function()
  if list[source] then
    playerCount = playerCount - 1
    list[source] = nil
  end
end)

AddEventHandler('playerConnecting', function(name, setReason)
	local cv = GetConvarInt('sv_maxclients', 32)

	if playerCount >= cv and ConnectLastName ~= name and TempBanName ~= name then
		print(Text.Connecting ..name.. Text.server_try_1)
		ConnectLastName = name
		ConnectTryCount = "1"
		setReason(Text.connect_try_1)
		CancelEvent()
		Wait(5000)

	elseif playerCount >= cv and ConnectLastName == name and ConnectTryCount == "1" and TempBanName ~= name then
		print(Text.Connecting ..name.. Text.server_try_2)
		ConnectLastName = name
		ConnectTryCount = "2"
		setReason(Text.connect_try_2)
		CancelEvent()
		Wait(5000)

	elseif playerCount >= cv and ConnectLastName == name and ConnectTryCount == "2" and TempBanName ~= name then
		print(Text.Connecting ..name.. Text.server_try_3)
		ConnectLastName = name
		ConnectTryCount = "0"
		TempBanName = name
		setReason(Text.connect_try_3)
		CancelEvent()
		Wait(5000)

	elseif TempBanName == name then
		print(Text.Connecting ..name.. Text.server_try_X)
		setReason(Text.connect_banned)
		CancelEvent()
		Wait(5000)

	elseif TempBanName ~= name and playerCount < cv then
		print(Text.Connecting ..name)
		ConnectTryCount = "0"
		Wait(60000)
		TempBanName = ""
		ConnectLastName = ""
	end
end)
