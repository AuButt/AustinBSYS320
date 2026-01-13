function Midterm1IOC {
#ASK PROF ABT SERVER
    $response = Invoke-WebRequest -TimeoutSec 5 "http://10.0.17.6/IOC.html"
    Write-Host "CANT FIND PAGE"
    if($response -eq $null){exit}
    $rows = $response.ParsedHtml.getElementsByTagName("tr") | Select-Object -Skip 1

     "{0,-15} {1}" -f "Pattern", "Explanation"
     "{0,-15} {1}" -f "-------", "-----------"

     foreach ($row in $rows) {
    $cells = $row.getElementsByTagName("td")
    if ($cells.length -ge 2) {
    $pattern = $cells[0].innerText.Trim()
    $description = $cells[1].innerText.Trim()
    "{0,-15} {1}" -f $pattern, $description
     }
   }
}

function Midterm2AL {
#Parsing Apache Logs
$logsNotformatted = Get-Content C:\Users\champuser\AustinBSYS320\midterm\access.log
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
}
}
return $tableRecords
}

function Midterm2AL {
#Parsing Apache Logs
$logsNotformatted = Get-Content C:\Users\champuser\AustinBSYS320\midterm\access.log
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
}
}
return $tableRecords
}

function Midterm3AL([string[]]$Filters, $logsPath){
#Parsing Apache Logs
$logsNotformatted = Get-Content $logsPath 
$tableRecords = @()
for($i = 0; $i -lt $logsNotformatted.Count; $i++) {
$words = $logsNotformatted[$i].Split(" ");

$record = [pscustomobject]@{
"IP" = $words[0]
"Time" = $words[3].Trim('[')
"Method" = $words[5].Trim("")
"Page" = $words[6];
"Protocol" = $words[7].Trim("")
"Response" = $words[8]
"Referrer" = $words[10]
}
foreach ($filter in $Filters) {
 if ($record.Page -like "*$filter*") {
       $tableRecords += $record
          break
       }
    }

}
return $tableRecords
}
# for Deliverable 2 run below
#Midterm2AL | Format-Table -AutoSize
$sorttxt = @(
"cmd=",
"/bin/bash",
"/etc/passwd",
"backdoor",
"reverseshell"
)
$path = "C:\Users\champuser\AustinBSYS320\midterm\access.log"

#midterm 3 assignment
Midterm3AL $sorttxt  $path|Format-Table -AutoSize
