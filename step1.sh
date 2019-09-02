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
# This file was created by HPN
# Author - Alex Mavromatis: a.mavromatis@bristol.ac.uk
#-------------------------------------#


echo "Installing packages..."
yum install -y $(cat rpm-qa-dump)
echo "Disabling Selinux \n"
echo "SELINUX=disabled   SELINUXTYPE=targeted" >  /etc/sysconfig/selinux
