# Workspace

Install [Chocolatey](https://chocolatey.org) for package management and install some packages with
[init_chocolatey_windows10.bat](chocolatey/init_chocolatey_windows10.bat).

## Ubuntu on Windows 10

- [Install Windows Subsystem for Linux (WSL) on Windows 10](
  https://msdn.microsoft.com/en-au/commandline/wsl/install_guide).
- Git clone this repo to `/mnt/c/Workspaces/github/workspace`.
- Copy personal `.bashrc` to `$HOME/.bashrc`
- Create symlink `ln -s /mnt/c/Workspaces/github/workspace/ubuntu/.bashrc $HOME/.bashrc`
- Run [init_setup.sh](ubuntu/setup/init_setup.sh), which does
    - Set up `chmod/chown` support
    - Set up Python, Docker, Git, git_secrets, saml2aws, etc.
    - Set symlinks to the corresponding Windows home folders

Useful links
- Setup `chmod/chown` support: use [`wsl.conf`](ubuntu/wsl.conf) as detailed in
  [Unable to change file permissions on Ubuntu Bash for Windows 10](
  https://superuser.com/questions/1323645/unable-to-change-file-permissions-on-ubuntu-bash-for-windows-10).
- Note that the `umount/mount` approach in
  [Chmod/Chown WSL Improvements](
  https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/)
  does not work (error on re-mounting).

## Docker-for-Windows

- For MacBook Pro Windows user, see
  [Turn on Hardware Virtualization on MacBook Pro for Windows using Boot Camp](
  https://apple.stackexchange.com/questions/120361/how-to-turn-on-hardware-virtualization-on-late-2013-macbook-pro-for-windows-8-1?).
- https://forums.docker.com/t/volume-mounts-in-windows-does-not-work/10693/18

## Locations of some useful files or directories

- Chrome History `%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\History`
- Firefox container file: `%USERPROFILE%\AppData\Roaming\Mozilla\Firefox\Profiles\xx\containers.json`
- Taskbar shortcuts pinned by admin (CustomTaskbarLayoutCollection): `%USERPROFILE%\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml`
- Ubuntu home: `%USERPROFILE%\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_xxx\LocalState\rootfs\home\username`
