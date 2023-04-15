local function GetWeaponLabel(hash)
    local label = Config.WeaponHash[hash] or Config.WeaponHash[tostring(hash)]
    if label ~= nil and label ~= "invalid" then
        return label
    end
    return nil
end

local Notifications = nil

local function Notification(msg)
    if Notifications ~= nil then 
      	RemoveNotification(Notifications)
    end 
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(msg)
    Notifications = DrawNotification(0, 1)
end

Citizen.CreateThread(function()
	while true do
		time = 175
		local playerPed = PlayerPedId()
		local selectedWeapon = GetSelectedPedWeapon(playerPed, true)
		if GetVehiclePedIsIn(playerPed, false) == 0 then
			if selectedWeapon ~= GetHashKey("weapon_unarmed") then
				local weaponHash = GetSelectedPedWeapon(PlayerPedId()) 
				local weaponLabel = GetWeaponLabel(weaponHash)
                if weaponLabel then
                    if not currentWeapon or currentWeapon ~= weaponLabel then
                        currentWeapon = weaponLabel
                        Notification(Config.Translation:format(weaponLabel))
                    end
                else
                    if Notifications ~= nil then 
                        RemoveNotification(Notifications)
                    end 
                end
			else
				if Notifications ~= nil then 
					RemoveNotification(Notifications)
					currentWeapon = nil
				end
			end
		end
		Wait(time)
	end
end)