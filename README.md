# Workspace

Install [Chocolatey](https://chocolatey.org) for package management and install some packages with 
[init_chocolatey_windows10.bat](chocolatey/init_chocolatey_windows10.bat).

## Ubuntu on Windows 10

- [Install Windows Subsystem for Linux (WSL) on Windows 10](
  https://msdn.microsoft.com/en-au/commandline/wsl/install_guide).
- Set symbolic links to the corresponding Windows home folders:
  - `~/.aws`  (`ln -s /mnt/c/Users/xxxx/.aws`)
  - [`~/.bashrc`](ubuntu/.bashrc)
  - `~/.ssh/` (`ln -s /mnt/c/Users/xxxx/.ssh`)
- [`~/.bashrc`](ubuntu/.bashrc) includes
    - [Running Docker on WSL](
      https://davidburela.wordpress.com/2018/06/27/running-docker-on-wsl-windows-subsystem-for-linux/)
    - [Speed up Ubuntu update process](
      https://github.com/Microsoft/WSL/issues/2477)
    - Setup `virutalenvwrapper`
- Setup Python: [`setup_python.sh`](python/setup_python.sh)
- See also "[Chmod/Chown WSL Improvements](
  https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/)".

## Useful packages

- [AWS-Shell](https://github.com/awslabs/aws-shell)
- [CyberDuck](https://cyberduck.io)
- [DependencyWalker](http://www.dependencywalker.com)
- [Docker](https://docs.docker.com/docker-for-windows/install)
- [Dos2Unix](https://sourceforge.net/projects/dos2unix)
- [Git](https://git-scm.com/download/win)
- [Jupyter](http://jupyter.org/install.html)
- [kdiff3](http://kdiff3.sourceforge.net)
- [KeePassXC](https://keepassxc.org/download)
- [MountainDuck](https://mountainduck.io)
- [Node.js](https://nodejs.org)
- [Notepad++](https://notepad-plus-plus.org)
- [OpenVPN Client](https://openvpn.net/index.php/open-source/downloads.html)
- [PgAdmin](https://www.pgadmin.org/download)
- [Postman](https://www.getpostman.com/postman)
- [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
- [PyChram](https://www.jetbrains.com/pycharm)
- [Python](https://www.python.org/downloads/windows)
- [RDC Man](https://www.microsoft.com/en-au/download/details.aspx?id=44989)
- [S3 Browser](http://s3browser.com)
- [SourceTree](https://www.sourcetreeapp.com)
- [SuperPuTTY](https://github.com/jimradford/superputty)
- [Sysinternals Suite](https://technet.microsoft.com/en-us/sysinternals/bb842062.aspx)
- [WireShark](https://www.wireshark.org/#download)
- [WindDirStat](https://windirstat.net)

## Docker-for-Windows

- https://forums.docker.com/t/volume-mounts-in-windows-does-not-work/10693/18

- For MacBook Pro Windows user, see also
  "[Turn on Hardware Virtualization on MacBook Pro for Windows using Boot Camp](
  https://apple.stackexchange.com/questions/120361/how-to-turn-on-hardware-virtualization-on-late-2013-macbook-pro-for-windows-8-1?)".
