::choco install -y python3 --version 3.6 --override --installarguments "'/quiet  InstallAllUsers=1 TargetDir=c:\Python36_64'"
choco install -y python3 --override --installarguments "'/quiet  InstallAllUsers=1 TargetDir=c:\Python37'"

C:\Python37\python get-pip.py

:: Add to PATH
:: - C:\Python37
:: - C:\Python37\Scripts
