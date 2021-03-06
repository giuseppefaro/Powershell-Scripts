# This PowerShell Command will query Active Directory and return the computer accounts which have not logged for the past
# 365 days.  You can easily change the number of days from 365 to any number of your choosing.  lastLogonDate is a Human
# Readable conversion of the lastLogonTimeStamp (as far as I am able to discern.  More details about the timestamp can
# be found at technet - http://bit.ly/YpGWXJ  --MWT, 03/12/13

import-module activedirectory
$then = (Get-Date).AddDays(-365) # The 365 is the number of days from today since the last logon.

# This line will show all computer that are older than 365 days that are still enabled
echo "Here the list of computers that match with the Date and are still ENABLED"
Get-ADComputer -Property lastLogonDate,Enabled  -Filter {(lastLogonDate -lt $then) -and (Enabled -eq "true")} | FT Name,lastLogonDate,Enabled
echo ""
echo "Here the list of Disabled computers that match with the Date"
Get-ADComputer -Property lastLogonDate,Enabled  -Filter {(lastLogonDate -lt $then) -and (Enabled -eq "False")} | FT Name,lastLogonDate,Enabled


# If you would like to Disable these computer accounts, uncomment the following line:
#Get-ADComputer -Property Name,lastLogonDate -Filter {lastLogonDate -lt $then} | Set-ADComputer -Enabled $false


# If you would like to Remove these computer accounts, uncomment the following line:
# Get-ADComputer -Property Name,lastLogonDate -Filter {lastLogonDate -lt $then} | Remove-ADComputer
echo done
