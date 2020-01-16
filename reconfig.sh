#! /bin/bash

echo "Enter new hostname:"
read newName
hostnamectl set-hostname $newName

echo "Enter new IP address:"
read newIP
sudo sed -i 's/192.168.2.1/192.168.2.1/g' /etc/sysconfig/network-scripts/ifcfg-ens192