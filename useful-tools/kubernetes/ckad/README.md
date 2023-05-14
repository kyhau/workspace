# CKAD

Jump to
- [Resources allowed](#resources-allowed)
- [Pre-setup](#pre-setup)
- [Useful commands](#useful-commands)


---
## Resources allowed
- Documents installed by the distribution (i.e. `/usr/share` and its subdirectories)
- Use Packages that are part of the distribution (may also be installed by Candidate if not available by default)
- Use the browser within the VM to access the following documentation:
    - https://kubernetes.io/docs/
    - https://kubernetes.io/blog/
    - https://helm.sh/docs


---
## Pre-setup
```
$ sudo apt install nano

####
# Auto completion
$ alias k='kubectl'
$ source <(kubectl completion bash)
$ echo "source <(kubectl completion bash)" >> ~/.bashrc
$ complete -F __start_kubectl k
```


---
## Useful commands
```
# list running processes
$ ps -aux

# search for string in the output
$ ps -aux | grep -i 'string'

# search for multiple expressions in the output (exp can be plain a string too)
$ ps -aux | grep -e 'exp-one' -e 'exp-two'

# get details about network interfaces
$ ifconfig

# list network interfaces and their IP address
$ ip a

# get the route details
$ ip r

# check service status and also show logs
$ systemctl status kubelet

# restart a service
$ systemctl restart kubelet

# reload the service daemon, if you changed the service file
$ systemctl daemon reload

# detailed logs of the service
$ journalctl -u kubelet

# list out ports, protocol and what processes are listening on those ports
$ netstat -tunlp
```


---
