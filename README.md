# acronis-rmm
Acronis Cyber Protect Cloud RMM install script (Windows)

This script will download the Cyber Protect installer from a URL and install. It will wait for the service to be installed and then delete the installation file and logs.

I could not figure out a way to download the agent directly from Acronis. But I did not spend much time on it.

4 things to edit

$token : You will need to generate a token for the client. Read the token section in this guide: https://www.acronis.com/en-us/support/documentation/CyberProtectionService/#deploying-agents-through-group-policy.html

$baseurl : This is the site that Acronis directs you to when you login.

$url : You will need to download the web installer from the management console under add devices. You will need to put somewhere that can be easily downloaded. I just used my website.

$dir : This is the working directory to put the setup file and logs during installation. Make it whatever you want.
