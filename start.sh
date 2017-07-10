#!/bin/bash
yum install expect -y
echo "清空文件"
rm -rf pem
mkdir pem
./run.sh "/CN="`hostname`
rm -rf pem/ca.srl pem/client.csr pem/extfile.cnf pem/server.csr
