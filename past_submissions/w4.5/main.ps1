# from assignment week4
#..\Apache_Logs.ps1
#Get-Logs "index.html" "404" "Chrome"

#parsing apache logs
. .\Apache_Logs.ps1
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap