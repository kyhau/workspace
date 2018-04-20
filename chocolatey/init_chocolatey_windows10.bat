:: Run as Administrator

:: Installing chocolatey from CMD
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
:: OR
:: Installing chocolatey from Powershell
:: Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

:: Packages - see https://chocolatey.org/packages

choco install -y ^
  notepadplusplus ^
  googlechrome ^
  firefox ^
  putty ^
  superputty ^
  keepassxc ^
  git ^
  sourcetree ^
  pycharm-community ^
  cyberduck ^
  docker-for-windows ^
  qgis ^

choco install python3 -y --override --installarguments "'/quiet  InstallAllUsers=1 TargetDir=c:\Python36'"
choco install python2 -y --override --installarguments "'/quiet  InstallAllUsers=1 TargetDir=c:\Python27'"


:: Confirm what have been installed
choco list --localonly
