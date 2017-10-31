# This script is copying the fonts file from the folder C:/Fonts to C:/Windows/Fonts and install Them
# This script works and i tested on Win7 and Win10
# This script requred High Privilege to run and also the Powershell Execution Policy Unrestricted "Get-ExecutionPolicy"
# Author Giuseppe Faro
# https://github.com/giuseppefaro
# http://www.giuseppefaro.me

$FONTS = 0x14
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
 
$Fontdir = dir C:\Fonts\


# Check if the folder exist, if not is creating the folder
if(-not(Test-Path C:\Fonts\))
{
New-Item -ItemType directory -Path C:\Fonts\
}

# for each file in c:/Fonts install them

foreach($File in $Fontdir) 
{
  if ((Test-Path "C:\Windows\Fonts\$File") -eq $False)
    {
    $objFolder.CopyHere($File.fullname,0x10)
    }
}

# remove all the content from the folder C:/Fonts
Remove-Item C:\Fonts\*
