[string]$LocalDir = "C:\Python39"

choco install -y python3 --override 3.9 --installarguments "'/quiet InstallAllUsers=1 TargetDir=$LocalDir'"

# Add to PATH
# - C:\Python39
# - C:\Python39\Scripts
Write-Host "Adding $LocalDir and $LocalDir\Scripts to System PATH if not exist..."
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
if ($currentPath -notlike "*$LocalDir*")
{
    $newPath = $currentPath
    if (-not ($newPath.EndsWith(";"))) {  $newPath = $newPath + ";"  }
    $newPath = $newPath + "$LocalDir;$LocalDir/Scripts"
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")
}

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

C:\Python39\python get-pip.py
pip install -U pip
pip install -U virtualenvwrapper-win

# Add an environment variable WORKON_HOME to  C:\Workspaces\.venv-win
[string]$LocalDir = "C:\Workspaces\.venv-win"
Write-Host "Setting WORKON_HOME to $LocalDir..."
[Environment]::SetEnvironmentVariable("WORKON_HOME", $LocalDir, "User")
