![image](https://i.imgur.com/ka4PWLY.png)

# CuffsUP - grimly branch
This version is or will be mostly be broken this is my build I will do when I am testing, this will help me keep the script stable
when I want to try new things but also keep it so you guys are still able to test it.

### Install
clone the resource as a zip to download it, unzip and rename CuffsUP-master to CuffsUP 
place in your resource folder and update your server config
we support the newer format fxmanifest so I believe this will only work on newer servers
in the server config put **ensure CuffsUP** and then save your server config, if the server was
running and you want to tset without a restart do in game **/refresh** and then **/start** CuffsUP in chat or **refresh** and **start** CuffsUP in F8

### Upgrade
Delete the mod fully from your server, you can leave the server config as we wont change the resource name on updates and delete any cache from the server and
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

### How to use
Coming soon. for now please read our FiveM post [Here](https://forum.cfx.re/t/release-cuffsup-originally-known-as-handcuff-and-handsup-scripts-by-xander1998/1319846)

### Fixed
When I was updating this script with all the needed extras to make it what everyone wanted I only saw one problem
and that one of the returned checked for a a verb that wasn't in the script, it was looking for **targetedPlayer** but before it was
setting **targetplayer**, simple fix
