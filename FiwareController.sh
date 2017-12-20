#!/bin/sh

# /*************************************************************************
#
#  University of Bristol Confidential
#  __________________
#
#
#  All Rights Reserved.
#
#  NOTICE:  All information contained herein is, and remains
#  the property of University of Bristol and its suppliers,
#  if any.  The intellectual and technical concepts contained
#  herein are proprietary to University of Bristol
#  and its suppliers and may be covered by U.K. and Foreign Patents,
#  patents in process, and are protected by trade secret or copyright law.
#  Dissemination of this information or reproduction of this material
#  is strictly forbidden unless prior written permission is obtained
#  from University of Bristol.
#  /
#
# This is a controller file to run all the scripts in order to deploy fiware IoT stack
# Also by running this file you will install supervisor to control you Fiware components
# Finally this will setup your CentOS machine with all the dependencies required for fiware
# This file was created by HPN and BIO
# Author - Alex Mavromatis: a.mavromatis@bristol.ac.uk
#-------------------------------------#

a=1

read -r -p "Do you want to install Fiware On Click? [y/N]" response
case "$response" in
    [yY][eE][sS]|[yY])
        break
        ;;
    *)
        exit
        ;;
esac


while [ $a -lt 4 ]
do
  case $a in
     1)
        echo "Setting up the Operating System"
        ;;
     2)
        echo "Deploying FIWARE stack"
        ;;
     3)
        echo "Final steps supervisor is being configured"
        ;;
  esac

   sh step${a}.sh | tee -a Logfile${a}.log   #Running the actual scripts and also creating logfiles to debug
   a=`expr $a + 1`

done
