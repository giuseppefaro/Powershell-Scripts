

# Common Variable
$ComputerName= Read-host "Type the hostname of the machine you'd like check "
function Get-Gpu-Temp{
    $video_card_name=(Get-WmiObject win32_videocontroller -ComputerName $ComputerName)|select-object -expand name
    write-host $video_card_name 

    $namespace = "root\CIMV2\NV"
    $classname = "ThermalProbe"

    #Write-Host "True"
    Get-WmiObject -ComputerName $ComputerName -Namespace root\CIMV2\NV gpu|select-object name,percent*
 
    # For local system (e.g. "LocalHost", ".") '-computername $computer' could be omitted
    # retrieve all instances of the ThermalProbe class and store them:
    $probes =Get-WmiObject -class $classname -computername $ComputerName -namespace $namespace
    # print all ThermalProbe instances
    $probes
    # iterate through all Probe instances
    foreach( $probe in $probes )
    {
    #"Call the info() method and print all the data"
    $res = $probe.InvokeMethod("info",$Null)
    $res
    #"Query just the temperature"
    #$temp = $probe.temperature
    #$temp
    }
}

function Get-Cpu-Temp{
    $namespace = "root\wmi"
    $classname = "MSAcpi_ThermalZoneTemperature"
    $probes =Get-WmiObject -class $classname -computername $ComputerName -namespace $namespace
}


Get-Gpu-Temp


# wait for input before closing.
#Read-Host -Prompt “Press Enter to exit”