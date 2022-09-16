# what your computer thinks its ip address is
# https://askubuntu.com/questions/430853/how-do-i-find-my-internal-ip-address
# 8.8.8.8 is google dns
ip route get 8.8.8.8 | awk '{print $NF; exit}'
