# Workspace

Quick setup for my development environment

- [Set up Windows](#set-up-windows)
- [Set up WSL Ubuntu dev environment](#set-up-windows)
- [Set up Docker Desktop WSL](./Docker.md)
- [Useful aliases](./.aliases)
- [Useful tools for development](./useful-tools/)
- My tools/scripts for building with AWS - [kyhau/aws-tools](https://github.com/kyhau/aws-tools/)
- [Locations of some useful files or directories](#locations-of-some-useful-files-or-directories)
- [Some useful links](./Useful-Links.md)

---
## Set up Windows

- Install [Chocolatey](https://chocolatey.org) and some packages with [Init-chocolatey-windows.bat](./windows/chocolatey/Init-chocolatey-windows.bat)

---
## Set up WSL Ubuntu dev environment

- [Install Windows Subsystem for Linux (WSL) on Windows 10](https://msdn.microsoft.com/en-au/commandline/wsl/install_guide)
- Git clone this repo to `/mnt/c/Workspaces/github/workspace` (note: will change `/mnt/c` to `/c` in a later step)
- Copy or create symlink from personal `.bashrc` to `$HOME/.bashrc`
- Run [init_setup.sh](ubuntu/setup/init_setup.sh), which does
    - Set up `chmod/chown` support
    - Set up Python, Docker, Git, git_secrets, saml2aws, etc.
    - Set symlinks to the corresponding Windows home folders

Useful notes
- Check current distribution and version
    ```powershell
    wsl -l -v
    ```
- To converting your distro from WSL 2 back to WSL 1
    ```powershell
    wsl --set-version Ubuntu 1
    ```
- Setup `chmod/chown` support: use [`wsl.conf`](ubuntu/wsl.conf) as detailed in
  [Unable to change file permissions on Ubuntu Bash for Windows 10](https://superuser.com/questions/1323645/unable-to-change-file-permissions-on-ubuntu-bash-for-windows-10).
- Note that the `umount/mount` approach in
  [Chmod/Chown WSL Improvements](https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/)
  does not work (error on re-mounting).
- Fixing WSL2 npm issue: "/mnt/c/Program Files/nodejs/npm: /bin/sh^M: bad interpreter" (https://hackmd.io/@badging/wsl2)
    ```bash
    PATH=$(echo "$PATH" | sed -e 's/:\/mnt.*//g') # strip out problematic Windows %PATH%
    ```

---
## Locations of some useful files or directories

- Chrome History `%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\History`
- Firefox container file: `%USERPROFILE%\AppData\Roaming\Mozilla\Firefox\Profiles\xx\containers.json`
- Taskbar shortcuts pinned by admin (CustomTaskbarLayoutCollection): `%USERPROFILE%\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml`
- WSL 1 Ubuntu home: `%USERPROFILE%\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_xxx\LocalState\rootfs\home\username`
- WSL 2 Ubuntu home: `\\wsl$\Ubuntu`
- GH (GitHub CLI) oauth_token location: `~/.config/gh/hosts.yml`
- GH (GitHub CLI) oauth_token location: `%USERPROFILE%\AppData\Roaming\GitHub CLI`
