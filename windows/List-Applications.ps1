# https://www.advancedinstaller.com/software-uninstall-with-powershell-package-management.html
Get-WmiObject -Class Win32_Product | Select-Object -Property Name
