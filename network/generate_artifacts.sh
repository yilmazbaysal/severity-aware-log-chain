
#!/bin/bash -e
export PWD=`pwd`

export FABRIC_CFG_PATH=$PWD
export ARCH=$(uname -s)
export CRYPTOGEN=$PWD/bin/cryptogen
export CONFIGTXGEN=$PWD/bin/configtxgen

function generateArtifacts() {

	echo " *********** Generating artifacts ************ "
	echo " *********** Deleting old certificates ******* "

        rm -rf ./crypto-config

        echo " ************ Generating certificates ********* "

        $CRYPTOGEN generate --config=$FABRIC_CFG_PATH/crypto-config.yaml

        echo " ************ Generating tx files ************ "

		$CONFIGTXGEN -profile OrdererGenesis -channelID system-channel -outputBlock ./genesis.block

		$CONFIGTXGEN -profile InfoLogs -outputCreateChannelTx ./infologs.tx -channelID infologs

		echo "Generating anchor peers tx files for  Customer"
		$CONFIGTXGEN -profile InfoLogs -outputAnchorPeersUpdate  ./infologsCustomerMSPAnchor.tx -channelID infologs -asOrg CustomerMSP

		echo "Generating anchor peers tx files for  ServiceProvider"
		$CONFIGTXGEN -profile InfoLogs -outputAnchorPeersUpdate  ./infologsServiceProviderMSPAnchor.tx -channelID infologs -asOrg ServiceProviderMSP



		$CONFIGTXGEN -profile ImportantLogs -outputCreateChannelTx ./importantlogs.tx -channelID importantlogs

		echo "Generating anchor peers tx files for  Customer"
		$CONFIGTXGEN -profile ImportantLogs -outputAnchorPeersUpdate  ./importantlogsCustomerMSPAnchor.tx -channelID importantlogs -asOrg CustomerMSP

		echo "Generating anchor peers tx files for  ServiceProvider"
		$CONFIGTXGEN -profile ImportantLogs -outputAnchorPeersUpdate  ./importantlogsServiceProviderMSPAnchor.tx -channelID importantlogs -asOrg ServiceProviderMSP

		echo "Generating anchor peers tx files for  InsuranceCompany"
		$CONFIGTXGEN -profile ImportantLogs -outputAnchorPeersUpdate  ./importantlogsInsuranceCompanyMSPAnchor.tx -channelID importantlogs -asOrg InsuranceCompanyMSP

		echo "Generating anchor peers tx files for  LegalAuthority"
		$CONFIGTXGEN -profile ImportantLogs -outputAnchorPeersUpdate  ./importantlogsLegalAuthorityMSPAnchor.tx -channelID importantlogs -asOrg LegalAuthorityMSP




}
function generateDockerComposeFile(){
	OPTS="-i"
	if [ "$ARCH" = "Darwin" ]; then
		OPTS="-it"
	fi
	cp  docker/docker-compose-template.yaml  docker/docker-compose.yaml


	cd  crypto-config/peerOrganizations/customer.net/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/CUSTOMER_PRIVATE_KEY/${PRIV_KEY}/g"  docker/docker-compose.yaml


	cd  crypto-config/peerOrganizations/serviceProvider.net/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/SERVICEPROVIDER_PRIVATE_KEY/${PRIV_KEY}/g"  docker/docker-compose.yaml


	cd  crypto-config/peerOrganizations/insuranceCompany.net/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/INSURANCECOMPANY_PRIVATE_KEY/${PRIV_KEY}/g"  docker/docker-compose.yaml


	cd  crypto-config/peerOrganizations/LegalAuthority.net/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/LEGALAUTHORITY_PRIVATE_KEY/${PRIV_KEY}/g"  docker/docker-compose.yaml

}
generateArtifacts
cd $PWD
generateDockerComposeFile
cd $PWD


mkdir ca-customer
touch ca-customer/fabric-ca-server.db


mkdir ca-serviceprovider
touch ca-serviceprovider/fabric-ca-server.db


mkdir ca-insurancecompany
touch ca-insurancecompany/fabric-ca-server.db


mkdir ca-legalauthority
touch ca-legalauthority/fabric-ca-server.db
