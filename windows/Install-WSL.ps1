# Install WSl manually instead of using Windows Store.
# https://docs.microsoft.com/en-us/windows/wsl/install-manual

Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing

# Don't run this
# Add-AppxPackage Ubuntu.appx

# Run this, see https://github.com/Microsoft/WSL/issues/3437
Rename-Item Ubuntu.appx Ubuntu.zip
unzip Ubuntu.zip
# then run Ubuntu.exe
