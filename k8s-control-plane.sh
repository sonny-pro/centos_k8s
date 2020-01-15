#! /bin/bash

# Control Plane Node(s)
sudo firewall-cmd --permanent --zone=public --add-port=6443/tcp # Kubernetes API server
sudo firewall-cmd --permanent --zone=public --add-port=2379-2380/tcp # etcd server client API
sudo firewall-cmd --permanent --zone=public --add-port=10250/tcp # Kubelet API
sudo firewall-cmd --permanent --zone=public --add-port=10251/tcp # kube-scheduler
sudo firewall-cmd --permanent --zone=public --add-port=10252/tcp # kube-controller-manager
sudo firewall-cmd --reload

# Enable the br_netfilter module for cluster communication
sudo modprobe br_netfilter
sudo echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
sudo echo '1' > /proc/sys/net/bridge/bridge-nf-call-ip6tables

sudo update-alternatives --set iptables /usr/sbin/iptables-legacy

# Add Kubernetes repo
sudo cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

sudo yum makecache -y

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

# Configure cgroup driver used by kubelet on control-plane node
sudo sed -i '/^KUBELET_EXTRA_ARGS=/ s/$/--cgroup-driver=systemd --allow-privileged --feature-gates=VolumeSnapshotDataSource=true,KubeletPluginsWatcher=true,CSINodeInfo=true,CSIDriverRegistry=true/' /etc/sysconfig/kubelet

sudo systemctl enable --now kubelet

# kubectl get nodes
# kubectl get pods --all-namespaces
# kubectl get nodes