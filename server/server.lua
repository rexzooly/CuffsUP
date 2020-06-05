--[[
	CuffsUP originally known as Handcuff and Handsup scripts 
	Version 1.0.0.1
	By BadKaiPanda[NavaRayUK(Rexzooly)] & Xander1998 (X. Cross)
]]--

AddEventHandler('chatMessage', function(source, name, msg)
	cl = stringsplit(msg, " ");
	-- Check if we can even run the handsup function as a command 
	if CuffsUP.HandsUP.Command.Enabled then
		if cl[1] == "/"..CuffsUP.HandsUP.Command.ChatCommand then
			CancelEvent();
			TriggerClientEvent("cuffsup:Handsup", source);	
		end
	end
	-- Check if we can even run the Cuffs function as a command 
	if CuffsUP.Cuffs.Command.Enabled then
		if cl[1] == "/"..CuffsUP.Cuffs.Command.ChatCommand then
			CancelEvent();
			if type(cl[2]) ~= "nil" then
				TriggerClientEvent("cuffsup:handcuff", tonumber(cl[2]))
			else
				TriggerClientEvent("cuffsup:handcuffcommand", source);
			end
		end
	end
	
	-- Leave this commands RP users have the right to stop messages from scripts let them use these overrides.
	if cl[1] == "/cuffsup" then
		CancelEvent();
		if type(cl[2]) == "string" then
			if cl[2] == "mute" then
				TriggerClientEvent("cuffsup:mutemode", source);
			end
			if cl[2] == "display" then
				TriggerClientEvent("cuffsup:displaymode", source);
			end
			if cl[2] == "chat" then
				TriggerClientEvent("cuffsup:chatmode", source);
			end
			if cl[2] == "reset" then
				TriggerClientEvent("cuffsup:reset", source);
			end
		end
	end
end)

---------------------------------------------------------------------------
-- Check This For Maybe Allowed Users?
---------------------------------------------------------------------------
RegisterServerEvent("CheckHandcuff")
AddEventHandler("CheckHandcuff", function(player)
	TriggerClientEvent("cuffsup:handcuff", tonumber(player))
end)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end