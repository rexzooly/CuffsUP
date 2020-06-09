--[[
	CuffsUP originally known as Handcuff and Handsup scripts 
	Version 1.0.0.3
	By BadKaiPanda[NavaRayUK(Rexzooly)] & Xander1998 (X. Cross)
]]--

-- These options are only used by the client and have no reason to be changed by any dev, so leave it.
CuffsUP.Animation = {
		HandsUP = {
			Dict = "random@mugging3", 
			Name = "handsup_standing_base",
			IsHandsUP = false
		},
		Handcuffs = {
			Dict = "mp_arresting",
			Name = "idle",
			IsHandsCuffed = false
		},
		Grab = {
			GrabbedBy = nil,
			HasBeenGrabbed = false,
			NCPID = nil,
			HasNPCBeenGrabbed = false
		}
	}
CuffsUP.Unarmed = GetHashKey("WEAPON_UNARMED");


-- this will enable users to know about this command in the chat, but does not disable it, this function is created to respeat true RP users.
if CuffsUP.OverRides.Viewable then
	TriggerEvent("chat:addSuggestion", "/"..CuffsUP.OverRides.ChatCommand, CuffsUP.OverRides.ChatInformation, CuffsUP.OverRides.ChatArguments);
end

RegisterNetEvent("cuffsup:mutemode")
AddEventHandler("cuffsup:mutemode", function()
	CuffsUP.Client.Note.Mode = 0;
	DisplayMode = CuffsUP.Note;
	if DisplayMode.Mode > 0 then
		if DisplayMode.Mode == 1 then
			TriggerEvent("chatMessage", "Mute Mode Enabled");
		else
			CuffsUP.Print("Mute Mode Enabled");
		end
	end
end)

RegisterNetEvent("cuffsup:displaymode")
AddEventHandler("cuffsup:displaymode", function()
	CuffsUP.Client.Note.Mode = 2;
	DisplayMode = CuffsUP.Note;
	if DisplayMode.Mode > 0 then
		if DisplayMode.Mode == 1 then
			TriggerEvent("chatMessage", "Display Mode Enabled");
		else
			CuffsUP.Print("Display Mode Enabled");
		end
	end		
end)

RegisterNetEvent("cuffsup:chatmode")
AddEventHandler("cuffsup:chatmode", function()
	CuffsUP.Client.Note.Mode = 1;
	DisplayMode = CuffsUP.Note;
	if DisplayMode.Mode > 0 then
		if DisplayMode.Mode == 1 then
			TriggerEvent("chatMessage", "Chat Mode Enabled");
		else
			CuffsUP.Print("Chat Mode Enabled");
		end
	end		
end)

RegisterNetEvent("cuffsup:reset")
AddEventHandler("cuffsup:reset", function()
	CuffsUP.Client.Note.Mode = nil;
	DisplayMode = CuffsUP.Note;
	if DisplayMode.Mode > 0 then
		if DisplayMode.Mode == 1 then
			TriggerEvent("chatMessage", "Reset To Default");
		else
			CuffsUP.Print("Reset To Default");
		end
	end		
end)

RegisterNetEvent("CacheUpdate")
AddEventHandler("CacheUpdate", function(cache, optoin)
	-- future functionality
end)

