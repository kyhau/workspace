:: Run as Administrator

:: Installing chocolatey from CMD
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
:: OR
:: Installing chocolatey from Powershell
:: Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Packages - see https://chocolatey.org/packages

choco install -y ^
  awscli ^
  awstools.powershell ^
  docker-for-windows ^
  firefox ^
  git ^
  gitkraken ^
  itunes ^
  jq ^
  nano ^
  nodejs ^
  notepadplusplus ^
  nordvpn ^
  protonvpn ^
  putty ^
  pycharm-community ^
  python3 --version 3.8 -override --installarguments "'/quiet InstallAllUsers=1 TargetDir=c:\Python38'" ^
  signal ^
  sysinternals --params "/InstallDir:C:\Sysinternals" ^
  vscode-insiders.install ^
  winrar
::  activepresenter ^
::  avastfreeantivirus ^
::  cloudformation-guard --version=1.0.0 ^
::  cyberduck ^
::  dependencywalker ^
::  everything ^
::  gh ^
::  golang ^
::  googlechrome ^
::  google-backup-and-sync ^
::  graphviz ^
::  jre8 ^
::  kdiff3 ^
::  keepassxc ^
::  lazydocker ^
::  nosql-workbench ^
::  openvpn --params="'/SELECT_OPENVPNGUI=1'" ^
::  pgadmin4 ^
::  postman ^
::  qgis ^
::  rdcman ^
::  saml2aws ^
::  slack ^
::  sourcetree ^
::  superputty ^
::  windirstat ^

:: Install wireshark and winpcap (winpcap is the capture library required for wireshark)
::  winpcap ^
::  wireshark ^

:: Confirm what have been installed
choco list --localonly
