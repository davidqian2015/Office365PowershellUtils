param ([switch]$synconly)
$scb = {
#Force DirSync
Add-PSSnapin Coexistence-Configuration
Start-OnlineCoexistenceSync
Write-Host "DirSync should have started, we will pause 15 seconds and then display event log from SRVMSOL1.  The first entry should show it as completed with ID of 5."
Sleep 30
}
Invoke-Command -ComputerName SRVMSOL1 -ScriptBlock $scb
Get-EventLog -ComputerName SRVMSOL1 -LogName "Application" -Newest 5 -Source "Directory Synchronization"
if (!$synconly) {schtasks /run /tn "WTA\MSOLUserSync" /s SRVMSOL1}