if CuffsUP.HandsUP.Enabled then
	-- Set up Handsup
	if CuffsUP.HandsUP.Command.Enabled then
		TriggerEvent("chat:addSuggestion", "/"..CuffsUP.HandsUP.Command.ChatCommand, CuffsUP.HandsUP.Command.ChatInformation, CuffsUP.HandsUP.Command.ChatArguments);
	end
	RegisterNetEvent("cuffsup:Handsup")
	AddEventHandler("cuffsup:Handsup", function()
		local player = PlayerId()
		local plyPed = GetPlayerPed(player)
		if DoesEntityExist(plyPed) then
			if not CuffsUP.Animation.Handcuffs.IsHandsCuffed then
				if CuffsUP.Animation.HandsUP.IsHandsUP then
					CuffsUP.Animation.HandsUP.IsHandsUP = not CuffsUP.Animation.HandsUP.IsHandsUP;
					ClearPedSecondaryTask(plyPed);
					SetEnableHandcuffs(plyPed, false);
					SetCurrentPedWeapon(plyPed, CuffsUP.Unarmed, true);
					DisplayMode = CuffsUP.HandsUP.Note;
					if type(CuffsUP.Client.Note.Mode) ~= "nil" then
						DisplayMode.Mode = CuffsUP.Client.Note.Mode;
					end
					if DisplayMode.Mode > 0 then
						if DisplayMode.Mode == 1 then
							TriggerEvent("chatMessage", DisplayMode.Down);
						else
							CuffsUP.Print(DisplayMode.Down);
						end
					end
				else
					CuffsUP.Animation.HandsUP.IsHandsUP = not CuffsUP.Animation.HandsUP.IsHandsUP
					RequestAnimDict(CuffsUP.Animation.HandsUP.Dict)
					while not HasAnimDictLoaded(CuffsUP.Animation.HandsUP.Dict) do
						Citizen.Wait(1)
					end
					TaskPlayAnim(plyPed, CuffsUP.Animation.HandsUP.Dict, CuffsUP.Animation.HandsUP.Name, 8.0, -8, -1, 49, 120, 0, 0, 0)
					SetEnableHandcuffs(plyPed, true)
					SetCurrentPedWeapon(plyPed, CuffsUP.Unarmed, true)
					DisplayMode = CuffsUP.HandsUP.Note;
					if type(CuffsUP.Client.Note.Mode) ~= "nil" then
						DisplayMode.Mode = CuffsUP.Client.Note.Mode;
					end
					if DisplayMode.Mode > 0 then
						if DisplayMode.Mode == 1 then
							TriggerEvent("chatMessage", DisplayMode.UP);
						else
							CuffsUP.Print(DisplayMode.UP);
						end
					end
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

				-- HandsUP Key Logic
				if CuffsUP.HandsUP.Key.Enabled then
					if IsControlJustPressed(0, CuffsUP.HandsUP.Key.vKey) then
						TriggerEvent("cuffsup:Handsup");
					end
				end
					
				-- Backup Handsup
				if CuffsUP.Animation.HandsUP.IsHandsUP then
					if not IsEntityPlayingAnim(plyPed, CuffsUP.Animation.HandsUP.Dict, CuffsUP.Animation.HandsUP.Name, 3) then
						Citizen.Wait(1000)
						if CuffsUP.Animation.HandsUP.IsHandsUP and not CuffsUP.Animation.Handcuffs.IsHandsCuffed then
							TaskPlayAnim(plyPed, CuffsUP.Animation.HandsUP.Dict, CuffsUP.Animation.HandsUP.Name, 8.0, -8, -1, 49, 0, 0, 0, 0)
						end
					end
				end

				-- Remove ability to drive vehicles
				if CuffsUP.Animation.HandsUP.IsHandsUP then
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
if CuffsUP.Cuffs.Enabled then
	-- Set up Cuff
	if CuffsUP.Cuffs.Command.Enabled then
		TriggerEvent("chat:addSuggestion", "/"..CuffsUP.Cuffs.Command.ChatCommand, CuffsUP.Cuffs.Command.ChatInformation, CuffsUP.Cuffs.Command.ChatArguments);
	end
	
	RegisterNetEvent("cuffsup:handcuff")
	AddEventHandler("cuffsup:handcuff", function()
		local player = PlayerId()
		local plyPed = GetPlayerPed(player)
		if DoesEntityExist(plyPed) then
			if IsEntityPlayingAnim(plyPed, CuffsUP.Animation.Handcuffs.Dict, CuffsUP.Animation.Handcuffs.Name, 3) then
				ClearPedSecondaryTask(plyPed)
				SetEnableHandcuffs(plyPed, false)
				SetEnableHandcuffs(plyPed, false)
				SetCurrentPedWeapon(plyPed, CuffsUP.Unarmed, true)
				CuffsUP.Animation.Handcuffs.IsHandsCuffed = false
			else
				CuffsUP.Animation.HandsUP.IsHandsUP = false;
				ClearPedTasksImmediately(plyPed)
				RequestAnimDict(CuffsUP.Animation.Handcuffs.Dict)
				while not HasAnimDictLoaded(CuffsUP.Animation.Handcuffs.Dict) do
					Citizen.Wait(1)
				end

				TaskPlayAnim(plyPed, CuffsUP.Animation.Handcuffs.Dict, CuffsUP.Animation.Handcuffs.Name, 8.0, -8, -1, 49, 0, 0, 0, 0)
				SetEnableHandcuffs(plyPed, true)
				SetCurrentPedWeapon(plyPed, CuffsUP.Unarmed, true)
				CuffsUP.Animation.Handcuffs.IsHandsCuffed = true
			end
		end
	end)
	RegisterNetEvent("cuffsup:handcuffcommand")
	AddEventHandler("cuffsup:handcuffcommand", function()
		DoTrace, IsAI = CuffsUP.TracePlayer()
		if DoTrace ~= false then
			if not IsAI then
				TriggerServerEvent("CheckHandcuff", DoTrace);
			else
				if CuffsUP.Cuffs.NPC then
					TriggerEvent("cuffsup:handcuffAI", DoTrace);
				end
			end
		end		
	end)
	if CuffsUP.Cuffs.NPC then
		RegisterNetEvent("cuffsup:handcuffAI")
		AddEventHandler("cuffsup:handcuffAI", function(npc)
			local plyPed = npc
			if DoesEntityExist(plyPed) then
				if IsEntityPlayingAnim(plyPed, CuffsUP.Animation.Handcuffs.Dict, CuffsUP.Animation.Handcuffs.Name, 3) then
					handcuffedAI = false
					ClearPedSecondaryTask(plyPed);
					ClearPedTasksImmediately(plyPed);
				else
					CuffsUP.Animation.HandsUP.IsHandsUP = false
					handcuffedAI = true
					TaskSetBlockingOfNonTemporaryEvents(plyPed, true);
					RequestAnimDict(CuffsUP.Animation.Handcuffs.Dict)
					while not HasAnimDictLoaded(CuffsUP.Animation.Handcuffs.Dict) do
						Citizen.Wait(1)
					end
					TaskPlayAnim(plyPed, CuffsUP.Animation.Handcuffs.Dict, CuffsUP.Animation.Handcuffs.Name, 8.0, -8, -1, 49, 0, 0, 0, 0)
				end
			end
		end)
	end
	Citizen.CreateThread(function()
		while true do
			local player = PlayerId()
			local plyPed = GetPlayerPed(player)
			if DoesEntityExist(plyPed) then
				
				if CuffsUP.Cuffs.Key.Enabled then
					-- Cuffing Logic
					if not IsPedInAnyVehicle(plyPed, false) then
						if not IsControlPressed(0, 155) and IsControlJustPressed(0, CuffsUP.Cuffs.Key.vKey) then
							DoTrace, IsAI = CuffsUP.TracePlayer()
							if DoTrace ~= false then
								if not IsAI then
									TriggerServerEvent("CheckAction", DoTrace, "KCuffs");
								else
									if CuffsUP.Cuffs.NPC then
										TriggerServerEvent("CheckAction", DoTrace, "KCuffs", true);
									end
								end
							end
						end
						if IsControlPressed(0, 155) then
							if IsControlJustPressed(0, CuffsUP.Cuffs.Key.vKey) then
								if CuffsUP.Animation.Grab.HasNPCBeenGrabbed then
									TriggerEvent("cuffsup:cuffgrabAI");
								else
									DoTrace, IsAI = CuffsUP.TracePlayer()
									if DoTrace ~= false then
										if not IsAI then
											TriggerServerEvent("CheckAction", DoTrace, "KCG");
										else
											if CuffsUP.Cuffs.NPC then
												TriggerServerEvent("CheckAction", DoTrace, "KCG", true);
											end
										end
									end
								end
							end
						end						
					end
				end
				
				-- Backup Handcuffs
				if CuffsUP.Animation.Handcuffs.IsHandsCuffed then
					if not IsEntityPlayingAnim(plyPed, CuffsUP.Animation.Handcuffs.Dict, CuffsUP.Animation.Handcuffs.Name, 3) then
						Citizen.Wait(1000)
						if CuffsUP.Animation.Handcuffs.IsHandsCuffed then
							TaskPlayAnim(plyPed, CuffsUP.Animation.Handcuffs.Dict, CuffsUP.Animation.Handcuffs.Name, 8.0, -8, -1, 49, 0, 0, 0, 0)
						end
					end
				end

				-- Remove ability to drive vehicles
				if CuffsUP.Animation.Handcuffs.IsHandsCuffed then
					DisablePlayerFiring(player, true)
					DisableControlAction(0, 25, true)
					DisableControlAction(0, CuffsUP.Cuffs.Key.vKey, true)
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
if CuffsUP.Grab.Enabled then
	RegisterNetEvent("cuffsup:grab")
	AddEventHandler("cuffsup:grab", function(source)	
		if CuffsUP.Animation.Grab.HasNPCBeenGrabbed then
			TriggerEvent("cuffsup:grabAI");
		else
			CuffsUP.Animation.Grab.GrabbedBy = source
			CuffsUP.Animation.Grab.HasBeenGrabbed = not CuffsUP.Animation.Grab.HasBeenGrabbed
		end
	end)
	RegisterNetEvent("cuffsup:grabcommand")
	AddEventHandler("cuffsup:grabcommand", function(source)	
		if CuffsUP.Animation.Grab.HasNPCBeenGrabbed then
			TriggerEvent("cuffsup:grabAI");
		else
			DoTrace, IsAI = CuffsUP.TracePlayer()
			if DoTrace ~= false then
				if not IsAI then
					TriggerServerEvent("CheckAction", DoTrace, "CGrab");
				else
					TriggerServerEvent("CheckAction", DoTrace, "CGrab", true);
				end
			end
		end
	end)
	RegisterNetEvent("cuffsup:grabAI")
	AddEventHandler("cuffsup:grabAI", function(npcid)
		local player = PlayerId()
		local plyPed = GetPlayerPed(player)
		if not CuffsUP.Animation.Grab.HasNPCBeenGrabbed then
			CuffsUP.Animation.Grab.HasNPCBeenGrabbed = true;
			CuffsUP.Animation.Grab.NCPID = npcid;
			AttachEntityToEntity(CuffsUP.Animation.Grab.NCPID, plyPed, 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		else
			CuffsUP.Animation.Grab.HasNPCBeenGrabbed = false;
			DetachEntity(plyPed, true, false);
			DetachEntity(CuffsUP.Animation.Grab.NCPID, true, false);
			CuffsUP.Animation.Grab.NCPID = nil;
		end
	end)
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0);
			local player = PlayerId()
			local plyPed = GetPlayerPed(player)
			if DoesEntityExist(plyPed) then
				if CuffsUP.Grab.Key.Enabled then
					-- Grabbing Logic
					if not IsPedInAnyVehicle(plyPed, false) then
						if IsControlJustPressed(0, CuffsUP.Grab.Key.vKey) then
							if CuffsUP.Animation.Grab.HasNPCBeenGrabbed then
								TriggerEvent("cuffsup:grabAI");
							else
								DoTrace, IsAI = CuffsUP.TracePlayer()
								if DoTrace ~= false then
									if not IsAI then
										TriggerServerEvent("CheckAction", DoTrace, "KGrab");
									else
										TriggerServerEvent("CheckAction", DoTrace, "KGrab", true);
									end
								end
							end
						end
					end
				end			
			end
			if CuffsUP.Animation.Grab.HasBeenGrabbed then
				IsGrabbed = true
				AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(CuffsUP.Animation.Grab.GrabbedBy)), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
			else
				if not IsPedInParachuteFreeFall(PlayerPedId()) and IsGrabbed then
					IsGrabbed = false
					DetachEntity(PlayerPedId(), true, false)    
				end
			end
		end
	end)
