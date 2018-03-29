
# Common Variable
$ComputerName= Read-host "Type the hostname of the machine you'd like check "
Write-Output ""

function Get-Gpu-Temp{
    $video_card_name=(Get-WmiObject win32_videocontroller -ComputerName $ComputerName)|select-object -expand name
    write-host $video_card_name 

    $namespace = "root\CIMV2\NV"
    $classname = "ThermalProbe"

    #Write-Host "True"
    Get-WmiObject -ComputerName $ComputerName -Namespace root\CIMV2\NV gpu|select-object name,percent*
 
    $probes = Get-WmiObject -class $classname -computername $ComputerName -namespace $namespace
    # print all ThermalProbe instances
    $probes = $probes.Temperature
    Write-Output ""
    Write-Output "GPU temperature for $Computername is $probes Celsius"
 
}
Get-Gpu-Temp

# wait for input before closing.
#Read-Host -Prompt “Press Enter to exit”