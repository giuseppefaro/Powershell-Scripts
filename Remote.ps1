# This script help you to remote connect to a Windows Machine using Powershell #
# Author Giuseppe Faro       
#
$computer = Read-host "Type the Computer name you want remote into"
write-host""
Enter-PSSession -ComputerName $computer -Credential $env:UserDomain\$env:UserName
# Wait for input before closing
# Read-Host -Prompt "Press Enter to exit"

