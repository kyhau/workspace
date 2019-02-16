# workspace-win

Install [Chocolatey](https://chocolatey.org) for package management with 
[init_chocolatey_windows10.bat](chocolatey/init_chocolatey_windows10.bat).

- [Python](https://www.python.org/downloads/windows/)
- [Git](https://git-scm.com/download/win)
- [SourceTree](https://www.sourcetreeapp.com/)
- [PyChram](https://www.jetbrains.com/pycharm/)
- [Jupyter](http://jupyter.org/install.html)
- [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
- [SuperPuTTY](https://github.com/jimradford/superputty)
- [Sysinternals Suite](https://technet.microsoft.com/en-us/sysinternals/bb842062.aspx)
- [RDC Man](https://www.microsoft.com/en-au/download/details.aspx?id=44989)
- [AWS-Shell](https://github.com/awslabs/aws-shell)
- [Docker](https://docs.docker.com/docker-for-windows/install/)
  (see also [Turn on Hardware Virtualization on MacBook Pro for Windows using Boot Camp](
  https://apple.stackexchange.com/questions/120361/how-to-turn-on-hardware-virtualization-on-late-2013-macbook-pro-for-windows-8-1?))
- [Notepad++](https://notepad-plus-plus.org/)
- [KeePassXC](https://keepassxc.org/download)
- [S3 Browser](http://s3browser.com/)
- [CyberDuck](https://cyberduck.io)
- [MountainDuck](https://mountainduck.io/)
- [PgAdmin](https://www.pgadmin.org/download/)
- [Postman](https://www.getpostman.com/postman)
- [OpenVPN Client](https://openvpn.net/index.php/open-source/downloads.html)
- [WireShark](https://www.wireshark.org/#download)
- [Dos2Unix](https://sourceforge.net/projects/dos2unix/)
- [kdiff3](http://kdiff3.sourceforge.net/)
- [WindDirStat](https://windirstat.net/)

## Additional set up for Ubuntu on Windows 10

- [Install Ubuntu on Windows 10](https://msdn.microsoft.com/en-au/commandline/wsl/install_guide)

- Resolved: [apt-get update/upgrade/install downloads packages at unacceptably slow speeds](https://github.com/Microsoft/WSL/issues/2477) 

   See `SvenGroot`'s comment on 8 Mar:
   
   > Ubuntu on WSL uses the Ubuntu's main archive mirror, which may not be the fastest option depending on your location. Could those who are having this issue try choosing a local mirror from](https://launchpad.net/ubuntu/+archivemirrors (tip: most countries have a mirror like us.archive.ubuntu.com, so you can try that for your country before scouring the list), updating /etc/apt/sources.list to use that mirror instead of archive.ubuntu.com, and see if that improves your download speed?
