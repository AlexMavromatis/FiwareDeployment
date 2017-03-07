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

epel="https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm"
EXPORT epel

mongo="http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/"
EXPORT mongo

fiware="http://repositories.lab.fiware.org/repo/rpm/\$releasever"
EXPORT fiware

mosquitto1="http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-6/"
EXPORT mosquitto1

mosquitto2="http://download.opensuse.org/repositories/home:/oojah:/mqtt/CentOS_CentOS-6//repodata/repomd.xml.key"
EXPORT mosquitto2

iotagentRepo="https://github.com/telefonicaid/iotagent-json.git"
EXPORT iotagentRepo

sthRepo="https://github.com/telefonicaid/fiware-sth-comet.git"
EXPORT sthRepo

./step2.sh
