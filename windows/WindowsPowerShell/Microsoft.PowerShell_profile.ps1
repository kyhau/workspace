Write-Host("Started loading " + $MyInvocation.MyCommand.Definition + "...")

$workspacesHome = $env:USERPROFILE
if (Test-Path 'C:\Workspaces') {
  $workspacesHome = 'C:\Workspaces'
} elseif (Test-Path '$env:USERPROFILE\Workspaces') {
  $workspacesHome = '$env:USERPROFILE\Workspaces'
}
Set-Location $workspacesHome

$psScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition


###############################################################################
# Check ExecutionPolicy
$currExePolicy = Get-ExecutionPolicy
if ($currExePolicy -eq [Microsoft.PowerShell.ExecutionPolicy]::Bypass) {
  if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
  {
    Write-Warning "You do not have Administrator rights to change ExecutionPolicy!`nPlease re-run this script as an Administrator!"
  }
  #Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
  #Set-ExecutionPolicy -ExecutionPolicy AllSigned
  #Set-ExecutionPolicy -ExecutionPolicy Unrestricted
  Set-ExecutionPolicy -ExecutionPolicy Bypass
  $currExePolicy = Get-ExecutionPolicy
}
Write-Host("* Checking ExecutionPolicy... " + $currExePolicy);


###############################################################################
# Rename title indicating custom configuration applied
$psTitle = (Get-Host).UI.RawUI.WindowTitle
(Get-Host).UI.RawUI.WindowTitle = $env:USERNAME + "'s $psTitle -'.'-"


###############################################################################
# Set aliases
Write-Host "* Setting aliases..."

Set-Alias -Name edit -Value "$env:ProgramFiles\Notepad++\notepad++.exe"
Set-Alias -Name grep -Value 'findstr'
Set-Alias -Name ll -Value ls

Function Start-TheDay { Start firefox; Start code; Start slack; }
Set-Alias -Name k-start-theday -Value Start-TheDay

Function Get-Env-Path { $env:path }
Set-Alias -Name k-env-path -Value Get-Env-Path

Function Get-Env-Path-Nice { $a = $env:path; $a.Split(";")  }
Set-Alias -Name k-env-path-nice -Value Get-Env-Path-Nice

Function Start-ISE-RunAsAdmin { Start-Process PowerShell_ISE -Verb RunAs }
Set-Alias -Name k-ps-ise-runas-admin -Value Start-ISE-RunAsAdmin

Function FindDefaultPrinter { Get-WMIObject -query "Select * From Win32_Printer Where Default = TRUE" }
Set-Alias -Name k-printer -Value FindDefaultPrinter

Function Start-PS-RunAsAdmin { Start-Process PowerShell -Verb RunAs }
Set-Alias -Name k-ps-runas-admin -Value Start-PS-RunAsAdmin

Function Remove-StoppedContainers { docker container rm $(docker container ls -q) }
Set-Alias -Name k-docker-rm-stopped-containers  -Value Remove-StoppedContainers

Function Remove-AllContainers { docker container rm -f $(docker container ls -aq) }
Set-Alias -Name k-docker-rm-all-containers -Value Remove-AllContainers

Function Get-ContainerIPAddress { param ([string] $id) & docker inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $id }
Set-Alias -Name k-docker-get-container-ip -Value Get-ContainerIPAddress

Function Delete-Cache-Pip { Remove-Item $env:LocalAppData\pip\Cache -Recurse}
Set-Alias -Name k-delete-cache-pip -Value Delete-Cache-Pip

if (Test-Path 'C:\Program Files\Microsoft VS Code Insiders\Code - Insiders.exe' -PathType Leaf) {
  Function Start-Code { Start-Process code-insiders }
  Set-Alias -Name code -Value Start-Code
}

if (Test-Path $workspacesHome\github\workspace -PathType Container) {
  Set-Alias -Name pip-upgrade-all -Value '$workspacesHome\github\workspace\useful-tools\python\run_pip_upgrade_all.bat'
}

if (Test-Path $workspacesHome\github\vscode-configs -PathType Container) {
  Set-Alias -Name code-diff-settings -Value '$workspacesHome\github\workspace\vscode\vscode-diff-settings.bat'
  Set-Alias -Name code-configs-backup -Value '$workspacesHome\github\vscode-configs\vscode-backup-configs.bat'
  Set-Alias -Name code-configs-restore-from-backup -Value '$workspacesHome\github\vscode-configs\vscode-restore-configs-from-backup.bat'
}


###############################################################################
# Color scheme

# Pane color
# $a = (Get-Host).UI.RawUI
# $a.ForegroundColor = "black"
# $a.BackgroundColor = "white"

# Message color
Write-Host "* Setting message colors..."

$a = (Get-Host).PrivateData
$a.ErrorForegroundColor    = "red"
$a.ErrorBackgroundColor    = "black"
$a.WarningForegroundColor  = "yellow"
$a.WarningBackgroundColor  = "white"
$a.DebugForegroundColor    = "magenta"
$a.DebugBackgroundColor    = "white"
$a.VerboseForegroundColor  = "cyan"
$a.VerboseBackgroundColor  = "white"
$a.ProgressForegroundColor = "green"
$a.ProgressBackgroundColor = "white"


###############################################################################
# Exiting
Write-Host("Finished loading all startup scripts.`n")
