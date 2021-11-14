# Acronis Cyber Protect

# Generated a Registration Token for the customer: https://www.acronis.com/en-us/support/documentation/CyberProtectionService/#deploying-agents-through-group-policy.html
$token = "ABCD-EFGH-1234"
# The Base URL when you login to Acronis
$baseurl = "https://us5-cloud.acronis.com/"
# The location of the web installer e.g. CyberProtect_AgentForWindows_web.exe
$url = 'https://www.yourdomain.com/path/to/the/file/CyberProtect_AgentForWindows_web.exe'
# Working Directory
$dir = "C:\IT-Support"

# Make sure our working folder exist
if(!(Test-Path -Path $dir )){
    New-Item -ItemType directory -Path $dir
    Write-Host "New folder created"
} else {   Write-Host "Folder already exists" }

# Download the installer
Invoke-WebRequest -Uri $url -OutFile "$dir\CyberProtect_AgentForWindows_web.exe"

# Build and run the command
$command = "$dir\CyberProtect_AgentForWindows_web.exe"
$parms = "--quiet --log-dir=$dir\AcronisInstall --add-components=agentForWindows,agentForAmp --registration=by-token --reg-token=$token --reg-address=$baseUrl"
$Prms = $Parms.Split( )
& "$command" $Prms

# Cleanup
# Wait for the service to start and delete the setup files

$ServiceName = 'Acronis Agent Core Service'
$val = 1
Do {
    $arrService = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
    if($arrService.Status -eq 'Running'){    
        Write-Host "Service is running. Waiting 30 seconds to make sure everything started up."
        Start-Sleep 30
        Write-Host "Deleting the install files..."
        Remove-Item -Path "$dir\CyberProtect_AgentForWindows_web.exe" -Force
        Remove-Item "$dir\AcronisInstall" -Force  -Recurse
        $val = 2
    } else {
        Write-Host "Service is not running yet. Will check again in 30 seconds."
        Start-Sleep 30
    }
    } UNTIL($val -eq 2)
