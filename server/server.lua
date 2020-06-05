--[[
	CuffsUP originally known as Handcuff and Handsup scripts 
	Version 1.0.0.1
	By BadKaiPanda[NavaRayUK(Rexzooly)] & Xander1998 (X. Cross)
]]--
CuffsUP.Server = {}
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



RegisterCommand("CuffsUP", function(source, commands, raw)
	if type(commands) ~= "nil" then
		if type(commands[1]) ~= "nil" then
			UsedCommand = string.lower(commands[1]);
			if UsedCommand == "version" then
				CuffsUP.CheckVersion(UsedCommand)
			end
			if UsedCommand == "update" then
				CuffsUP.CheckVersion(UsedCommand)
			end
			if UsedCommand == "exit" then
				CuffsUP.Exit()
			end
			if UsedCommand == "reset" then
				CuffsUP.Exit(UsedCommand)
			end
			if UsedCommand == "accept" then
				if CuffsUP.Server.Waiting == "CheckVersion" then
					CuffsUP.CheckVersion(UsedCommand);
				end
				if CuffsUP.Server.Waiting == "reset" then
					CuffsUP.Exit("reset");
				end
			end
			if UsedCommand == "Cache" then
				CuffsUP.UpdateClientCache("", "")
			end
		else
			print("^2CuffsUP: ^0Hands UP and Cuffs mod By ^5BadKaiPanda[NavaRayUK(Rexzooly)] ^0& ^5Xander1998 (X. Cross)")
			print("^2CuffsUP: ^0To use any of the functions please type ^5CuffsUP: ^0and the option you like to run.")
			print("^2CuffsUP: ^0Options are: ^3Update^0, ^3Exit^0, ^3Version^0, ^3Cache[^5Function^3,^5Option^3]^1(Future)^0.")
		end
	end
end)
function CuffsUP.CheckVersion(s_action)
	if type(CuffsUP.Server.Local) == "nil" then
		local WhoAmI = GetCurrentResourceName();
		local LocalVersion = LoadResourceFile(WhoAmI, "cuffsup.txt");
		CuffsUP.Server.Local = json.decode(LocalVersion); 
		print(CuffsUP.Server.Local.Version)
	end
	print("\n^2CuffsUP: ^0Update Manager")
	
	if type(s_action) == "string" and s_action ~= "update" then
		if s_action == "version" then
			IsSupported = "";
			if CuffsUP.Version ~= CuffsUP.Server.Local.Version then
				IsSupported = "^1Unsupported^0";
			else
				IsSupported = "^3Supported^0";
			end
			print("^2CuffsUP: ^0Current version is ^3"..CuffsUP.Version.."^0 and seems to be "..IsSupported);
		end
		if s_action == "accept" and CuffsUP.Server.Waiting == "CheckVersion" then
			PerformHttpRequest("https://raw.githubusercontent.com/rexzooly/CuffsUP/master/cuffsup.txt", function(code, grabthis, headers)
				if code == 200 then
					CuffsUP.Server.Grab = json.decode(grabthis);
					if CuffsUP.Server.Grab.Version ~= CuffsUP.Server.Local.Version then
						print("^2CuffsUP: ^0This script is out of dated, Local: ^1"..CuffsUP.Server.Local.Version.."^0, GitHub: ^2"..CuffsUP.Server.Grab.Version.."^0");
						print("^2CuffsUP: ^0You can find the update at GitHub:^3"..CuffsUP.Server.Grab.Repo.Main.."^0 bitly:^3"..CuffsUP.Server.Grab.Repo.Short.."^0");
					else
						print("^2CuffsUP: ^0Get cuffing, your up to date.^0");
					end
				end
				print("^2CuffsUP: ^0Update check compleated.Please press ^1[Enter]^0 to continue.^0");
				CuffsUP.Server.Waiting = nil;
			end, "GET", json.encode({}), {})
		end
	else
		if type(CuffsUP.Server.Waiting) == "nil" then
			if CuffsUP.Version ~= CuffsUP.Server.Local.Version then
				print("^1CuffsUP: ^0Script version and installed version don't match, unsupported version detected.");
				CuffsUP.Server.Waiting = nil;
				Wait(1000);
				print("^5CuffsUP: ^0Cleaned up and stopped action.");
				return false
			else
				print("^2CuffsUP: ^0Supported Script detected, would you like to check");
				print("^2CuffsUP: ^0for a update?  If yes please type ^5CuffsUP Accept");
				print("^2CuffsUP: ^0if not please type ^5CuffsUP Exit");
				CuffsUP.Server.Waiting = "CheckVersion";
				return true
			end
		else
			print("^1CuffsUP: ^0Awaiting reply to the last command you ran,");
			print("^1CuffsUP: ^0if you want to clear this action please use");
			print("^1CuffsUP: ^5CuffsUP Exit ^0to clean all tasks.");
		end
	end
end
function CuffsUP.Exit(s_action)
	if type(s_action) == "string" and s_action == "reset" then
		if type(CuffsUP.Server.Waiting) ~= "nil" and CuffsUP.Server.Waiting == "reset" then
			CuffsUP.Server = {} -- Clear the full server table
			Wait(100);
			print("^5CuffsUP: ^0Reset Done!")
			return true
		else
			print("^5CuffsUP: ^0This will clear all cashed like a script restarted");
			print("^5CuffsUP: ^0Are you sure?  If yes please type ^5CuffsUP Accept");
			print("^5CuffsUP: ^0if not please type ^5CuffsUP Exit");
			CuffsUP.Server.Waiting = "reset"
			return false
		end
	end
	if CuffsUP.Server.Waiting == nil then
		print("^5CuffsUP: ^0Nothing to clean!")
		Wait(100);
		return false
	end
	print("^5CuffsUP: ^0We are now clearning ....")
	CuffsUP.Server.Waiting = nil
	Wait(500);
	print("^5CuffsUP: ^0Cleaning Done!");
	return true
end
function CuffsUP.UpdateClientCache(s_action, option)
	print("^8CuffsUP: ^0This is a future function, sorry.")
end
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