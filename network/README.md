## Installation steps Unzip and place the contents generated in a directory.
The directory is referred as <network>.  
All the commands must be executed from  <network> directory.  
## First time setup instructions ( START)
## First time setup. Run the following commands
 1. Download the binaries
```sh
 . ./download_binaries.sh
```

 2. To Generate the crypto config and other configurations
 ```sh
 . ./generate_artifacts.sh

```

 3. Create the chain code directiory.
```sh

  export NETWORKDIR=`pwd`
  mkdir -p chaincode/github.com/bt
  cd chaincode/github.com/bt
 # Copy the chain code source files here

  go mod vendor
  cd $NETWORKDIR


  export NETWORKDIR=`pwd`
  mkdir -p chaincode/github.com/bt
  cd chaincode/github.com/bt
 # Copy the chain code source files here

  go mod vendor
  cd $NETWORKDIR

```

 4. Start the network  

```sh
  cd docker
  docker-compose up -d
```

 5. Run organization affiliation script for add organization for each orgs
```sh
  docker exec -it ca.<org domain name> bash -e add_affiliation_<org_name>.sh

  docker exec -it ca.serviceProvider bash -e add_affiliation_serviceProvider.sh
  docker exec -it ca.customer bash -e add_affiliation_customer.sh
  docker exec -it ca.legalAuthority bash -e add_affiliation_LegalAuthority.sh
  docker exec -it ca.insuranceCompany bash -e add_affiliation_insuranceCompany.sh
```

 6. Build and join channel. Make sure that network is running

```sh
   docker exec -it cli bash -e ./build_and_join_channel.sh
```

 7. Install and instantiate the chain codes
```sh
   docker exec -it cli bash -e  ./cc_install.sh
```
##  First time setup instructions ( END)


 ## When chain code is modified ( START)
 To update the chain code , first update the chain code source files in the above mentioned directory.
Then run the following commands as appropriate

```sh
  docker exec -it cli bash -e  ./cc_update.sh <version>
```
## When chain code is modified ( END)


## To bring up an existing network ( START)
```
  docker-compose up -d
```
## To bring up an existing network ( END)


##To destory  an existing network ( START)
```
  docker-compose down -v
```
 If you are stoping a network using the above commands ,
 to start the network again , you have to execute steps 2,5,6,7 of the first time setup.
## To destory  an existing network ( END)
