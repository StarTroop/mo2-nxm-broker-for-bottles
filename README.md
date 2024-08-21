# MO2 NXM Broker for Bottles
A broker for multiple Mod Organizer instances in Bottles to receive download links from Nexus Mods.  
It is a fork of rockerbacon's [modorganizer2-linux-installer handlers](https://github.com/rockerbacon/modorganizer2-linux-installer/tree/master/handlers). I have made minor modifications to fix a bug and to make it work with Bottles installations. If you are trying to run Mod Organizer through Steam, check out the aforementioned project as I can't provide support for that.

# Prerequisites
## [Install Bottles through Flatpak](https://usebottles.com/download/)
I won't go into detail about this, but this guide is intended for the Flatpak version of Bottles. It's technically possible to modify the script to work with other methods of managing Wine, but you'll have to figure that out yourself.
## Install your game and [Mod Organizer 2](https://github.com/ModOrganizer2/modorganizer)
It should go without saying that you'll need to install thses things. Follow Bottles' guides if you don't know how to do this. I recommend installing a portable instance of MO2 for each game you want to mod, and have game and its appropriate MO2 instance contained in the same Bottle. It may be possible to separate or combine many games and instances across many or just one Bottle, but I don't recommend over-complicating things. Ensure you register your MO2 instance with your Nexus credentials.

**As of writing, the current version of Mod Organizer 2 is v2.5.2 and is confirmed to work in Linux with Wine/Proton.**

## Ensure you have dependencies installed
- bash (or compatible shell)
- zenity (probably installed everywhere, not really important and I may remove dependancy in the future)

# Installation Guide
## Step 1
### Download/copy the two files in this repo
- Put `modorganizer2-nxm-handler.desktop` in `~/.local/share/applications/`.
- Put `modorganizer2-nxm-broker.sh` in `~/.local/share/scripts/`. (You can put this wherever you want, but be sure to modify the file path in `modorganizer2-nxm-handler.desktop` to match.)
## Step 2
### Configure each instance of MO2 you want recognised by the broker
#### Make a symlink in `~/.config/modorganizer2/` to the MO2 installation folder, with the name of the relevant game's Nexus Game ID. 
- The game ID can be found in the URL of said game's main page on nexusmods.com.
- For example: `https://www.nexusmods.com/skyrimspecialedition`, here `skyrimspecialedition` is the Nexus Game ID.
- To make a symlink in a terminal emulator, run `$ ln -s /path/to/MO2/folder ~/.config/modorganizer2/nexus_game_id`.
- For example: `$ ln -s ~/.var/app/com.usebottles.bottles/data/bottles/bottles/Skyrim/drive_c/Skyrim/MO2 ~/.config/modorganizer2/skyrimspecialedition`
- The symlink should contain the whole MO2 installation, including `ModOrganizer.exe` and `nxmhandler.exe`.
- This will be your **MO2 Instance** for that particular game.
#### Make a file named `bottle.txt` in the MO2 Instance
- Fill the document with the name of the Bottle which contains your MO2 Instance. **Nothing Else**.
- For example: For a Bottle named "Skyrim", the contents of the document should be `SKyrim`.
## Step 3
### Finish set-up
- Set the handler as the default application with `$ xdg-mime default modorganizer2-nxm-handler.desktop x-scheme-handler/nxm` in a terminal.
- Make the broker script executable with `$ chmod +x "~/.local/share/scripts/modorganizer2-nxm-broker.sh"` in a terminal (or whatever filepath you decided to use).
- Within Mod Organizer settings, click `Associate with "Download with manager" links`. (This may not be necessary but do it anyways.)
## Step 4
- At this point you should be good to go. Try to download a file from Nexus Mods for an appropriate game, and if your browser asks to pick a default application to open the links, pick `modorganizer2-nxm-handler.desktop`.

# Notes
- Although I'm only supporting the Flatpak version of Bottles, you should be able to use a conventionally-installed version of Bottles by modifying `modorganizer2-nxm-broker.sh` to delete `flatpak run --command=` from line 34.
- If you don't know where your Bottles are, the Flatpak version puts them in `~/.var/app/com.usebottles.bottles/data/bottles/bottles`.
- To be honest, I've only tested this with one game/MO2 instance, but I have no reason to believe that it won't work properly with other games.
- Since future versions of Bottles will eventually default to installing many programs to a single Bottle, I will try to support any similar use cases, but I still hold to my recommendation of separate instances per Bottle.
