#! /bin/bash

# Enable /dev/sdb
sudo pvcreate /dev/sdb
sudo vgcreate vol1 /dev/sdb
sudo lvcreate -l 100%FREE -n data vol1

# Enable /dev/sdc
sudo pvcreate /dev/sdc
sudo vgcreate vol2 /dev/sdc
sudo lvcreate -l 100%FREE -n data vol2

yum remove -y vim-minimal
yum install -y vim-enhanced
yum install -y sudo

cat << EOF > ../.vimrc
syntax enable
colorscheme torte
EOF

chown sonny: ../.vimrc

cat << EOF > /root/.vimrc
syntax enable
colorscheme torte
EOF

yum install -y epel-release
yum install -y open-vm-tools-desktop wget mlocate elinks yum-utils net-tools

yum update -y

yum clean all
rm -rf /var/cache/yum

reboot