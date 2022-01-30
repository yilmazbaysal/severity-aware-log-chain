#!/bin/bash

echo "Building channel for LogStorage"
export CHANNEL_NAME="logstorage"



#Register the channel with orderer

. setpeer.sh Customer peer0
peer channel create -o orderer0.orderer:7050 -c $CHANNEL_NAME -f ./LogStorage.tx --tls true --cafile $ORDERER_CA -t 1000s

# Joining LogStorage for org peers of Customer


. setpeer.sh Customer peer0
peer channel join -b $CHANNEL_NAME.block


. setpeer.sh Customer peer1
peer channel join -b $CHANNEL_NAME.block


#Update the anchor peers for org Customer
. setpeer.sh Customer peer0
peer channel update -o  orderer0.orderer:7050 -c $CHANNEL_NAME -f ./LogStorageCustomerMSPAnchor.tx --tls --cafile $ORDERER_CA

# Joining LogStorage for org peers of ServiceProvider


. setpeer.sh ServiceProvider peer0
peer channel join -b $CHANNEL_NAME.block


. setpeer.sh ServiceProvider peer1
peer channel join -b $CHANNEL_NAME.block


#Update the anchor peers for org ServiceProvider
. setpeer.sh ServiceProvider peer0
peer channel update -o  orderer0.orderer:7050 -c $CHANNEL_NAME -f ./LogStorageServiceProviderMSPAnchor.tx --tls --cafile $ORDERER_CA
