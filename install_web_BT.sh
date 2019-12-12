#/bin/bash

yum install -y wget curl vim sed tsar  epel-release unzip;

yum install tranmission transmission-daemon -y;

systemctl start transmission-daemon.service; 
systemctl stop transmission-daemon.service; 


sed -i '/rpc-authentication-required/c "rpc-authentication-required": true,' /var/lib/transmission/.config/transmission-daemon/settings.json ;
sed -i '/rpc-enabled/c "rpc-enabled": true,' /var/lib/transmission/.config/transmission-daemon/settings.json                                 ;
sed -i '/rpc-password/c  "rpc-password": "123456",' /var/lib/transmission/.config/transmission-daemon/settings.json                          ;
sed -i '/rpc-username/c "rpc-username": "admin",' /var/lib/transmission/.config/transmission-daemon/settings.json                            ;
sed -i '/"rpc-whitelist"/c "rpc-whitelist": "0.0.0.0",'             /var/lib/transmission/.config/transmission-daemon/settings.json            ;
sed -i '/"rpc-whitelist-enabled"/c "rpc-whitelist-enabled": false,' /var/lib/transmission/.config/transmission-daemon/settings.json            ;

systemctl start transmission-daemon.service

setenforce 0

echo  'install ok'
 
#https://blog.uuz.moe/2017/02/install_transmission/
#http://your.domain.name:9091
#---------------------------------------------
#systemctl stop transmission-daemon.service; 
#systemctl start transmission-daemon.service
#
#netstat -ntlp
#
#vim /var/lib/transmission/.config/transmission-daemon/settings.json
#
#alias rm='rm -rf '
#alias welcom='source ~/.bash_profile'
#alias netntlp='netstat -ntlp'
#alias ipt='iptables -nvL'
#
#systemctl stop transmission-daemon.service;
#rm /var/lib/transmission/.config/transmission-daemon/settings.json;
#systemctl start transmission-daemon.service;
#systemctl stop transmission-daemon.service;
#
#vim /var/lib/transmission/.config/transmission-daemon/settings.json
