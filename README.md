# Quick setup for my development environment 💻

## macOS
- Install Homebrew and some packages with [macos/init-setup-macos.sh](macos/init-setup-macos.sh).
    - [macos/install-homebrew.sh](macos/install-homebrew.sh), if do not have admin right, install things in `${HOME}/Applications/` instead.
    - [macos/install-or-upgrade-apps-macos.sh](macos/install-or-upgrade-apps-macos.sh).
- Set up aliases - [aliases-macos](.aliases-macos).
- Docker:
    - Option 1: Install Docker Desktop with dmg from official website.
    - Option 2: Just install Docker, with `brew install docker`.

## Windows + WSL
- Set up Windows - install [Chocolatey](https://chocolatey.org) and some packages with [Init-chocolatey-windows.bat](./windows/chocolatey/Init-chocolatey-windows.bat)
- [Set up WSL Ubuntu dev environment](./WSL.md)
- [Set up Docker Desktop WSL](./Docker.md)
- [Set up aliases](./.aliases)

## Set up tools for specific development work

- Set up VS Code with my settings and user snippets in [kyhau/vscode-configs](https://github.com/kyhau/vscode-configs)
- Set up `git` config for [multiple GitHub accounts](https://blog.gitguardian.com/8-easy-steps-to-set-up-multiple-git-accounts/)
- Set up `gh` (GitHub CLI) [multi-account switch](https://gist.github.com/yermulnik/017837c01879ed3c7489cc7cf749ae47)
- Some of my scripts for installing [Useful tools for development](./useful-tools/)
- [kyhau/aws-tools](https://github.com/kyhau/aws-tools/) - my tools/scripts for building with AWS

## Locations of some useful files or directories

- Chrome History `%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\History`
- Firefox container file: `%USERPROFILE%\AppData\Roaming\Mozilla\Firefox\Profiles\xx\containers.json`
- GitHub CLI (`gh`) oauth_token location (Windows): `%USERPROFILE%\AppData\Roaming\GitHub CLI`
- GitHub CLI (`gh`) oauth_token location (WSL): `~/.config/gh/hosts.yml`
- Taskbar shortcuts pinned by admin (CustomTaskbarLayoutCollection): `%USERPROFILE%\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml`
- WSL 1 Ubuntu home: `%USERPROFILE%\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_xxx\LocalState\rootfs\home\username`
- WSL 2 Ubuntu home: `\\wsl$\Ubuntu`

### [Some useful links](./quick-notes/UsefulLinks.md)
