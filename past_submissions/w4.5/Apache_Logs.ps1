function Get-Logs{
    param([string]$ref,
          [string]$http,
           [string]$browser)

    $path = "C:\xampp\apache\logs\access.log"

    Get-Content $path |
    Select-String $ref |
    Select-String $http |
    Select-String $browser |
    Group-Object |
    Select-Object Name, Count

}

#Parsing Apache Logs
function ApacheLogs1(){
$logsNotformatted = Get-Content C:\xampp\apache\logs\access.log
$tableRecords = @()

for($i = 0; $i -lt $logsNotformatted.Count; $i++) {
$words = $logsNotformatted[$i].Split(" ");

$tableRecords += [pscustomobject]@{
"IP" = $words[0]
"Time" = $words[3].Trim('[')
"Method" = $words[5].Trim("")
"Page" = $words[6];
"Protocol" = $words[7].Trim("")
"Response" = $words[8]
"Referrer" = $words[10]
"Client" = $words[11..($words.ounct - 1)];
}
}
return $tableRecords | Where-Object {$_.IP -like "10.*"}
}