#! /bin/bash

echo "kubeadm init"
echo "exit"

echo "mkdir -p $HOME/.kube"
echo "sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config"
echo "sudo chown $(id -u):$(id -g) $HOME/.kube/config"

echo "kubectl create clusterrolebinding root-cluster-admin-binding --clusterrole=cluster-admin --user=scci-admin"
echo "kubectl create clusterrolebinding root-cluster-root-binding --clusterrole=cluster-admin --user=root"

echo "kubectl create secret -n kube-system generic weave-passwd --from-file=/var/lib/weave/weave-passwd"
echo 'kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&password-secret=weave-passwd"'
echo "kubectl create -f https://raw.githubusercontent.com/Storidge/csi-cio/master/deploy/releases/csi-cio-v1.2.0.yaml"