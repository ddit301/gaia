
cd \usr\local\Cellar\openssl@1.1\1.1.1k\local_cert
pause
openssl genrsa -aes256 -out localhost_private.key 4096
openssl req -new -key localhost_private.key -out localhost.csr -config /private/etc/ssl/openssl.cnf
openssl x509 -req -days 1825 -in localhost.csr -out localhost.crt -CA ../rootCA/rootca.crt -CAcreateserial -CAkey ../rootCA/rootca_private.key -extensions v3_req -extfile /private/etc/ssl/openssl.cnf
openssl pkcs12 -export -in localhost.crt -inkey localhost_private.key -aes256 -out keystore -name "tomcat cert" -CAfile ../rootCA/rootca.crt -caname root -chain