# This script installs supervisor in Centos 6.6
# And enables the Fiware stack in order all the
# deamons to run on start up.
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

# installing supervisor dependencies and then supervisor
read -r -p "Do you want to install supervisor? [y/N]" response
case "$response" in
    [yY][eE][sS]|[yY])
        break
        ;;
    *)
        exit
        ;;
esac
yum clean all
yum install python-setuptools
easy_install supervisor

# creating a config file

echo_supervisord_conf > /etc/supervisord.conf

cp supervisord /etc/rc.d/init.d/

chmod 755 /etc/rc.d/init.d/supervisord

# starting supervisor

sudo service supervisord restart

# Finally we are configuring supervisor to run the fiware stack on start up

sed -i "2i #chkconfig: 2345 99 60 " /etc/rc.d/init.d/supervisord
sed -i "3i #description: supervisord" /etc/rc.d/init.d/supervisord

echo "Initialising supervisor deamons------"
echo "Iotagent now configured"
echo "STH now configured"
sed -i "23i [program:iotagent]" /etc/supervisord.conf
sed -i "24i command=/opt/iotagent-json/bin/iotagent-json &> /var/log/iotAgent&" /etc/supervisord.conf
sleep 2
sed -i "26i [program:STH]" /etc/supervisord.conf
sed -i "27i command=/opt/fiware-sth-comet/bin/sth" /etc/supervisord.conf


sudo chkconfig supervisord on

while true; do
    read -p "Supervisor needs to reboot your system do you want to do it now? [yes/no]" yn
    case $yn in
        [Yy]* ) sudo reboot; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Supervisor is Installed!!!"
sleep 2
