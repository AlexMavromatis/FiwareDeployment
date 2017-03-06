# This script installs supervisor in Centos 6.6
# And enables the Fiware stack in order all the
# deamons to run on start up.


# installing supervisor dependencies and then supervisor
read -p "Do you want to install supervisor? Press enter to continue"
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
sudo chkconfig supervisord on

while true; do
    read -p "Supervisor needs to reboot your system do you want to do it now?" yn
    case $yn in
        [Yy]* ) sudo reboot; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Supervisor is Installed!!!"
sleep 2
