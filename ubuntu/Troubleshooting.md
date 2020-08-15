# Troubleshooting

### "No module named apt_pkg"
Ref: https://stackoverflow.com/questions/13708180/python-dev-installation-error-importerror-no-module-named-apt-pkg/36232975#36232975

```
cd /usr/lib/python3/dist-packages
ln -s apt_pkg.cpython-{36m,37m}-x86_64-linux-gnu.so
ln -s apt_inst.cpython-{36m,37m}-x86_64-linux-gnu.so
ln -s _dbus_glib_bindings.cpython-{36m,37m}-x86_64-linux-gnu.so
ln -s _dbus_bindings.cpython-{36m,37m}-x86_64-linux-gnu.so
cd /usr/lib/python3/dist-packages/gi/
ln -s _gi.cpython-{36m,37m}-x86_64-linux-gnu.so
```

---
### Certificate validation failed when running `apt-get update` to install docker
Ref: https://stackoverflow.com/questions/54901780/error-by-trying-installing-docker-repository-on-linux-ubuntu-18-04-lts

Steps to reproduce the issue:
1. After adding the repository of the docker:
`sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"`
Then get Errors when I update the sources: `sudo apt-get update`

2. Error:
```
Certificate verification failed: The certificate is NOT trusted. The certificate issuer is unknown. Could not 
handshake: Error in the certificate verification. [IP: 54.230.93.95 443]`
```

Solution:
```
touch /etc/apt/apt.conf.d/99verify-peer.conf \
&& echo >>/etc/apt/apt.conf.d/99verify-peer.conf "Acquire { https::Verify-Peer false }"
```
The problem should be gone.

After running whatever update you need
```
rm /etc/apt/apt.conf.d/99verify-peer.conf
```