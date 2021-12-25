
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.serviceProvider.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.serviceProvider.net-cert.pem 
fabric-ca-client affiliation add serviceprovider  -u https://admin:adminpw@ca.serviceProvider.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.serviceProvider.net-cert.pem 
