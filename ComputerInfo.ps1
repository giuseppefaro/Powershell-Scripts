# Local System Information 
# Shows details of currently running PC


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


write-host -nonewline "press a button to close "
$response = read-host
if ( $response -ne "Y" ) { exit }
