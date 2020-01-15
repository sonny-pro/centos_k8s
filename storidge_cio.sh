#! /bin/bash

# Open firewall ports
sudo firewall-cmd --permanent --zone=public --add-port=3260/tcp # ISCI
sudo firewall-cmd --permanent --zone=public --add-port=8282/tcp # REST API
sudo firewall-cmd --permanent --zone=public --add-port=8383/tcp # Secure cluster configuration
sudo firewall-cmd --permanent --zone=public --add-port=16995/tcp # Metrics Exporter
sudo firewall-cmd --permanent --zone=public --add-port=16996/tcp # DFS internode communications
sudo firewall-cmd --permanent --zone=public --add-port=16997/tcp # SDS CLI server
sudo firewall-cmd --permanent --zone=public --add-port=16998/tcp # Controller nodes hearbeat
sudo firewall-cmd --permanent --zone=public --add-port=16999/tcp # DFS-CIO internode communication
sudo firewall-cmd --permanent --zone=public --add-port=9000/tcp # Portainer
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload

#kubectl create -f https://raw.githubusercontent.com/Storidge/csi-cio/master/deploy/releases/csi-cio-v1.2.0.yaml

curl -fsSL ftp://download.storidge.com/pub/ce/cio-ce | sudo bash