# Local System Information 
# Shows details of currently running PC


# Get the ID and security principal of the current user account
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
 
# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
 
# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole))
   {
   # We are running "as Administrator" - so change the title and background color to indicate this
   $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
   $Host.UI.RawUI.BackgroundColor = "DarkBlue"
   clear-host
   }
else
   {
   # We are not running "as Administrator" - so relaunch as administrator
   
   # Create a new process object that starts PowerShell
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   
   # Specify the current script path and name as a parameter
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   
   # Indicate that the process should be elevated
   $newProcess.Verb = "runas";
   
   # Start the new process
   [System.Diagnostics.Process]::Start($newProcess);
   
   # Exit from the current, unelevated, process
   exit
   }
 
# Run your code that needs to be elevated here
Write-Host -NoNewLine "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

$computerSystem = Get-CimInstance CIM_ComputerSystem
$computerBIOS = Get-CimInstance CIM_BIOSElement
$computerOS = Get-CimInstance CIM_OperatingSystem
$computerCPU = Get-CimInstance CIM_Processor
$computerHDD = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID = 'C:'"
$ComputerVideoCard = Get-WmiObject Win32_VideoController
Clear-Host

Write-Host "System Information for: " $computerSystem.Name -BackgroundColor DarkCyan
"Manufacturer: " + $computerSystem.Manufacturer
"Model: " + $computerSystem.Model
"Serial Number: " + $computerBIOS.SerialNumber

$cpuout = New-Object -TypeName PSObject
Foreach ($Card in $computerCPU)
{"CPU: " + $computerCPU.Name
}
$cpuout

"HDD Capacity: "  + "{0:N2}" -f ($computerHDD.Size/1GB) + "GB"
"HDD Space: " + "{0:P2}" -f ($computerHDD.FreeSpace/$computerHDD.Size) + " Free (" + "{0:N2}" -f ($computerHDD.FreeSpace/1GB) + "GB)"
"RAM: " + "{0:N2}" -f ($computerSystem.TotalPhysicalMemory/1MB) + "MB"
"Operating System: " + $computerOS.caption + ", Service Pack: " + $computerOS.ServicePackMajorVersion
"User logged In: " + $computerSystem.UserName
"Last Reboot: " + $computerOS.LastBootUpTime



$Output = New-Object -TypeName PSObject
Foreach ($Card in $ComputerVideoCard)
    {
    $Output | Add-Member NoteProperty "$($Card.DeviceID)_Name" $Card.Name
    $Output | Add-Member NoteProperty "$($Card.DeviceID)_DriverVersion" $Card.DriverVersion
    $Output | Add-Member NoteProperty "$($Card.DeviceID)_Video Card RAM in MB" ($card.AdapterRAM/1MB)
    }
$Output

function Get-Temperature {
    $t = @( Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi" )
    $returntemp = @()

    foreach ($temp in $t)
    {
        $currentTempKelvin = $temp.CurrentTemperature / 10
        $currentTempCelsius = $currentTempKelvin - 273.15

        $currentTempFahrenheit = (9/5) * $currentTempCelsius + 32

        $returntemp += "Cpu Temperature in C : " + $currentTempCelsius.ToString() 
    }
    return $returntemp
    
}

Get-Temperature
echo "Hard Disk Status "
Get-PhysicalDIsk | Get-StorageReliabilityCounter |  Select-Object DeviceID, Temperature,ReadErrorsTotal


write-host -nonewline "press a button to close "
$response = read-host
if ( $response -ne "Y" ) { exit }
