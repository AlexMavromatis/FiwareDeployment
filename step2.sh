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
# Author - Alex Mavromatis
#--------------#

echo "Welcome to Fiware!!!"
sleep 3


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
sleep 4

#yum update Possibly we need to run this to in order to update the dependencies
#Running these in order to unlock yum


#We need to open the os ports so the iotagent will run properly

#echo "Opening ports for fiware!"
echo"------------------------"
sleep 3
iptables -A INPUT -p tcp --match multiport --dports 0:4041 -j ACCEPT
sudo service iptables save
sudo service iptables restart
echo "Done"
# Opening port for fiware not available yet


#---
# Creating the dependencies for mongodb and orion

echo "Installing epel repo..."
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
sudo rpm -Uvh epel-release-latest-6.noarch.rpm

echo "All done!"
sleep 2

echo "Installing git"
yum install git
sleep 2
echo "All done"

#sleeping for 15 second so yum lock will be available for the next proccess
echo "Please wait this will take some seconds..."
sleep 15

echo "Installing curl"
yum install curl
sleep 2
echo "All done"

echo "Initialising repos"
sleep 2

echo "[mongodb-org-2.6]
name=MongoDB 2.6 Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1" > /etc/yum.repos.d/mongodb.repo

echo "[fiware]
name=Fiware Repository
baseurl=http://repositories.lab.fiware.org/repo/rpm/\$releasever
gpgcheck=0
enabled=1" > /etc/yum.repos.d/fiware.repo

echo "Installing mongodb..."
sleep 4
yum clean all
sudo yum install -y mongodb-org
sleep 2
echo "Done"


#sleeping for 15 second so yum lock will be available for the next proccess
echo "Please wait this will take some seconds..."
sleep 15

#----------------------
# Installing orion context broker

echo "Installing OrionContextBroker..."
yum clean all
sudo yum install contextBroker
sleep 4
/etc/init.d/contextBroker start
echo "Done"

#---------------------
# Installing IotAgent

echo "Creating other dependencies..."
sleep 2
curl -sL https://rpm.nodesource.com/setup | bash -
yum clean all
sleep 5
yum install -y nodejs
echo "Installing mqtt services..."

echo "[home_oojah_mqtt]
name=mqtt (CentOS_CentOS-6)
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-6/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-6//repodata/repomd.xml.key
enabled=1" > /etc/yum.repos.d/mosquitto.repo

sleep 4
yum install mosquitto
echo "Mqtt services done..."

yum clean all
yum install npm
sleep 4
cd /opt
sudo git clone https://github.com/telefonicaid/iotagent-json.git
cd iotagent-json
npm install

echo "Iot Agent Installed!!!"
sleep 5
cd ~

#Installing Short Term Historic STH
#---------------------------------

echo "Installing Short Term Historic"
git clone https://github.com/telefonicaid/fiware-sth-comet.git
cd fiware-sth-comet
npm install
sleep 3
echo "All done!"
