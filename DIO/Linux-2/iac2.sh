#!/bin/bash

echo "Start"
echo "Updating packages"

apt-get update -y -q=3 &&apt-get upgrade -y -q=3

echo "Installing apache2"
apt-get install apache2 -y -q3

systemctl -n 0 status apache2

if [ $? != 0 ]; then
    echo "Starting apache2 service"
    systemctl -n 0 start apache2
fi

systemctl -n 0 status apache2

if [ $? !=  0 ]; then
    echo "Failed to start apache2."
    exit 1
fi


echo "Installing unzip"
apt-get install unzip -y -q=3


echo "Starting download..."
wget -q -O /tmp/main.zip https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip

FILE=/tmp/main.zip
if [ ! -f "$FILE" ]; then
    echo "Download failed."
    exit 1;
fi

echo "Unziping..."
unzip -oq /tmp/main.zip -d /tmp

echo "Copying files..."
cp -R /tmp/linux-site-dio-main/* /var/www/html

echo "Done."
exit 0