# Quick setup for my development environment 💻

## macOS
- Install Homebrew and some packages with [macos/init-setup-macos.sh](macos/init-setup-macos.sh), which includes calling
    1. [macos/install-homebrew.sh](macos/install-homebrew.sh) - for non-admin setup (install things in `${HOME}/Applications/` instead);
    2. [macos/install-brew-packages.sh](macos/install-brew-packages.sh) - for installing selected apps/packages;
    3. set up general config/dot files;
    4. set up aliases - [.aliases-macos](.aliases-macos);
    5. [macos/update-dev-env.sh](macos/update-dev-env.sh), for additional dev environment setups; e.g., default python/nodejs versions.
- Set up iTerm2
    1. Install iTerm2 with brew
    2. Enable iTerm2 in VS Code integrated terminal (zsh)
    3. Set up [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH) with advanced theme (recommended [Powerlevel10k](https://github.com/romkatv/powerlevel10k))
        - see [useful-tools/oh-my-zsh/install-oh-my-zsh.macos.sh](./useful-tools/oh-my-zsh/install-oh-my-zsh.macos.sh)
- Notes for non-admin setup
    - Two separate Applications folders
        1. `/Applications` usually requires admin to add apps there.
        2. `/Users/<your username>/Applications` is where we typically install additional apps without needing admin right.
    - For non-admin setup, either:
        1. Using Homebrew via CLI. To use Homebrew you must install it as a non-root user, essentially letting Homebrew store it’s tools under your user directory. See this [macos/install-homebrew.sh](macos/install-homebrew.sh).
        2. Websites that provide .dmg files where we drag to the app folder.

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
