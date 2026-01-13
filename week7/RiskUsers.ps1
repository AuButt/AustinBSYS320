#keep var const
$Script:Config = [pscustomobject]@{
 Days= 98
 ExecutionTime = "1:19 PM"
}

function readConfiguration {
Write-Host ""
$Config | Format-Table -AutoSize
}

function getConfiguration {
return $Script:Config
}

function changeConfiguration {

    #day
   do {
    $days = Read-Host "Enter the number of days for which the logs will be obtained"
    if ($days -notmatch '^\d+$') {
     Write-Host "Invalid input. Please enter digits only."
  }
 } until ($days -match '^\d+$')

    # AMPM
    do {
    $time = Read-Host "Enter the daily execution time of the script"
    if ($time -notmatch '^\d{1,2}:\d{2}\s(AM|PM)$') {
    Write-Host "Invalid time format. Use format like 1:22 PM"
        }
    }until($time -match '^\d{1,2}:\d{2}\s(AM|PM)$')
    $Script:Config = [pscustomobject]@{
     Day= [int]$days
     ExecutionTime = $time
}
    Write-Host "Configuration Changed"
}

function configurationMenu {

    do {
        Write-Host ""
        Write-Host "Please choose your operation:"
        Write-Host "1 - Show Configuration"
        Write-Host "2 - Change Configuration"
        Write-Host "3 - Exit"
        $choice = Read-Host
        switch ($choice) {
            '1' { readConfiguration }
            '2' { changeConfiguration }
            '3' { exit }
            default {
                Write-Host "Invalid option. Please choose 1, 2, or 3." -ForegroundColor Red
            }
        }

    } while ($true)
}

configurationMenu