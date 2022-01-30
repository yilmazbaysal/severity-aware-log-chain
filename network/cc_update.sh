
#!/bin/sh
export CHANNEL_NAME="LogRecords"
export CC_NAME="test"
export CC_VERSION="2.0"
export CC_SEQ=2

# Retrive last version
. setpeer.sh  Customer peer0

peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name ${CC_NAME} >&clog.txt
export SEQ=$(tail -n 1 clog.txt | awk -F ',' '{ print $2 }'| awk -F ':' '{print $2}')
export NEWSEQ=$((SEQ+1))
export CC_VERSION="${NEWSEQ}.0"
export CC_SEQ=$NEWSEQ
echo "Going to upgrade ${CC_NAME} on ${CHANNEL_NAME} to version ${CC_VERSION} sequence ${CC_SEQ} "


. setpeer.sh  Customer peer0

# Package the chaincode
cd chaincode/github.com/bt
peer lifecycle chaincode package /opt/ws/${CC_NAME}.tar.gz  --path .  --lang golang --label ${CC_NAME}_${CC_VERSION}
cd /opt/ws



# Install the chaincode package
. setpeer.sh Customer peer0
peer lifecycle chaincode install ${CC_NAME}.tar.gz



# Install the chaincode package
. setpeer.sh Customer peer1
peer lifecycle chaincode install ${CC_NAME}.tar.gz



# Install the chaincode package
. setpeer.sh ServiceProvider peer0
peer lifecycle chaincode install ${CC_NAME}.tar.gz



# Install the chaincode package
. setpeer.sh ServiceProvider peer1
peer lifecycle chaincode install ${CC_NAME}.tar.gz



# Install the chaincode package
. setpeer.sh InsuranceCompany peer0
peer lifecycle chaincode install ${CC_NAME}.tar.gz



# Install the chaincode package
. setpeer.sh InsuranceCompany peer1
peer lifecycle chaincode install ${CC_NAME}.tar.gz



# Install the chaincode package
. setpeer.sh LegalAuthority peer0
peer lifecycle chaincode install ${CC_NAME}.tar.gz



# Install the chaincode package
. setpeer.sh LegalAuthority peer1
peer lifecycle chaincode install ${CC_NAME}.tar.gz



# Install the chaincode package
. setpeer.sh LegalAuthority peer2
peer lifecycle chaincode install ${CC_NAME}.tar.gz



# Approve Organization Customer

. setpeer.sh Customer peer0
peer lifecycle chaincode queryinstalled >&cqCustomerlog.txt
PACKAGE_ID=$(sed -n "/${CC_NAME}_${CC_VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" cqCustomerlog.txt)
echo $PACKAGE_ID
peer lifecycle chaincode approveformyorg -o orderer0.orderer:7050  --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CC_NAME --version $CC_VERSION --package-id $PACKAGE_ID --sequence $CC_SEQ --init-required  --signature-policy "  OR( 'CustomerMSP.member' , 'ServiceProviderMSP.member' , 'InsuranceCompanyMSP.member' , 'LegalAuthorityMSP.member')  "



# Approve Organization ServiceProvider

. setpeer.sh ServiceProvider peer0
peer lifecycle chaincode queryinstalled >&cqServiceProviderlog.txt
PACKAGE_ID=$(sed -n "/${CC_NAME}_${CC_VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" cqServiceProviderlog.txt)
echo $PACKAGE_ID
peer lifecycle chaincode approveformyorg -o orderer0.orderer:7050  --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CC_NAME --version $CC_VERSION --package-id $PACKAGE_ID --sequence $CC_SEQ --init-required  --signature-policy "  OR( 'CustomerMSP.member' , 'ServiceProviderMSP.member' , 'InsuranceCompanyMSP.member' , 'LegalAuthorityMSP.member')  "



# Approve Organization InsuranceCompany

. setpeer.sh InsuranceCompany peer0
peer lifecycle chaincode queryinstalled >&cqInsuranceCompanylog.txt
PACKAGE_ID=$(sed -n "/${CC_NAME}_${CC_VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" cqInsuranceCompanylog.txt)
echo $PACKAGE_ID
peer lifecycle chaincode approveformyorg -o orderer0.orderer:7050  --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CC_NAME --version $CC_VERSION --package-id $PACKAGE_ID --sequence $CC_SEQ --init-required  --signature-policy "  OR( 'CustomerMSP.member' , 'ServiceProviderMSP.member' , 'InsuranceCompanyMSP.member' , 'LegalAuthorityMSP.member')  "



# Approve Organization LegalAuthority

. setpeer.sh LegalAuthority peer0
peer lifecycle chaincode queryinstalled >&cqLegalAuthoritylog.txt
PACKAGE_ID=$(sed -n "/${CC_NAME}_${CC_VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" cqLegalAuthoritylog.txt)
echo $PACKAGE_ID
peer lifecycle chaincode approveformyorg -o orderer0.orderer:7050  --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CC_NAME --version $CC_VERSION --package-id $PACKAGE_ID --sequence $CC_SEQ --init-required  --signature-policy "  OR( 'CustomerMSP.member' , 'ServiceProviderMSP.member' , 'InsuranceCompanyMSP.member' , 'LegalAuthorityMSP.member')  "



#Commit chaincode installation

export PEER_CONN=" --peerAddresses peer0.customer:7051 --tlsRootCertFiles ${CUSTOMER_PEER0_CA}  --peerAddresses peer0.serviceProvider:7051 --tlsRootCertFiles ${SERVICEPROVIDER_PEER0_CA}  --peerAddresses peer0.insuranceCompany:7051 --tlsRootCertFiles ${INSURANCECOMPANY_PEER0_CA}  --peerAddresses peer0.legalAuthority:7051 --tlsRootCertFiles ${LEGALAUTHORITY_PEER0_CA} "
peer lifecycle chaincode commit -o orderer0.orderer:7050  --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name $CC_NAME --version $CC_VERSION --sequence $CC_SEQ --init-required --signature-policy "  OR( 'CustomerMSP.member' , 'ServiceProviderMSP.member' , 'InsuranceCompanyMSP.member' , 'LegalAuthorityMSP.member') " $PEER_CONN



#Query commited in Org Customer
. setpeer.sh Customer peer0
peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name ${CC_NAME}



#Query commited in Org ServiceProvider
. setpeer.sh ServiceProvider peer0
peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name ${CC_NAME}



#Query commited in Org InsuranceCompany
. setpeer.sh InsuranceCompany peer0
peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name ${CC_NAME}



#Query commited in Org LegalAuthority
. setpeer.sh LegalAuthority peer0
peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name ${CC_NAME}


sleep 2
#Invoke init
peer chaincode invoke -o orderer0.orderer:7050  --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n ${CC_NAME} $PEER_CONN --isInit -c '{"Args":[""]}'
