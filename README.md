# Workspace

Quick setup for my development environment

- Set up Windows - install [Chocolatey](https://chocolatey.org) and some packages with [Init-chocolatey-windows.bat](./windows/chocolatey/Init-chocolatey-windows.bat)
- [Set up WSL Ubuntu dev environment](./WSL.md)
- [Set up Docker Desktop WSL](./Docker.md)
- [Set up aliases](./.aliases)
- Some config files
    - [VS Code settings and user snippets](https://github.com/kyhau/vscode-configs)
    - [wsl.conf](./ubuntu/wsl.conf)
- Set up `git` config for [multiple GitHub accounts](https://blog.gitguardian.com/8-easy-steps-to-set-up-multiple-git-accounts/)
- Set up `gh` (GitHub CLI) [multi-account switch](https://gist.github.com/yermulnik/017837c01879ed3c7489cc7cf749ae47)
- Install other tools for specific development work
    - [Useful tools for development](./useful-tools/)
    - [kyhau/aws-tools](https://github.com/kyhau/aws-tools/) - my tools/scripts for building with AWS
- [Locations of some useful files or directories](#locations-of-some-useful-files-or-directories)
- [Some useful links](./UsefulLinks.md)

---
## Locations of some useful files or directories

- Chrome History `%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\History`
- Firefox container file: `%USERPROFILE%\AppData\Roaming\Mozilla\Firefox\Profiles\xx\containers.json`
- Taskbar shortcuts pinned by admin (CustomTaskbarLayoutCollection): `%USERPROFILE%\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml`
- WSL 1 Ubuntu home: `%USERPROFILE%\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_xxx\LocalState\rootfs\home\username`
- WSL 2 Ubuntu home: `\\wsl$\Ubuntu`
- `gh` (GitHub CLI) oauth_token location: `~/.config/gh/hosts.yml`
- `gh` (GitHub CLI) oauth_token location: `%USERPROFILE%\AppData\Roaming\GitHub CLI`
