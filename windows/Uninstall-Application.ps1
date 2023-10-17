# https://www.advancedinstaller.com/software-uninstall-with-powershell-package-management.html

$app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match "TODO" }
$app.Uninstall()

# Get-Package -Provider Programs -IncludeWindowsInstaller -Name "Amazon Chime"
# Get-Package -Provider Programs -IncludeWindowsInstaller -Name "Amazon Chime" | Uninstall-Package -Force
