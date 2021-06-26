ESX = nil
xSound = exports.xsound
local volume = Config.DefaultVolume
local PlayerData = {}

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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

if Config.EnableCommand then
	RegisterCommand(Config.CommandName, function()
		local job = ESX.PlayerData.job.name
		if Config.Jobs[job] then
			if Config.EnableAuthorizedGrade then
				if (ESX.PlayerData.job.grade_name == Config.AuthorizedGrade) or (ESX.PlayerData.job.grade_name == 'boss') then
					OpenMusicMenu()
				else
					ESX.ShowNotification('You are not ~o~Authorized~s~ to use this.')
				end
			else
				OpenMusicMenu()
			end
		else
			ESX.ShowNotification('You must be an ~y~employee~s~ of a similar store.')
		end
	end, false)
end

RegisterNetEvent('hs_menu:OpenMenu')
AddEventHandler('hs_menu:OpenMenu', function()
	if Config.EnableAuthorizedGrade then
		if (ESX.PlayerData.job.grade_name == Config.AuthorizedGrade) or (ESX.PlayerData.job.grade_name == 'boss') then
			OpenMusicMenu()
		else
			ESX.ShowNotification('You are not ~o~Authorized~s~ to use this.')
		end
	else
		OpenMusicMenu()
	end
end)

function OpenMusicMenu()
    ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'music_menu', {
		title    = 'Youtube Play Menu',
		align    = 'left',
		elements = {
			{label = 'Play Youtube', value = 'play'},
			{label = 'Volume', type = 'slider', value = 5, min = 1, max = 10},
			{label = 'Pause', value = 'pause'},
			{label = 'Resume', value = 'resume'},
			{label = 'Stop', value = 'stop'}
		}}, function(data, menu)

		if data.current.label == 'Volume' then
			volume = data.current.value/10
			SetVol()
			ESX.ShowNotification('Volume changed to ~g~'..data.current.value..'/10~s~')
		end

		if data.current.value == 'play' then
			PlayUrl()
			menu.close()
		elseif data.current.value == 'pause' then
			Pause()
		elseif data.current.value == 'resume' then
			Resume()
		elseif data.current.value == 'stop' then 
			Stop()
		end
	end, function(data, menu)
		menu.close()
    end)
end

function SetVol()
	local job = ESX.PlayerData.job.name
	TriggerServerEvent("hs_menu:soundStatus", "volume", job, {vol = volume})
end

function PlayUrl()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'music_menu', {
		title = 'Youtube URL'
	}, function(data, menu)
		local job = ESX.PlayerData.job.name
		for k,v in pairs(Config.Jobs[job]) do
			TriggerServerEvent("hs_menu:soundStatus", "play", job, { vol = volume, distance = v.distance, position = v.coordinates, link = data.value })
		end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function Pause()
	local job = ESX.PlayerData.job.name
	TriggerServerEvent("hs_menu:soundStatus", "pause", job)
end

function Resume()
	local job = ESX.PlayerData.job.name
	TriggerServerEvent("hs_menu:soundStatus", "resume", job)
end

function Stop()
	local job = ESX.PlayerData.job.name
	TriggerServerEvent("hs_menu:soundStatus", "stop", job)
end

RegisterNetEvent("hs_menu:soundStatus")
AddEventHandler("hs_menu:soundStatus", function(type, musicId, data)
    if type == "stop" then
        xSound:Destroy(musicId)
    end

	if type == "resume" then
        xSound:Resume(musicId)
    end

	if type == "pause" then
        xSound:Pause(musicId)
    end

    if type == "play" then
        xSound:PlayUrlPos(musicId, data.link, 1, data.position)
        xSound:Distance(musicId, data.distance)
		xSound:setVolumeMax(musicId, data.vol)
    end

	if type == "volume" then
		xSound:setVolumeMax(musicId, data.vol)
    end
end)