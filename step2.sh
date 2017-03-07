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
# This is a shell script for deploying fiware IoT stack in Centos 6.6
# After running this script all the dependencies and the fiware components must be Installed
# This documents is a property of High Performance Networks Group
#--------------#



echo "Welcome to Fiware!!!"
sleep 2
read -r -p "Are you sure you want to install Fiware? [y/N]" response
case "$response" in
    [yY][eE][sS]|[yY])
        break
        ;;
    *)
        exit
        ;;
esac

echo " We are now creating the dependencies ...."
echo " Setting up enviroment"
sleep 2

# yum update Possibly we need to run this in order to update the dependencies
# Running these in order to unlock yum
# We need to open the os ports so the iotagent will run properly

echo "Opening system ports and Initialising iptables for fiware!"
echo "------------------------"
sleep 3
sudo iptables -A INPUT -p tcp --match multiport --dports 0:4041 -j ACCEPT
sudo service iptables save
sudo service iptables restart
echo "Done"
# Opening port for fiware not available yet
#---
# Creating the dependencies for mongodb and orion

echo "Installing epel repo..."
wget $epel
sudo rpm -Uvh epel-release-latest-6.noarch.rpm

echo "All done!"
sleep 2

echo "Installing git"
yum install git
sleep 2
echo "All done"

#sleeping for 10 second so yum lock will be available for the next proccess
echo "Please wait this will take some seconds..."
sleep 10

echo "Installing curl"
yum install curl
sleep 2
echo "All done"

echo "Initialising repos"
sleep 2

echo "[mongodb-org-2.6]
name=MongoDB 2.6 Repository
baseurl= $mongo
gpgcheck=0
enabled=1" > /etc/yum.repos.d/mongodb.repo

echo "[fiware]
name=Fiware Repository
baseurl= $fiware
gpgcheck=0
enabled=1" > /etc/yum.repos.d/fiware.repo

echo "Installing mongodb..."
sleep 4
yum clean all
sudo yum install -y mongodb-org
sleep 2
echo "Done"


#sleeping for 10 second so yum lock will be available for the next proccess
echo "Please wait this will take some seconds..."
sleep 10

#----------------------
# Installing orion context broker

echo "Installing OrionContextBroker..."
yum clean all
sudo yum install contextBroker
sleep 2
/etc/init.d/contextBroker start
echo "Done"

#---------------------
# Installing IotAgent

echo "Creating other dependencies..."
sleep 2
curl -sL https://rpm.nodesource.com/setup | bash -
yum clean all
sleep 2
yum install -y nodejs
echo "Installing mqtt services..."

echo "[home_oojah_mqtt]
name=mqtt (CentOS_CentOS-6)
type=rpm-md
baseurl= $mosquitto1
gpgcheck=1
gpgkey= $mosquitto2
enabled=1" > /etc/yum.repos.d/mosquitto.repo

sleep 2
yum install mosquitto
echo "Mqtt services done..."

yum clean all
yum install npm
sleep 2
cd /opt
sudo git clone $iotagentRepo
cd iotagent-json
npm install

echo "Iot Agent Installed!!!"
sleep 3
cd ~

#Installing Short Term Historic STH
#---------------------------------
echo "Installing Short Term Historic"
git clone $sthRepo
cd fiware-sth-comet
npm install

sleep 4
echo "All done!"
