![image](https://repository-images.githubusercontent.com/269012299/a9043b00-a715-11ea-8dd5-09a681541028)

# CuffsUP
CuffsUP originally known as Handcuff and Handsup scripts is a hands up and cuffs script originally created by [xander1998](https://github.com/xander1998)
you can find his version right [here](https://github.com/xander1998/cuff-handsup)

With this version you are able to config almost everything in the script

### Install
clone the resource as a zip to download it, unzip and rename CuffsUP-master to CuffsUP 
place in your resource folder and update your server config
we support the newer format fxmanifest so I believe this will only work on newer servers
in the server config put **ensure CuffsUP** and also add the Ace commands

### Ace
```
add_ace group.cubasic cuffsup.hu allow					# Sets up basic, add this but use the config to enable or disable the need for it.
add_ace group.cuofficer cuffsup.cuff allow				# Sets up officers, add this but use the config to enable or disable the need for it.
add_ace group.cuowner cuffsup.boss allow 				# Sets up Owner, this is needed for the owner to fully test all functions.
add_principal group.cuofficer group.cubasic 			# Lets officers put there hands up is basic permssions are on
add_principal group.cuowner group.cuofficer 			# Let Owner of script as officer, good idea for testing.
add_principal group.admin group.cuofficer				# Optional this sets admins as officers.
add_principal group.owner group.cuowner 				# Optional this sets Owner as Owner of the script
#add_principal identifier.steam:110000000000000 group.cubasic  		#Example to add a user to hands up if you enable it, I advice you don't 
#add_principal identifier.steam:110000000000000 group.cuofficer		#Example to add a user as a officer to use /cuffs command no need for basic
#add_principal identifier.steam:110000000000000 group.cuowner		#Example to set users as owner of the script, give them access to all commands no need for officer or basic.
```
then save your server config, if the server was
running and you want to tset without a restart do in game **/refresh** and then **/start** CuffsUP in chat or **refresh** and **start** CuffsUP in F8

### Upgrade
Delete the mod fully from your server delete any cache from the server and
clients then place the newer version in to your resource folder, steps above will help you if you forgot how to do it the first time.

### Changes
* __resource to the new fxmanifest
* Added a large config file for many custom options
* Moved files in to Client and Server folders
* Cleaned or changed the code in much of the script to enable new options

### Added
* Key bindings - **configurable**
* Chat Intormation and Argument Information - **configurable**
* NPC Cuffing - **configurable**
* RP/Streamers client side commands to turn off notifications - **configurable**
* Enable or disabled each section - **configurable**
* Change commands in the config - **configurable**
* Notification options, you can now set them to not show, show on screen or in the chat - **configurable*
* Ace Permissions Support - **configurable**

### How to use
Coming soon. for now please read our FiveM post [Here](https://forum.cfx.re/t/release-cuffsup-originally-known-as-handcuff-and-handsup-scripts-by-xander1998/1319846)


### Note:
CuffsUP as changed in to it's own beast so as much as this was based on [xander1998](https://github.com/xander1998) script to start with please don't pester him at all about anything I have done in this script, please use the issus tab to get help on this script thanks.
