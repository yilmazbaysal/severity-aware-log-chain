
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


		$CONFIGTXGEN -profile LogStorage -outputCreateChannelTx ./logStorage.tx -channelID logstorage

		echo "Generating anchor peers tx files for  Customer"
		$CONFIGTXGEN -profile LogStorage -outputAnchorPeersUpdate  ./logStorageCustomerMSPAnchor.tx -channelID logstorage -asOrg CustomerMSP

		echo "Generating anchor peers tx files for  ServiceProvider"
		$CONFIGTXGEN -profile LogStorage -outputAnchorPeersUpdate  ./logStorageServiceProviderMSPAnchor.tx -channelID logstorage -asOrg ServiceProviderMSP

		echo "Generating anchor peers tx files for  InsuranceCompany"
		$CONFIGTXGEN -profile LogStorage -outputAnchorPeersUpdate  ./logStorageInsuranceCompanyMSPAnchor.tx -channelID logstorage -asOrg InsuranceCompanyMSP

		echo "Generating anchor peers tx files for  LegalAuthority"
		$CONFIGTXGEN -profile LogStorage -outputAnchorPeersUpdate  ./logStorageLegalAuthorityMSPAnchor.tx -channelID logstorage -asOrg LegalAuthorityMSP




}
function generateDockerComposeFile(){
	OPTS="-i"
	if [ "$ARCH" = "Darwin" ]; then
		OPTS="-it"
	fi
	cp  docker/docker-compose-template.yaml  docker/docker-compose.yaml


	cd  crypto-config/peerOrganizations/customer/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/CUSTOMER_PRIVATE_KEY/${PRIV_KEY}/g"  docker/docker-compose.yaml


	cd  crypto-config/peerOrganizations/serviceProvider/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/SERVICEPROVIDER_PRIVATE_KEY/${PRIV_KEY}/g"  docker/docker-compose.yaml


	cd  crypto-config/peerOrganizations/insuranceCompany/ca
	PRIV_KEY=$(ls *_sk)
	cd ../../../../
	sed $OPTS "s/INSURANCECOMPANY_PRIVATE_KEY/${PRIV_KEY}/g"  docker/docker-compose.yaml


	cd  crypto-config/peerOrganizations/LegalAuthority/ca
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
