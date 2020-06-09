--[[
	CuffsUP originally known as Handcuff and Handsup scripts 
	Version 1.0.0.2
	By BadKaiPanda[NavaRayUK(Rexzooly)] & Xander1998 (X. Cross)
]]--

--[[
	Don't edit this table, it's used for the Keyboard short cuts, start editing from line 31
]]-- 
vKeys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["-"] = 84,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["LShift"] = 155
}
NoteMode = {
	Disabled = 0,			-- Disabled Option
	Chat = 1,				-- Show In Chat Option
	Display = 2				-- Show on screen
}


--[[
	Main config section.
]]-- 
CuffsUP = {
	Version = 	"1.0.0.2",										-- Version needed don't change it or it will brake the updater
	Branch =	"grimly",										-- Branch to check with don't delete or change this.
	Author = "By BadKaiPanda[NavaRayUK(Rexzooly)] & Xander1998 (X. Cross)",   -- Please be respectful and leave this. Default: By BadKaiPanda[NavaRayUK(Rexzooly)] & Xander1998 (X. Cross)
	OverRides = {												-- This is for the true RP users that don't want to see messages for this script, I advice you not to edit this.
		Viewable = true,										-- You can disable it from been shown in chat so only your streamers and RP users can use it - Default: true
		ChatCommand = "cuffsup",								
		ChatInformation = "This function lets RP users pick there notification options",
		ChatArguments = {
			{
				name = "mute, chat, display, reset", 
				help = "Select on of the modes or reset it back to server settings."
			}			
		}
	},
	Note = {													-- This is for the main software, so when a change it done by the client to be shown.
		Enabled = true,											-- Enable or disable normal notifications, but I would say leave this on - Default: true
		Mode = NoteMode.Display									-- Where to show your notifications - Default: NoteMode.Display
	},															-- Modes: NoteMode.Display, NoteMode.Chat, NoteMode.Disabled
	HandsUP = {
		Enabled = true,											-- Enable or disable the hands up function fully Default:true
		Key = {
			Enabled = true,										-- Enable or disable the key option - Default: true
			vKey = vKeys["Y"],									-- This is the key pressed in game, coverted to vKeys Key list at the top - Default:Y
			Ace = {
				Enabled = false,								-- I believe this is pointless but I added it for people that want to stop people using it.
				Warning = {
					Enabled = true,
					Message = "For some reason your unable to up your hands up."
				}
			}
		},
		Command = {
			Ace = {
				Enabled = false,								-- I believe this is pointless but I added it for people that want to stop people using it.
				Warning = {
					Enabled = true,
					Message = "For some reason your unable to up your hands up."
				}
			},
			Enabled = true,										-- Enable and disabled the command fucntionality - Default:true
			ChatCommand = "hu",									-- The command in the chat - Default: hu
			ChatInformation = "Toggle hands up and down.",		-- What it says in the chat when you start typing the command - Default: Toggle hands up and down.
			ChatArguments = false 								-- Leave this fauls unless you have edited the command to accept arugemnts then change this to a table of arugments.
		},
		Note = {
			Mode = NoteMode.Display,							-- Change from NoteMode.Display to NoteMode.Chat or NoteMode.Disabled - Default: NoteMode.Display
			UP = "~r~Your hands are up",						-- The message shown when your hands are up - Default: Your hands are up
			Down = "~g~Your hands are down"						-- The message shown when your hands are down - Default: Your hands are down
		}														-- Note if your using Display use ~ commands, if your using chat use ^ commands.
	},
	Cuffs = {
		Enabled = true,											-- Enable or disable cuffs fucntionality - Default: true
		NPC = true,												-- Can you cuff NPC's or not - Default: true
		Key = {													
			Enabled = true,										-- Enable or disable the key option -Default: true
			vKey = vKeys["U"],									-- This is the key pressed in game, coverted to vKeys Key list at the top - Default:U
			Ace = {
				Enabled = true,
				Warning = {
					Enabled = true,
					Message = "You don't have any cuffs to do that action, maybe your not a officer"
				}
			}			
		},
		Command = {
			Ace = {
				Enabled = true,
				Warning = {
					Enabled = true,
					Message = "You don't have any cuffs to do that action, maybe your not a officer"
				}
			},
			Enabled = true,										-- Enable and disabled the Command fucntionality - Default:true
			ChatCommand = "cuff",								-- The command in the chat - Default: cuff
			ChatInformation = "Toggles the cuffs",				-- What it says in the chat when you start typing the command - Default: Toggles the cuffs.
			ChatArguments = {
				{
					name = "Player ID - Optional",				-- The main option shown when you do /YOURCOMMAND
					help = "If you set this ID, it will override line of sight." -- the help what shows once you do /YOURCOMMAND space
				}
			} 																
		},
		Note = NoteMode.Display	
	
	},
	Grab = {
		Enabled = true,											-- Enable or disable cuffs fucntionality - Default: true
		NPC = true,												-- Can you cuff NPC's or not - Default: true
		Key = {													
			Enabled = true,										-- Enable or disable the key option -Default: true
			vKey = vKeys["-"],									-- This is the key pressed in game, coverted to vKeys Key list at the top - Default:-
			Ace = {
				Enabled = false,
				Warning = {
					Enabled = true,
					Message = "Your grib is no good, your unable to grab people."
				}
			}			
		},
		Command = {
			Ace = {
				Enabled = false,
				Warning = {
					Enabled = true,
					Message = "Your grib is no good, your unable to grab people."
				}
			},
			Enabled = true,										-- Enable and disabled the Command fucntionality - Default:true
			ChatCommand = "grab",								-- The command in the chat - Default: grab
			ChatInformation = "Toggles the grab function",		-- What it says in the chat when you start typing the command - Default: Toggles the grab function.
			ChatArguments = {
				{
					name = "Player ID - Optional",				-- The main option shown when you do /YOURCOMMAND
					help = "If you set this ID, it will override line of sight." -- the help what shows once you do /YOURCOMMAND space
				}
			} 																
		},
		Note = NoteMode.Display	
	
	},
	UseRestriction = false, 									-- Enable or disable the AllowedUsers table.concat - Default: false
	AllowedUsers = {											-- List of users to be allowed to use the command. -- Default: Blank/No Users.
		----------
	},
	Client = { 													-- Don't edit this this is for the client/user cache.
		Note = {
			Mode = nil
		}
	}
}