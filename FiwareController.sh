#!/bin/sh

# This is a controller file to run all the files in order to deploy fiware IoT stack
# Also by running this file you will install supervisor to control you Fiware components
# Finally this will setup your centos machine with all the dependencies needed for fiware
# This file was created by HPN and BIO
#-------------------------------------#


a=1
while [ $a -lt 4 ]
do
  case $i in
     1)
        echo "Setting up the Operating System \n"
        ;;
     2)
        echo "Deploying FIWARE stack \n"
        ;;
     3)
        echo "Final steps supervisor is being configured"
        ;;
  esac
   bash step${a}.sh
   a=`expr $a + 1`
done
