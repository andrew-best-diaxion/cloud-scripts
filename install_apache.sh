#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

#Update packages and Upgrade system
echo "Updating System"
sudo apt-get -y update && sudo apt-get -y upgrade

echo "Installing Apache2"
sudo apt-get -y install apache2

#Finding Public IP of Server
PUB_IP="$(ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//')"

#Editing apache2.conf file
echo "ServerName $PUB_IP" >> /etc/apache2/apache2.conf

#Installing PHP and required modules
# echo "Installing php modules"
# apt-get -y install php7.0-fpm php7.0-cli php7.0-common libapache2-mod-php7.0 php7.0-mcrypt php7.0-mysql php5-mysqlnd

#Setting permissions and ownership for /var/www
echo "Setting ownership on /var/www"
sudo chown -R www-data:www-data /var/www

#Downloading demo.php file
#wget https://github.com/armankoradia/azure-Getting-Started-with-Terraform/blob/master/scripts/demo.php -O /var/www/html/demo.php
#sudo chown -R www-data:www-data /var/www/html/demo.php
