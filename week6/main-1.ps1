. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Exit`n"
$Prompt += "10 - List At Risk Users`n"


$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 9){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"
        if(checkUser $name)
        {
            Write-Host "User exists" | Out-String
            continue
        }

        if(-not(checkPassword $password))
        {
            Write-Host "Password does not work" | Out-String
            continue
        }


        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"
        
        # Done: Check the given username with the checkUser function.
        if(-not(checkUser $name))
        {
            Write-Host "User Does not exist" | Out-String
            continue
        }
        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"
if(-not(checkUser $name))
        {
            Write-Host "User Does not exist" | Out-String
            continue
        }
        # DONE: Check the given username with the checkUser function.

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # DONE: Check the given username with the checkUser function.
if(-not(checkUser $name))
        {
            Write-Host "User Does not exist" | Out-String
            continue
        }
        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"
if(-not(checkUser $name))
        {
            Write-Host "User Does not exist" | Out-String
            continue
        }
        # DONE: Check the given username with the checkUser function.

        $userLogins = getLogInAndOffs $days
        # DONE: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"
if(-not(checkUser $name))
        {
            Write-Host "User Does not exist" | Out-String
            continue
        }
        # DONE: Check the given username with the checkUser function.

        $userLogins = getFailedLogins $days
        # DONE: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }

elseif($choice -eq 10){
    $daysgiven = Read-Host -Prompt "Check users from ? many days ago?"
    $daysgiven = [int]$days

    $missedAttempts = getFailedLogins $daysgiven

    $risk = $missedAttempts | Group-Object User | Where-Object {$_.Count -gt 10} | Select-Object @{Name = "User"
    Expression = {$_.Name}}, @{
    Name = "Failed Attempts"
    Expression = {$_.Count}
    }
}

else{
    Write-Host "Please enter a valid number" | Out-String
}
    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    
    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    




    }