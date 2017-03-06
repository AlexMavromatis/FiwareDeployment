# First script to run in order to set up the enviroment for fiware
# Disabling selinux and installing packages for fiware

echo "Installing packages..."
yum install $(cat rpm-qa-dump)

echo "SELINUX=disabled   SELINUXTYPE=targeted" >  /etc/sysconfig/selinux
