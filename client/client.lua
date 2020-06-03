handcuffed = false
handsup = false

local Animation = {
		HandsUp = {
			Dict = "random@mugging3", 
			Name = "handsup_standing_base"
		},
		Handcuffs = {
			Dict = "mp_arresting"
			Name = "idle"
		}
	}

local unarmed = GetHashKey("WEAPON_UNARMED")


-- Set up Cuff
TriggerEvent("chat:addSuggestion", "/"..CHConfig.Commands.Cuff, CHConfig.Commands.CuffInformation, CHConfig.Commands.CuffChatArguments);



if CHConfig.HandsUP.Enabled then
	-- Set up Handsup
	TriggerEvent("chat:addSuggestion", "/"..CHConfig.HandsUP.Command.ChatCommand, CHConfig.HandsUP.Command.ChatInformation, CHConfig.HandsUP.Command.ChatArguments);
	
	RegisterNetEvent("cuffup:"..CHConfig.HandsUP.Command.ChatCommand)
	AddEventHandler("cuffup:"..CHConfig.HandsUP.Command.ChatCommand, function()
		TriggerEvent("cuffup:Handsup");
	end);
	
	RegisterNetEvent("cuffup:Handsup")
	AddEventHandler("cuffup:Handsup", function()
		local player = PlayerId()
		local plyPed = GetPlayerPed(player)
		if DoesEntityExist(plyPed) then
			if not handcuffed then
				if handsup then
					ClearPedSecondaryTask(plyPed)
					SetEnableHandcuffs(plyPed, false)
					SetCurrentPedWeapon(plyPed, unarmed, true)
					TriggerEvent("chatMessage", "^1Your hands are down")
					handsup = false
				else
					RequestAnimDict(Animation.HandsUp.Dict)
					while not HasAnimDictLoaded(Animation.HandsUp.Dict) do
						Citizen.Wait(100)
					end
					TaskPlayAnim(plyPed, Animation.HandsUp.Dict, Animation.HandsUp.Name, 8.0, -8, -1, 49, 0, 0, 0, 0)
					SetEnableHandcuffs(plyPed, true)
					SetCurrentPedWeapon(plyPed, unarmed, true)
					TriggerEvent("chatMessage", "^1Your hands are up")
					handsup = true
				end
			else
				TriggerEvent("chatMessage", "^1Good luck putting your hands up in cuffs....")
			end
		end
	end)

	Citizen.CreateThread(function()
		while true do
			local player = PlayerId()
			local plyPed = GetPlayerPed(player)
			if DoesEntityExist(plyPed) then

				-- Backup Handsup
				if handsup then
					if not IsEntityPlayingAnim(plyPed, Animation.HandsUp.Dict, Animation.HandsUp.Name, 3) then
						Citizen.Wait(3000)
						if handsup and not handcuffed then
							TaskPlayAnim(plyPed, Animation.HandsUp.Dict, Animation.HandsUp.Name, 8.0, -8, -1, 49, 0, 0, 0, 0)
						end
					end
				end

				-- Remove ability to drive vehicles
				if handsup then
					DisablePlayerFiring(player, true)
					DisableControlAction(0, 25, true)
					DisableControlAction(1, 140, true)
					DisableControlAction(1, 141, true)
					DisableControlAction(1, 142, true)
					SetPedPathCanUseLadders(GetPlayerPed(PlayerId()), false)
					if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
						DisableControlAction(0, 59, true)
					end
				end
				
			end
			Citizen.Wait(0)
		end
	end)
end
RegisterNetEvent("Handcuff")
AddEventHandler("Handcuff", function()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	if DoesEntityExist(plyPed) then
		if IsEntityPlayingAnim(plyPed, animation.dict, animation.name, 3) then
			ClearPedSecondaryTask(plyPed)
			SetEnableHandcuffs(plyPed, false)
			SetEnableHandcuffs(plyPed, false)
			SetCurrentPedWeapon(ped, unarmed, true)
			handcuffed = false
		else
			handsup = false
			ClearPedTasksImmediately(plyPed)
			RequestAnimDict(animation.dict)
			while not HasAnimDictLoaded(animation.dict) do
				Citizen.Wait(100)
			end

			TaskPlayAnim(plyPed, animation.dict, animation.name, 8.0, -8, -1, 49, 0, 0, 0, 0)
			SetEnableHandcuffs(plyPed, true)
			SetCurrentPedWeapon(plyPed, unarmed, true)
			handcuffed = true
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local player = PlayerId()
		local plyPed = GetPlayerPed(player)
		if DoesEntityExist(plyPed) then

			-- Cuffing Logic
			if not IsPedInAnyVehicle(plyPed, false) then
				if IsControlJustPressed(0, 186) then
					local targetped = GetPedInFront()
					print(targetped)
					if targetped ~= 0 then
						local targetplayer = GetPlayerFromPed(targetped)
						if targetedPlayer ~= -1 then
							TriggerServerEvent("CheckHandcuff", GetPlayerServerId(targetplayer))
						end
					end
				end
			end

			-- Backup Handcuffs
			if handcuffed then
				if not IsEntityPlayingAnim(plyPed, animation.dict, animation.name, 3) then
					Citizen.Wait(3000)
					if handcuffed then
						TaskPlayAnim(plyPed, animation.dict, animation.name, 8.0, -8, -1, 49, 0, 0, 0, 0)
					end
				end
			end

			-- Remove ability to drive vehicles
			if handcuffed then
				DisablePlayerFiring(player, true)
				DisableControlAction(0, 25, true)
				DisableControlAction(1, 140, true)
				DisableControlAction(1, 141, true)
				DisableControlAction(1, 142, true)
				SetPedPathCanUseLadders(GetPlayerPed(PlayerId()), false)
				if IsPedInAnyVehicle(GetPlayerPed(PlayerId()), false) then
					DisableControlAction(0, 59, true)
				end
			end
			
		end
		Citizen.Wait(0)
	end
end)

function GetPedInFront()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
	return ped
end

function GetPlayerFromPed(ped)
	for a = 0, 64 do
		if GetPlayerPed(a) == ped then
			return a
		end
	end
	return -1
end