end

RegisterNetEvent("cuffsup:cuffgrab")
AddEventHandler("cuffsup:cuffgrab", function(DoTrace)
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	if DoesEntityExist(plyPed) then
		if IsEntityPlayingAnim(plyPed, CuffsUP.Animation.Handcuffs.Dict, CuffsUP.Animation.Handcuffs.Name, 3) then
			ClearPedSecondaryTask(plyPed)
			SetEnableHandcuffs(plyPed, false)
			SetEnableHandcuffs(plyPed, false)
			SetCurrentPedWeapon(plyPed, CuffsUP.Unarmed, true)
			CuffsUP.Animation.Handcuffs.IsHandsCuffed = false
			TriggerServerEvent("CheckAction", plyPed, "KGrab");
		else
			CuffsUP.Animation.HandsUP.IsHandsUP = false;
			ClearPedTasksImmediately(plyPed)
			RequestAnimDict(CuffsUP.Animation.Handcuffs.Dict)
			while not HasAnimDictLoaded(CuffsUP.Animation.Handcuffs.Dict) do
				Citizen.Wait(1)
			end

			TaskPlayAnim(plyPed, CuffsUP.Animation.Handcuffs.Dict, CuffsUP.Animation.Handcuffs.Name, 8.0, -8, -1, 49, 0, 0, 0, 0)
			SetEnableHandcuffs(plyPed, true)
			SetCurrentPedWeapon(plyPed, CuffsUP.Unarmed, true)
			CuffsUP.Animation.Handcuffs.IsHandsCuffed = true
			TriggerServerEvent("CheckAction", plyPed, "KGrab");
		end
	end
end)
RegisterNetEvent("cuffsup:cuffgrabAI")
AddEventHandler("cuffsup:cuffgrabAI", function(Ent, IsAI)
	plyPed = Ent;
	if IsAI then
		if CuffsUP.Animation.Grab.HasNPCBeenGrabbed then 
			plyPed = CuffsUP.Animation.Grab.NCPID
		end
	end
	if DoesEntityExist(plyPed) or CuffsUP.Animation.Grab.HasNPCBeenGrabbed then
		if IsEntityPlayingAnim(plyPed, CuffsUP.Animation.Handcuffs.Dict, CuffsUP.Animation.Handcuffs.Name, 3) then
			handcuffedAI = false
			ClearPedSecondaryTask(plyPed);
			ClearPedTasksImmediately(plyPed);
			DetachEntity(plyPed, true, false);
			DetachEntity(CuffsUP.Animation.Grab.NCPID, true, false);
			CuffsUP.Animation.Grab.HasNPCBeenGrabbed = false;
			CuffsUP.Animation.Grab.NCPID = nil;
		else
			handcuffedAI = true
			ClearPedSecondaryTask(plyPed);
			ClearPedTasksImmediately(plyPed);
			TaskSetBlockingOfNonTemporaryEvents(plyPed, true);
			RequestAnimDict(CuffsUP.Animation.Handcuffs.Dict)
			while not HasAnimDictLoaded(CuffsUP.Animation.Handcuffs.Dict) do
				Citizen.Wait(1)
			end
			TaskPlayAnim(plyPed, CuffsUP.Animation.Handcuffs.Dict, CuffsUP.Animation.Handcuffs.Name, 8.0, -8, -1, 49, 0, 0, 0, 0)
			CuffsUP.Animation.Grab.HasNPCBeenGrabbed = true;
			CuffsUP.Animation.Grab.NCPID = plyPed;
			AttachEntityToEntity(plyPed, GetPlayerPed(PlayerId()), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		end
	end
end)
RegisterNetEvent("cuffsup:messageback")
AddEventHandler("cuffsup:messageback", function(s_warning)
	DisplayMode = CuffsUP.Note;
	if type(CuffsUP.Client.Note.Mode) ~= "nil" then
		DisplayMode.Mode = CuffsUP.Client.Note.Mode;
	end
	if DisplayMode.Mode > 0 then
		if DisplayMode.Mode == 1 then
			TriggerEvent("chatMessage", s_warning);
		else
			CuffsUP.Print(s_warning);
		end
	else
		CuffsUP.Print(s_warning);
	end
end)



function CuffsUP.Print(text_s, txt_b, options_t)
	SetNotificationTextEntry("STRING");
	AddTextComponentString(text_s)
	if txt_b then
		SetNotificationMessage(options_t[1], icon, true, 4, sender, title, text)
	end
	DrawNotification(false, false)
end

-- returns ID and IsAI 
function CuffsUP.TracePlayer()
	local targetped = CuffsUP.GetPedInFront()
	if targetped ~= 0 then
		local targetplayer = CuffsUP.GetPlayerFromPed(targetped)
		if targetplayer ~= -1 then
			return GetPlayerServerId(targetplayer), false;
		else
			if CuffsUP.Cuffs.NPC then
				return targetped, true;
			end
		end
	end
	return false
end


function CuffsUP.GetPedInFront()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
	return ped
end

function CuffsUP.GetPlayerFromPed(ped)
	for a = 0, 64 do
		if GetPlayerPed(a) == ped then
			return a
		end
	end
	return -1
end
