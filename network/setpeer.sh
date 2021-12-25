
#!/bin/bash
export ORDERER_CA=/opt/ws/crypto-config/ordererOrganizations/orderer.net/msp/tlscacerts/tlsca.orderer.net-cert.pem

#For fabric 2.2.x extra environment variables

export CUSTOMER_PEER0_CA=/opt/ws/crypto-config/peerOrganizations/customer.net/peers/peer0.customer.net/tls/ca.crt

export SERVICEPROVIDER_PEER0_CA=/opt/ws/crypto-config/peerOrganizations/serviceProvider.net/peers/peer0.serviceProvider.net/tls/ca.crt

export INSURANCECOMPANY_PEER0_CA=/opt/ws/crypto-config/peerOrganizations/insuranceCompany.net/peers/peer0.insuranceCompany.net/tls/ca.crt

export LEGALAUTHORITY_PEER0_CA=/opt/ws/crypto-config/peerOrganizations/LegalAuthority.net/peers/peer0.LegalAuthority.net/tls/ca.crt



if [ $# -lt 2 ];then
	echo "Usage : . setpeer.sh Customer|ServiceProvider|InsuranceCompany|LegalAuthority| <peerid>"
fi
export peerId=$2

if [[ $1 = "Customer" ]];then
	echo "Setting to organization Customer peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.customer.net:7051
	export CORE_PEER_LOCALMSPID=CustomerMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/customer.net/peers/$peerId.customer.net/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/customer.net/peers/$peerId.customer.net/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/customer.net/peers/$peerId.customer.net/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/customer.net/users/Admin@customer.net/msp
fi

if [[ $1 = "ServiceProvider" ]];then
	echo "Setting to organization ServiceProvider peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.serviceProvider.net:7051
	export CORE_PEER_LOCALMSPID=ServiceProviderMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/serviceProvider.net/peers/$peerId.serviceProvider.net/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/serviceProvider.net/peers/$peerId.serviceProvider.net/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/serviceProvider.net/peers/$peerId.serviceProvider.net/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/serviceProvider.net/users/Admin@serviceProvider.net/msp
fi

if [[ $1 = "InsuranceCompany" ]];then
	echo "Setting to organization InsuranceCompany peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.insuranceCompany.net:7051
	export CORE_PEER_LOCALMSPID=InsuranceCompanyMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/insuranceCompany.net/peers/$peerId.insuranceCompany.net/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/insuranceCompany.net/peers/$peerId.insuranceCompany.net/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/insuranceCompany.net/peers/$peerId.insuranceCompany.net/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/insuranceCompany.net/users/Admin@insuranceCompany.net/msp
fi

if [[ $1 = "LegalAuthority" ]];then
	echo "Setting to organization LegalAuthority peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.LegalAuthority.net:7051
	export CORE_PEER_LOCALMSPID=LegalAuthorityMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/LegalAuthority.net/peers/$peerId.LegalAuthority.net/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/LegalAuthority.net/peers/$peerId.LegalAuthority.net/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/LegalAuthority.net/peers/$peerId.LegalAuthority.net/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/LegalAuthority.net/users/Admin@LegalAuthority.net/msp
fi

	