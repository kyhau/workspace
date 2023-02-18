# Set up WSL Ubuntu dev environment

- [Install Linux on Windows with WSL](https://docs.microsoft.com/en-us/windows/wsl/install)
    - For WSL 1, install Ubuntu-20.04 distro first (which is WSL 1), then upgrade to Ubuntu-22.04.
- Git clone this repo to `/mnt/c/Workspaces/github/workspace` (note: will change `/mnt/c` to `/c` in a later step)
- Copy or create symlink from personal `.bashrc` to `$HOME/.bashrc`
- Run [init_setup.sh](ubuntu/init_setup.sh), which does
    - Set up `chmod/chown` support
    - Set up Python, Docker, Git, git_secrets, saml2aws, etc.
    - Set symlinks to the corresponding Windows home folders

Useful notes
- [WSL 1 or WSL 2?](https://learn.microsoft.com/en-us/windows/wsl/compare-versions#exceptions-for-using-wsl-1-rather-than-wsl-2)
- To check current distribution and version: `wsl -l -v`
- To converting your distro from WSL 2 back to WSL 1: `wsl --set-version Ubuntu 1`
- Setup `chmod/chown` support: use [`wsl.conf`](ubuntu/wsl.conf) as detailed in
  [Unable to change file permissions on Ubuntu Bash for Windows 10](https://superuser.com/questions/1323645/unable-to-change-file-permissions-on-ubuntu-bash-for-windows-10).
- Note that the `umount/mount` approach in
  [Chmod/Chown WSL Improvements](https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/)
  does not work (error on re-mounting).
- Fixing WSL2 npm issue: "/mnt/c/Program Files/nodejs/npm: /bin/sh^M: bad interpreter" (https://hackmd.io/@badging/wsl2)
    ```bash
    PATH=$(echo "$PATH" | sed -e 's/:\/mnt.*//g') # strip out problematic Windows %PATH%
