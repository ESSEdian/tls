#!/bin/bash
yum install expect -y
echo "清空文件"
rm -rf pem
mkdir pem
#./run.sh "/CN="`hostname`
#./run.sh "/CN="`ifconfig eth0 | grep "inet" | awk '{ print $2}' | sed -n '1p;1q'`
./run.sh
