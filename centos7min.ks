text
skipx
install
url --url http://192.168.176.36/centos/7.2.1511/os/x86_64
repo --name=updates --baseurl=http://192.168.176.36/centos/7.2.1511/updates/x86_64
lang de_DE.UTF-8
keyboard de
rootpw centos
firewall --disabled
authconfig --enableshadow --passalgo=sha512
selinux --disabled
timezone Europe/Berlin

bootloader --location=mbr
zerombr
clearpart --all --initlabel
part /boot --fstype ext4 --fsoptions="noatime" --size=200
part pv.01 --size 1 --grow
volgroup vg0 pv.01
logvol swap --fstype swap --name=swap --vgname=vg0 --size 2048
logvol / --fstype ext4 --fsoptions="noatime" --name=root --vgname=vg0 --size 4096 --grow
services --enabled=postfix,network,ntpd,ntpdate,sshd
services --disabled=firewalld

reboot

%packages --nobase
openssh-clients
openssh-server
yum
vim
passwd
shadow-utils
crontabs
logrotate
ntp
ntpdate
rsync
which
wget
net-tools
%end

%post
/usr/bin/rm -f /etc/yum.repos.d/CentOS*
/bin/echo "[base]" >  /etc/yum.repos.d/RBB-evo-yum.repo
/bin/echo "name=RBB-EVO-YUM" >>  /etc/yum.repos.d/RBB-evo-yum.repo
/bin/echo "baseurl=http://evo-yum/centos/7.2.1511/os/x86_64/" >>  /etc/yum.repos.d/RBB-evo-yum.repo
/bin/echo "enabled=1" >>  /etc/yum.repos.d/RBB-evo-yum.repo
/bin/echo "gpgcheck=0" >>  /etc/yum.repos.d/RBB-evo-yum.repo

/bin/echo "[updates]" >>  /etc/yum.repos.d/RBB-evo-yum.repo
/bin/echo "name=RBB-EVO-YUM" >>  /etc/yum.repos.d/RBB-evo-yum.repo
/bin/echo "baseurl=http://evo-yum/centos/7.2.1511/updates/x86_64/" >>  /etc/yum.repos.d/RBB-evo-yum.repo
/bin/echo "enabled=1" >>  /etc/yum.repos.d/RBB-evo-yum.repo
/bin/echo "gpgcheck=0" >>  /etc/yum.repos.d/RBB-evo-yum.repo

/usr/sbin/useradd mgm -m -d /home/mgm
/bin/echo "mgm:mgmadmin" | /usr/sbin/chpasswd
/bin/echo "mgm    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
%end

