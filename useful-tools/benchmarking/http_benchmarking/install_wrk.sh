#!/bin/bash
set -e

# Repo: https://github.com/wg/wrk
# Install: https://medium.com/@felipedutratine/intelligent-benchmark-with-wrk-163986c1587f

sudo apt-get install build-essential libssl-dev git -y
git clone https://github.com/wg/wrk.git wrk

cd wrk
sudo make
# move the executable to somewhere in your PATH, ex:
sudo cp wrk /usr/local/bin
cd ..

# E.g. This runs a benchmark for 30 seconds, using 12 threads, and keeping 400 HTTP connections open.
# wrk -t12 -c400 -d30s --latency http://127.0.0.1:8080/index.html

