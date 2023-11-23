#2022 Chad Schultz
#https://github.com/itoleck/WindowsPerformance

#Administrator access is not needed if your account is member of the 'Performance Log Users' local group.
#Comment below requires statement if this is the case.
#Requires -RunAsAdministrator

$DCSName = "Basic1WeekCollector"
$DCSOS = "Win7-2012"
$DCSTemplate = ("\Templates\{0}\{1}_{2}.xml" -f $DCSOS, $DCSName, $DCSOS)
$DCSParent = (Get-Item (Get-Location)).parent.parent.fullname
$DCSOutputPath = (Select-String -Pattern "<OutputLocation>" -Path ($DCSParent + $DCSTemplate)).ToString().Replace("<OutputLocation>","").Replace("</OutputLocation>","").Trim(" ").Trim("`t")

Write-Output ("Starting Datacollector Set: {0}" -f $DCSName) -ForegroundColor Green

logman.exe import -n $DCSName -xml ($DCSParent + $DCSTemplate)
logman.exe start $DCSName

Write-Output ("Tracing will complete automatically and be saved to {0}" -f $DCSOutputPath) -ForegroundColor Green