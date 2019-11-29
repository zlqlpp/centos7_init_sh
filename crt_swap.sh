swapon -s

dd if=/dev/zero of=/swapfile bs=1024 count=1M

mkswap /swapfile

swapon /swapfile

swapon -s

vim /etc/fstab
在最后一行添加上下面一条：
    /swapfile     swap     swap     defaults     0  0
	
 chown root:root /swapfile
    chmod 0600 /swapfile

/etc/sysctl.conf文件里添加如下参数：vm.swappiness=10

保存，重启。
