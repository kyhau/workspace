# See https://stackoverflow.com/questions/54901780/error-by-trying-installing-docker-repository-on-linux-ubuntu-18-04-lts

# runas root

touch /etc/apt/apt.conf.d/99verify-peer.conf \
&& echo >>/etc/apt/apt.conf.d/99verify-peer.conf "Acquire { https::Verify-Peer false }"
