#!/bin/expect
set host [lindex $argv 0];#获取Comm Name
set timeout -1    ;#脚本超时时间
set pas admin123   ;#密码
set day_time 365   ;#过期时间
set extfile [exec sh -c {echo extendedKeyUsage=clientAuth > pem/extfile.cnf}]
#set extfileServer [exec sh -c {echo subjectAltName=IP:1270.0.1,IP:172.16.0.3 > pem/extfileServer.cnf}]
spawn openssl genrsa -aes256 -out pem/ca-key.pem 4096
expect "ca-key.pem:"
send "$pas\r"
expect "ca-key.pem:"
send "$pas\r"
expect -exact "#"
spawn openssl req -new -x509 -days $day_time -key pem/ca-key.pem -sha256 -subj $host -out pem/ca.pem
expect "ca-key.pem:"
send "$pas\r"
expect -exact "#"
spawn openssl genrsa -out pem/server-key.pem 4096
expect -exact "#"
spawn openssl req -subj $host -sha256 -new -key pem/server-key.pem -out pem/server.csr
expect -exact "#"
#spawn openssl x509 -req -days $day_time -sha256 -in pem/server.csr -CA pem/ca.pem -CAkey pem/ca-key.pem -CAcreateserial -out pem/server-cert.pem -extfile pem/extfileServer.cnf
spawn openssl x509 -req -days $day_time -sha256 -in pem/server.csr -CA pem/ca.pem -CAkey pem/ca-key.pem -CAcreateserial -out pem/server-cert.pem
expect "ca-key.pem:"
send "$pas\r"
spawn openssl genrsa -out pem/key.pem 4096
expect "ca-key.pem:"
send "$pas\r"
spawn openssl genrsa -out pem/key.pem 4096
expect -exact "#"
spawn openssl req -subj "/CN=client" -new -key pem/key.pem -out pem/client.csr
expect -exact "#"
spawn openssl x509 -req -days $day_time -sha256 -in pem/client.csr -CA pem/ca.pem -CAkey pem/ca-key.pem -CAcreateserial -out pem/cert.pem -extfile pem/extfile.cnf
expect "ca-key.pem:"
send "$pas\r"
expect eof
