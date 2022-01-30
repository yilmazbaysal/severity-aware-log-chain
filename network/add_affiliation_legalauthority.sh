
#!/bin/bash
fabric-ca-client enroll  -u https://admin:adminpw@ca.legalAuthority:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.legalAuthority-cert.pem
fabric-ca-client affiliation add legalauthority  -u https://admin:adminpw@ca.legalAuthority:7054 --tls.certfiles /etc/hyperledger/fabric-ca-server-config/ca.legalAuthority-cert.pem
