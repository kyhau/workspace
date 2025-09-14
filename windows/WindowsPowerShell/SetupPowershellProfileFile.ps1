# Recreate the Powershell Profile file
New-Item -Path $Profile -Type File -Force

$workspacesHome = 'C:\Workspaces'
if (Test-Path '$workspacesHome') {
  $workspacesHome = $workspacesHome
} elseif (Test-Path '$env:USERPROFILE\Workspaces') {
  $workspacesHome = '$env:USERPROFILE\Workspaces'
}

# Add content to the Profile file to load the custom Profile file.
if (Test-Path $workspacesHome\github\workspace\windows\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -PathType Leaf) {
  Add-Content -Path $Profile -Value ". $workspacesHome\github\workspace\windows\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`n"
}
