:: Run as Administrator

:: Installing chocolatey from CMD
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
:: OR
:: Installing chocolatey from Powershell
:: Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

:: Packages - see https://chocolatey.org/packages

choco install -y ^
  avastfreeantivirus ^
  nordvpn ^
  notepadplusplus ^
  googlechrome ^
  firefox ^
  signal ^
  putty ^
  superputty ^
  rdcman ^
  keepassxc ^
  git ^
  sourcetree ^
  pycharm-community ^
  jre8 ^
  docker-for-windows ^
  cyberduck ^
  postman ^
  kdiff3 ^
  pgadmin4 ^
  winrar ^
  wireshark ^
  windirstat ^
  qgis


:: Dev - nodejs
choco install -y nodejs

:: Dev - scala
choco install -y sbt scala

choco install -y openvpn --params="'/SELECT_OPENVPNGUI=1'"
choco install -y python3 --override --installarguments "'/quiet  InstallAllUsers=1 TargetDir=c:\Python36'"
choco install -y python2 --override --installarguments "'/quiet  InstallAllUsers=1 TargetDir=c:\Python27'"


:: Confirm what have been installed
choco list --localonly
