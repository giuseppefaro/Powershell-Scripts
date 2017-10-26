# This script will install Fonts files copied in the folder C:\Fonts\
# if you are in a Corporate enviorement copy this file in a share folder and 
# configure a Task Manager to run this script every 5 minute with high privileges 
# and using the user "system" to run the job
# Author Giuseppe Faro
# https://github.com/giuseppefaro
# http://www.giuseppefaro.me

$FONTS = 0x14
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
 
$Fontdir = dir C:\Fonts\

foreach($File in $Fontdir) 
{
  if ((Test-Path "C:\Windows\Fonts\$File") -eq $False)
    {
    $objFolder.CopyHere($File.fullname,0x10)
    }
}

# After the installation all the fonts are deleted
Remove-Item C:\Fonts\*
