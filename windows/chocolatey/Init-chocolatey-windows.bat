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
  docker-desktop ^
  firefox ^
  git ^
  github-desktop ^
  golang ^
  jq ^
  nodejs ^
  notepadplusplus ^
  protonvpn ^
  putty ^
  python3 --version 3.10 -override --installarguments "'/quiet InstallAllUsers=1 TargetDir=c:\Python310'" ^
  signal ^
  sysinternals --params "/InstallDir:C:\Sysinternals" ^
  vscode-insiders.install ^
  winrar

:: --- aws
::  awscli-session-manager ^
::  aws-iam-authenticator ^
::  cloudformation-guard --version=1.0.0 ^
::  nosql-workbench ^
::  saml2aws ^

:: --- k8s
::  lens ^
::  kubernetes-helm ^

::  --- Altair GraphQL Client
::  altair-graphql ^

::  activepresenter ^
::  androidstudio ^
::  cyberduck ^
::  dependencywalker ^
::  everything ^
::  gh ^
::  gitkraken ^
::  googlechrome ^
::  graphviz ^
::  itunes ^
::  jre8 ^
::  kdiff3 ^
::  keepassxc ^
::  lazydocker ^
::  nano ^
::  nordvpn ^
::  openvpn --params="'/SELECT_OPENVPNGUI=1'" ^
::  pgadmin4 ^
::  postman ^
::  pycharm-community ^
::  qgis ^
::  rdcman ^
::  slack ^
::  sourcetree ^
::  superputty ^
::  tor-browser ^
::  windirstat ^

:: Install wireshark and winpcap (winpcap is the capture library required for wireshark)
::  winpcap ^
::  wireshark ^

:: Confirm what have been installed
choco list --localonly
