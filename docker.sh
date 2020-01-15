#! /bin/bash

# Docker communication
sudo firewall-cmd --permanent --zone=public --add-port=2376/tcp
sudo firewall-cmd --reload

# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

# Disable swap to prevent memory allocation issues
sudo swapoff -a
sudo sed -i '/swap/ s/^/#/' /etc/fstab

# Install Docker
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io

# Assign "scci-admin" to the Docker group
sudo usermod -aG docker sonny
sudo usermod -aG docker root

# Set cgroup to systemd
sudo sed -i 's/ -H fd:\/\///g' /usr/lib/systemd/system/docker.service
sudo sed -i "/^ExecStart/ s/$/ --exec-opt native.cgroupdriver=systemd/" /usr/lib/systemd/system/docker.service

# Enable and start Docker
sudo systemctl enable --now docker

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose