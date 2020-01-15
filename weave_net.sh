#! /bin/bash

# Open firewall ports
sudo firewall-cmd --permanent --zone=public --add-port=6783/tcp
sudo firewall-cmd --permanent --zone=public --add-port=6783-6784/udp
sudo firewall-cmd --reload

sudo mkdir /var/lib/weave
sudo echo "s3cr3tp4ssw0rd" > weave-passwd
sudo mv weave-passwd /var/lib/weave/
kubectl create secret -n kube-system generic weave-passwd --from-file=/var/lib/weave/weave-passwd
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&password-secret=weave-passwd"