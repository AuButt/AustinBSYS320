
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

function GetFailedLogs(){
  
  #last 10 and failedd, silently contiue allows it to parse thru
  $failedlogins = Get-EventLog Security -InstanceId 4625 -Newest 10 -ErrorAction SilentlyContinue

  if(-not $failedlogins)
  {
    Write-Host "`nNO FAILED LOGINS`n"
    return
  }

  $failedloginsTable = @()
  for($i=0; $i -lt $failedlogins.Count; $i++){

    $account=""
    $domain="" 

    $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
    $usr = $usrlines[1].Split(":")[1].trim()

    $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
    $dmn = $dmnlines[1].Split(":")[1].trim()

    $user = $dmn+"\"+$usr;

    $failedloginsTable += [pscustomobject]@{"Time" = $failedlogins[$i].TimeGenerated; `
                                       "Id" = $failedlogins[$i].InstanceId; `
                                    "Event" = "Failed"; `
                                     "User" = $user;
                                     }

    }

    return $failedloginsTable
}

function GetRiskUsers(){

    $missedAttempts = GetFailedLogs

    $risk = $missedAttempts | Group-Object User | Where-Object {$_.Count -gt 10} | Select-Object @{Name = "User"
    Expression = {$_.Name}}, @{
    Name = "Failed Attempts"
    Expression = {$_.Count}
    }

}
