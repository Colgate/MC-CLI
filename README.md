MC-CLI
======

Command-Line-Interface for bukkit servers

###Description###
This is a simple sh/bash script I wrote to control bukkit servers in a Linux environment. Basic commands include

* start - Can either start or send .unhold to the server, depending on if the script finds the process running.
* stop - Sends .hold to the server.
* attach - Attach to the current screen the server is running on.
* restart - Sends the commands to restart the server.
* reload - Sends the command to reload the server files.
* send - Sends a command to be executed through the console.
* kill - Sends .stopwrapper and completely ends the mc server processes.
* status - Prints basic server status information

###System Requirements###
To run this script, you will need the following

* Root access.
* Basic understanding of the Linux filesystem.
* One or more bukkit servers located in a directory named /servers/
* Remote Toolkit server administration module - https://forums.bukkit.org/threads/admn-remotetoolkit-r10-a14-restarts-crash-detection-auto-saves-remote-console-1-5-1.674/page-13

###Installation Instructions###
1. Copy the contents of mccli.sh to the /sbin/ directory. You can name this file anything you want (on my server, I named the command "server").
2. Ensure your directory structure for your server directories is /servers/%SERVERNAME%. Alternatively, you may change this path to wherever your servers are located.
3. Start your server using the CLI script to ensure the correct process IDs are stored.

###Screenshots###
![](http://content.screencast.com/users/ColgateMinuette/folders/Jing/media/91389c4a-3230-4b6c-a62b-7573c1bf5d55/2013-07-29_0418.png)
