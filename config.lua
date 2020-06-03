--[[
	Cuff-HandsUP
	Version 1.0.0.0
	By BadKaiPanda[NavaRayUK(Rexzooly)] & Xander1998 (X. Cross)
]]--

--[[
	Don't edit this table, it's used for the Keyboard short cuts.
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
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


--[[
	Main config section.
]]-- 
CHConfig = {	
	HandsUP = {
		Enabled = true,											-- Enable or disable the hands up function fully Default:true
		Key = {
			Enabled = true,										-- Enable or disable the key option - Default: true
			vKey = vKeys["Y"]									-- This is the key pressed in game, coverted to vKeys Key list at the top - Default:Y
		},
		Command = {
			Enabled = true,										-- Enable and disabled the command fucntionality - Default:true
			ChatCommand = "hu",									-- The command in the chat - Default: hu
			ChatInformation = "Toggle hands up and down.",		-- What it says in the chat when you start typing the command - Default: Toggle hands up and down.
			ChatArguments = false 								-- Leave this fauls unless you have edited the command to accept arugemnts then change this to a table of arugments.
		}
	},
	Cuffs = {
		Enabled = true,
		Key = {
			Enabled = true,
			vKey = vKeys["U"]
		},
		Command = {
			Enabled = true,										-- Enable and disabled the Command fucntionality - Default:true
			ChatCommand = "cuff",								-- The command in the chat - Default: cuff
			ChatInformation = "Toggles the cuffs",				-- What it says in the chat when you start typing the command - Default: Toggle hands up and down.
			ChatArguments = false 								-- Leave this fauls unless you have edited the command to accept arugemnts then change this to a table of arugments.			
		}
	
	},
	UseRestriction = false, 	-- Enable or disable the AllowedUsers table.concat - Default: false
	AllowedUsers = {			-- List of users to be allowed to use the command. -- Default: Blank/No Users.
		----------
	}	
}