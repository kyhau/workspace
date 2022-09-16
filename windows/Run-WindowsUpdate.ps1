# Get and install Windows Update
# https://answers.microsoft.com/en-us/windows/forum/all/start-windows-update-windows-10-from-command-line/c4bec909-05ac-4b24-a0ab-7a83124923a8

Install-Module PSWindowsUpdate -Force

Get-WindowsUpdate

Install-WindowsUpdate -Confirm:$False
