#!/bin/bash

echo "Building channel for InfoLogs"
export CHANNEL_NAME="InfoLogs"



#Register the channel with orderer

. setpeer.sh Customer peer0
peer channel create -o orderer0.orderer.net:7050 -c $CHANNEL_NAME -f ./InfoLogs.tx --tls true --cafile $ORDERER_CA -t 1000s

# Joining InfoLogs for org peers of Customer


. setpeer.sh Customer peer0
peer channel join -b $CHANNEL_NAME.block


. setpeer.sh Customer peer1
peer channel join -b $CHANNEL_NAME.block


#Update the anchor peers for org Customer
. setpeer.sh Customer peer0
peer channel update -o  orderer0.orderer.net:7050 -c $CHANNEL_NAME -f ./InfoLogsCustomerMSPAnchor.tx --tls --cafile $ORDERER_CA

# Joining InfoLogs for org peers of ServiceProvider


. setpeer.sh ServiceProvider peer0
peer channel join -b $CHANNEL_NAME.block


. setpeer.sh ServiceProvider peer1
peer channel join -b $CHANNEL_NAME.block


#Update the anchor peers for org ServiceProvider
. setpeer.sh ServiceProvider peer0
peer channel update -o  orderer0.orderer.net:7050 -c $CHANNEL_NAME -f ./InfoLogsServiceProviderMSPAnchor.tx --tls --cafile $ORDERER_CA


#
#
#
#!/bin/bash
echo "Building channel for ImportantLogs"
export CHANNEL_NAME="ImportantLogs"



#Register the channel with orderer

. setpeer.sh Customer peer0
peer channel create -o orderer0.orderer.net:7050 -c $CHANNEL_NAME -f ./ImportantLogs.tx --tls true --cafile $ORDERER_CA -t 1000s

# Joining ImportantLogs for org peers of Customer


. setpeer.sh Customer peer0
peer channel join -b $CHANNEL_NAME.block


. setpeer.sh Customer peer1
peer channel join -b $CHANNEL_NAME.block


#Update the anchor peers for org Customer
. setpeer.sh Customer peer0
peer channel update -o  orderer0.orderer.net:7050 -c $CHANNEL_NAME -f ./ImportantLogsCustomerMSPAnchor.tx --tls --cafile $ORDERER_CA

# Joining ImportantLogs for org peers of ServiceProvider


. setpeer.sh ServiceProvider peer0
peer channel join -b $CHANNEL_NAME.block


. setpeer.sh ServiceProvider peer1
peer channel join -b $CHANNEL_NAME.block


#Update the anchor peers for org ServiceProvider
. setpeer.sh ServiceProvider peer0
peer channel update -o  orderer0.orderer.net:7050 -c $CHANNEL_NAME -f ./ImportantLogsServiceProviderMSPAnchor.tx --tls --cafile $ORDERER_CA

# Joining ImportantLogs for org peers of InsuranceCompany


. setpeer.sh InsuranceCompany peer0
peer channel join -b $CHANNEL_NAME.block


. setpeer.sh InsuranceCompany peer1
peer channel join -b $CHANNEL_NAME.block


#Update the anchor peers for org InsuranceCompany
. setpeer.sh InsuranceCompany peer0
peer channel update -o  orderer0.orderer.net:7050 -c $CHANNEL_NAME -f ./ImportantLogsInsuranceCompanyMSPAnchor.tx --tls --cafile $ORDERER_CA

# Joining ImportantLogs for org peers of LegalAuthority


. setpeer.sh LegalAuthority peer0
peer channel join -b $CHANNEL_NAME.block


. setpeer.sh LegalAuthority peer1
peer channel join -b $CHANNEL_NAME.block


. setpeer.sh LegalAuthority peer2
peer channel join -b $CHANNEL_NAME.block


#Update the anchor peers for org LegalAuthority
. setpeer.sh LegalAuthority peer0
peer channel update -o  orderer0.orderer.net:7050 -c $CHANNEL_NAME -f ./ImportantLogsLegalAuthorityMSPAnchor.tx --tls --cafile $ORDERER_CA
