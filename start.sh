#!/bin/bash
echo "清空文件"
rm -rf pem
mkdir pem
./run.sh "/CN=1.host.bjike.com"
rm -rf pem/ca.srl pem/client.csr pem/extfile.cnf pem/server.csr
