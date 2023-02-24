# Docker Desktop WSL

- `DOCKER_HOST`
    - For WSL 2, unset `DOCKER_HOST`, see https://stackoverflow.com/questions/60708229/wsl2-cannot-connect-to-the-docker-daemon
    - For WSL 1, export `DOCKER_HOST=tcp://localhost:2375`
- For WSL 1, within the Hyper-V VM, the `C:` is mounted to `/c` instead of `/mnt/c`.
    ```bash
    $ sudo mkdir /c
    $ sudo mount --bind /mnt/c /c
    ```
    - See https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly
    - See https://github.com/microsoft/WSL/issues/1854#issuecomment-291845122
    - See https://github.com/aws/aws-sam-cli/issues/208
    - Volume mounts in Windows does not work? https://forums.docker.com/t/volume-mounts-in-windows-does-not-work/10693/18
- Docker Desktop settings
    - General
        - Expose daemon
        - Use Docker Compose V2
    - Docker Engine
        ```
        {
          "builder": {
            "gc": {
              "defaultKeepStorage": "20GB",
              "enabled": true
            }
          },
          "experimental": false,
          "features": {
            "buildkit": true
          }
        }
        ```
- docker-compose
    - To install: `pip install docker-compose`
    - If see error `docker.credentials.errors.InitializationError: docker-credential-desktop.exe not installed or not available in PATH`
        - Add `_` before `credsStore` in file ~/.docker/config.json, i.e. `{"_credsStore":"desktop.exe"}`
- If see error [`no matching manifest for windows/amd64 in the manifest list entries`](https://stackoverflow.com/questions/48066994/docker-no-matching-manifest-for-windows-amd64-in-the-manifest-list-entries)
    - Go to Settings: Daemon, Advanced
    - Set the "experimental": true
    - Restart Docker
- For MacBook Pro Windows user, see [Turn on Hardware Virtualization on MacBook Pro for Windows using Boot Camp](https://apple.stackexchange.com/questions/120361/how-to-turn-on-hardware-virtualization-on-late-2013-macbook-pro-for-windows-8-1?).
