
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.insuranceCompany.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.insuranceCompany.net-cert.pem 
fabric-ca-client affiliation add insurancecompany  -u https://admin:adminpw@ca.insuranceCompany.net:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.insuranceCompany.net-cert.pem 
