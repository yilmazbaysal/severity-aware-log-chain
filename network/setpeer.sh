
#!/bin/bash
export ORDERER_CA=/opt/ws/crypto-config/ordererOrganizations/orderer/msp/tlscacerts/tlsca.orderer-cert.pem

#For fabric 2.2.x extra environment variables

export CUSTOMER_PEER0_CA=/opt/ws/crypto-config/peerOrganizations/customer/peers/peer0.customer/tls/ca.crt

export SERVICEPROVIDER_PEER0_CA=/opt/ws/crypto-config/peerOrganizations/serviceProvider/peers/peer0.serviceProvider/tls/ca.crt

export INSURANCECOMPANY_PEER0_CA=/opt/ws/crypto-config/peerOrganizations/insuranceCompany/peers/peer0.insuranceCompany/tls/ca.crt

export LEGALAUTHORITY_PEER0_CA=/opt/ws/crypto-config/peerOrganizations/LegalAuthority/peers/peer0.legalAuthority/tls/ca.crt



if [ $# -lt 2 ];then
	echo "Usage : . setpeer.sh Customer|ServiceProvider|InsuranceCompany|LegalAuthority| <peerid>"
fi
export peerId=$2

if [[ $1 = "Customer" ]];then
	echo "Setting to organization Customer peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.customer:7051
	export CORE_PEER_LOCALMSPID=CustomerMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/customer/peers/$peerId.customer/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/customer/peers/$peerId.customer/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/customer/peers/$peerId.customer/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/customer/users/Admin@customer/msp
fi

if [[ $1 = "ServiceProvider" ]];then
	echo "Setting to organization ServiceProvider peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.serviceProvider:7051
	export CORE_PEER_LOCALMSPID=ServiceProviderMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/serviceProvider/peers/$peerId.serviceProvider/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/serviceProvider/peers/$peerId.serviceProvider/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/serviceProvider/peers/$peerId.serviceProvider/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/serviceProvider/users/Admin@serviceProvider/msp
fi

if [[ $1 = "InsuranceCompany" ]];then
	echo "Setting to organization InsuranceCompany peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.insuranceCompany:7051
	export CORE_PEER_LOCALMSPID=InsuranceCompanyMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/insuranceCompany/peers/$peerId.insuranceCompany/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/insuranceCompany/peers/$peerId.insuranceCompany/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/insuranceCompany/peers/$peerId.insuranceCompany/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/insuranceCompany/users/Admin@insuranceCompany/msp
fi

if [[ $1 = "LegalAuthority" ]];then
	echo "Setting to organization LegalAuthority peer "$peerId
	export CORE_PEER_ADDRESS=$peerId.legalAuthority:7051
	export CORE_PEER_LOCALMSPID=LegalAuthorityMSP
	export CORE_PEER_TLS_CERT_FILE=/opt/ws/crypto-config/peerOrganizations/LegalAuthority/peers/$peerId.legalAuthority/tls/server.crt
	export CORE_PEER_TLS_KEY_FILE=/opt/ws/crypto-config/peerOrganizations/LegalAuthority/peers/$peerId.legalAuthority/tls/server.key
	export CORE_PEER_TLS_ROOTCERT_FILE=/opt/ws/crypto-config/peerOrganizations/LegalAuthority/peers/$peerId.legalAuthority/tls/ca.crt
	export CORE_PEER_MSPCONFIGPATH=/opt/ws/crypto-config/peerOrganizations/LegalAuthority/users/Admin@LegalAuthority/msp
fi
