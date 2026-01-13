. "C:\Users\champuser\AustinBSYS320\week7\Email.ps1"
. "C:\Users\champuser\AustinBSYS320\week7\RiskUsers.ps1"
. "C:\Users\champuser\AustinBSYS320\week7\Scheduler.ps1"
. "C:\Users\champuser\AustinBSYS320\week6\Event-Logs.ps1"

# Obtain config
$configuration = getConfiguration

$Failed = getFailedLogins  $configuration.Days

SendAlertEmail ($Failed | Format-Table | Out-String)

ChooseTimeToRun($configuration.ExecutionTime)