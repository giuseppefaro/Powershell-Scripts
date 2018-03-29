# This script is userful to remove all the default Appx in windows 10 that are not really useful
# this script will also help to remove them from theprovisioned appx list before run sysprep to create a new image
# Author Giuseppe Faro
# https://github.com/giuseppefaro

$appname = @(
"*Xbox*"
"*ZuneMusic*"
"*ZuneVideo*"
"*candycrushsaga*"
"*officehub*"
"*getstarted*"
"*bingsports*"
"*bingweather*"
"*feedback*"
"*connectivitystore*"
"*marchofEmpires*"
"*minecraft*"

)

ForEach($app in $appname){
Get-AppxProvisionedPackage -Online | where {$_.PackageName -like $app} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue

}

ForEach($app in $appname){
Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
}
