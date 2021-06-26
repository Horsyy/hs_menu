RegisterNetEvent("hs_menu:soundStatus")
AddEventHandler("hs_menu:soundStatus", function(type, musicId, data)
    TriggerClientEvent("hs_menu:soundStatus", -1, type, musicId, data)
end)