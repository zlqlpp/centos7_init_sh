dd if=/dev/zero of=/swapfile bs=1024 count=1M
mkswap /swapfile
swapon /swapfile
swapon -s
echo '/swapfile swap swap defaults 0 0' >>/etc/fstab
chown root:root /swapfile; chmod 0600 /swapfile
echo 'vm.swappiness=10' >>  /etc/sysctl.conf
