:: Run as Administrator

:: Installing chocolatey from CMD
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
:: OR
:: Installing chocolatey from Powershell
:: Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Packages - see https://chocolatey.org/packages

choco install -y ^
  avastfreeantivirus ^
  cyberduck ^
  docker-for-windows ^
  firefox ^
  git ^
  gitkraken ^
  itunes^
  notepadplusplus ^
  nordvpn ^
  putty ^
  pycharm-community ^
  rdcman ^
  saml2aws ^
  signal ^
  slack ^
  superputty ^
  sysinternals --params "/InstallDir:C:\Sysinternals" ^
  winrar
::  activepresenter ^
::  dependencywalker ^
::  googlechrome ^
::  google-backup-and-sync ^
::  jre8 ^
::  kdiff3 ^
::  keepassxc ^
::  openvpn --params="'/SELECT_OPENVPNGUI=1'" ^
::  pgadmin4 ^
::  postman ^
::  qgis ^
::  sourcetree ^
::  wireshark ^
::  windirstat

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Dev
::choco install -y python3 --version 3.6 --override --installarguments "'/quiet  InstallAllUsers=1 TargetDir=c:\Python36_64'"
choco install -y python3 --override --installarguments "'/quiet  InstallAllUsers=1 TargetDir=c:\Python37'"

::choco install -y nodejs

::choco install -y sbt scala

:: Confirm what have been installed
choco list --localonly
