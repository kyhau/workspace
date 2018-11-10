# Ubuntu on Windows 10 #

- [Install the Windows Subsystem on Windows 10](
https://docs.microsoft.com/en-us/windows/wsl/install-win10)
- [Install the Docker client on Windows Subsystem for Linux (Ubuntu)](
https://medium.com/@sebagomez/installing-the-docker-client-on-ubuntus-windows-subsystem-for-linux-612b392a44c4)
- [Allow setting the owner and group of files using chmod/chown and modify read/write/execute permissions in WSL](
https://blogs.msdn.microsoft.com/commandline/2018/01/12/chmod-chown-wsl-improvements/)
- [Install bridgy (= ssh + tmux + sshfs + cloud inventory search)](https://github.com/wagoodman/bridgy)

## Update .bashrc

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Use Docker for Windows
PATH="$PATH:/mnt/c/Program\ Files/Docker/Docker/resources/bin"
export DOCKER_HOST=localhost:2375

# https://github.com/wagoodman/bridgy
export PATH=${HOME}/.local/bin:$PATH

alias k-update='sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get -y autoclean'
```
