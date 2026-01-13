do {
    Clear-Host
    Write-Host "1. Display last 10 apache logs"
    Write-Host "2. Display last 10 failed logins for all users"
    Write-Host "3. Display at risk users"
    Write-Host "4. Start Chrome and open champlain.edu"
    Write-Host "5. Exit"
    Write-Host "--------------------------------------------------"

    $choice = Read-Host "Enter a choice (1-5)"

    if ($choice -notmatch '^[1-5]$') {
        Write-Host "Invalid input. Please enter a number between 1 and 5."
        Pause
        continue
   }

    switch ($choice) {

        '1' {
            Write-Host "`nLast 10 Apache Logs:`n"
            #run func
            ApacheLogs1 | Select-Object -Last 10 | Format-Table -AutoSize -Wrap
            Pause
        }

        '2' {
        Write-Host "`nLast 10 Failed Logins:`n"
        GetFailedLogs | Select-Object -Last 10 | Format-Table -AutoSize -Wrap
        Pause
}

        '3' {
            Write-Host "`nAt Risk Users:`n"
        GetRiskUsers | Format-Table -AutoSize -Wrap
        Pause
        }

        '4' {
            $chromeRunning = Get-Process chrome -ErrorAction SilentlyContinue

            if (-not $chromeRunning) {
                Write-Host "Starting Chrome and navigating to champlain.edu..."
            Start-Process "chrome.exe" "https://www.champlain.edu"
            }
            else {
            Write-Host "Chrome is already running."
            }
            Pause
        }
        '5' {
            Write-Host "Exiting program..."
       }
    }
} while ($choice -ne '5')


