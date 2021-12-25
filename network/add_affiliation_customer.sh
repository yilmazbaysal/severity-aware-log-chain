
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.customer.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.customer.net-cert.pem 
fabric-ca-client affiliation add customer  -u https://admin:adminpw@ca.customer.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.customer.net-cert.pem 
