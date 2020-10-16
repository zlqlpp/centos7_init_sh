#! /bin/bash

####脚本分三个部分
## 帮助函数，打印说明信息
## 功能函数，用于安装各种软件
## 命令判断函数，用于根据用户输入执行相应的安装
####################打印帮助
printhelp(){
	clear
	echo '########################################'
	echo 'a 	安装wget vim sed epel-release gcc 启动crontab,临时关闭selinux,'
	echo 'b  	设置别名，welcome,setiptables,monitor'
	echo 'c     创建1GB 的swap'
	echo 'd  	安装youtubedl'
	echo 'e  	安装ffmpeg'
	echo 'f  	安装besttrace路由查询工具'
	echo 'g  	安装web下载bt软件'
	echo 'h   	安装内核'
	echo 'i 	安装锐速破解版，安装锐速（需要先更换内核心，执行chnkrl命令)，默认一路回车即可 '
	echo 'j 	安装ss-server服务端,默认启动端口1521，密码123456,加密aes-256-gcm'
	echo 'k  	安装中文'
	echo 'l  	永远关闭selinux'
	echo 'm  	一键lnmp'
	echo 'n  	 安装Python3'
	echo 'q  	退出'
	echo '########################################'
	
	readinput
}
##################----a
init(){
 	yum install -y wget curl vim sed tsar  epel-release unzip git sysstat; #安装下载，文本处理，系统监控，第三方源
	yum groupinstall 'Development Tools' -y ;                  #安装开发工具
	
	service crond start;                                       #启动crontable
	setenforce 0;                                              #关闭  selinux
	
}

##添加一些命令别名使操作更快捷
##################----b
fastcmd(){
	if ! test -d ~/.zlq/ 
		then 
	mkdir ~/.zlq/
	fi
	cd ~/.zlq/
	rm -rf include/s_ssMonitor_netstat_iptables.sh include/set-iptables.sh
	wget https://raw.githubusercontent.com/zlqlpp/centos7_init_sh/master/include/s_ssMonitor_netstat_iptables.sh
	wget https://raw.githubusercontent.com/zlqlpp/centos7_init_sh/master/include/set-iptables.sh
	 
	echo "alias welcome='source ~/.bash_profile'"  >> ~/.bash_profile
	echo "alias monitor='bash ~/.zlq/s_ssMonitor_netstat_iptables.sh'" >> ~/.bash_profile
	echo "alias setiptables='bash ~/.zlq/set-iptables.sh'" >> ~/.bash_profile
	source ~/.bash_profile
	echo 'alias welcome    monitor   setiptables '
}

##################----c
crt_1GB_swap(){
	dd if=/dev/zero of=/swapfile bs=1024 count=1M
	mkswap /swapfile
	swapon /swapfile
	swapon -s
	echo '/swapfile swap swap defaults 0 0' >>/etc/fstab
	chown root:root /swapfile; chmod 0600 /swapfile
	echo 'vm.swappiness=10' >>  /etc/sysctl.conf
}

##################----d
youtubedl(){
	sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl;
	sudo chmod a+rx /usr/local/bin/youtube-dl;
}


##################----e
ffmpega(){
	wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz;
	tar -xvf yasm-1.3.0.tar.gz;
	cd yasm-1.3.0/;
	./configure && make && make install;
	cd ../;rm -rf yasm*;

	wget http://www.ffmpeg.org/releases/ffmpeg-3.4.tar.gz;
	tar -xvf ffmpeg-3.4.tar.gz;
	cd ffmpeg-3.4/;
	./configure && make && make install;
	cd ../;rm -rf ffmpeg;
}

##################----f
installBesttrace(){
	if ! test -d ~/.zlq/ 
		then 
	mkdir ~/.zlq/
	fi
	
	cd ~/.zlq/
	mkdir besttrace
	cd  besttrace
	wget https://cdn.ipip.net/17mon/besttrace4linux.zip
	unzip besttrace4linux.zip
	chmod +x besttrace
	echo "PATH=$PATH:/root/.zlq/besttrace/" >> ~/.bash_profile
	echo "export PATH" >> ~/.bash_profile
	source ~/.bash_profile
	
}

##################----g
install_web_bt(){
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


}




#更换内核，来安装锐速
##################----h
chnkrl(){
	yum install -y wget;   
	wget --no-check-certificate -O rskernel.sh https://raw.githubusercontent.com/uxh/shadowsocks_bash/master/rskernel.sh && bash rskernel.sh
}

#锐速 #一路回车 使用默认值安装即可
##################----i
ruisu(){
	yum install net-tools -y && wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/0oVicero0/serverSpeeder_Install/master/appex.sh && bash appex.sh install
	
	#启动： /serverspeeder/bin/serverSpeeder.sh start
	#停止：/serverspeeder/bin/serverSpeeder.sh stop
	#状态： service serverSpeeder status
	#检查是否有appex0模块：lsmod
}

##ss-server服务端安装，并启动一个进程 
##################----j
ss(){
	#1.删除旧版本依赖库
	rm -rf libsodium-* mbedtls-* simple-obfs shadowsocks-libev
	#2.安装依赖包
	yum install epel-release git gcc vim -y
	yum install -y wget gettext autoconf libtool automake make asciidoc xmlto zlib-devel libev-devel c-ares-devel pcre-devel libsodium-devel mbedtls-devel
																	
	##########################################################因为在Yum安安装了，所以不了再编译安装
	#5.编译依赖库 加密库
	wget -O libsodium-stable.tar.gz https://download.libsodium.org/libsodium/releases/LATEST.tar.gz;
	tar xzf libsodium-stable.tar.gz;
	pushd libsodium-stable/;
	./configure --prefix=/usr && make ;
	make install;
	popd;
	ldconfig;
	rm -rf libsodium-*;
	#6.安装依赖包2
	export MBEDTLS_VER=2.13.0;
	wget https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz;
	tar xzf mbedtls-$MBEDTLS_VER-gpl.tgz;
	pushd mbedtls-$MBEDTLS_VER;
	make SHARED=1 CFLAGS=-fPIC ;
	make DESTDIR=/usr install;
	popd;
	ldconfig;
	rm -rf mbedtls-*;
	#8. mbed
	#wget https://tls.mbed.org/download/mbedtls-2.5.1-apache.tgz;
	#tar zxvf mbedtls-2.5.1-apache.tgz;
	#cd mbedtls-2.5.1;
	#make; make install
	############################################################
	#3.安装依赖包 混淆(可以不安装)
	git clone --recursive https://github.com/shadowsocks/simple-obfs.git;
	pushd simple-obfs;
	./autogen.sh;
	./configure --prefix=/usr && make ;
	make install;
	popd;
	rm -rf simple-*;
	
	#4 shadowsocks-libev 服务端软件
	git clone --recursive https://github.com/shadowsocks/shadowsocks-libev.git;
	pushd shadowsocks-libev;
	./autogen.sh;
	./configure --prefix=/usr && make ;
	make install;
	popd;
	rm -rf shadowsocks-;
	#5 shadowsocks-libev 配置文件
	mkdir /etc/shadowsocks;
	cat <<-EOF > /etc/shadowsocks/1521_ss.json
	{
			"server":"0.0.0.0",
			"server_port":1521,
			"local_port":1080,
			"password":"123456",
			"timeout":60,
			"method":"aes-256-gcm"
	}
	EOF
	
	#6.启动
	setsid ss-server -c /etc/shadowsocks/1521_ss.json -u &
	cd ../;rm -rf shadowsocks-libev;

}

################安装中文   k
chn(){
	#echo $LANG可以查看当前使用的系统语言
	#locale命令，如有zh cn 表示已经安装了中文语言
	#
	#查看系当前语言包 locale
	#查看系统拥有语言包 locale -a
	#安装简体中文语言包 yum install kde-l10n-Chinese
	#Centos7是Centos系列的最新版本，与老版本出现了较大操作差异，下面是安装中文支持
	####中文支持
	#安装语言包
	yum install kde-l10n-Chinese -y
	#修改系统默认语言
	#
	localectl set-locale LANG=zh_CN.utf8
	#安装中文字体
	yum install ibus-table-chinese* -y
	#重新连接终端即可
	readinput

}
closeSelinuxforever(){
	echo '修改/etc/selinux/config 文件'
	echo '将SELINUX=enforcing改为SELINUX=disabled'
}
lnmp(){
	cd ~
	wget http://mirrors.linuxeye.com/lnmp-full.tar.gz
	tar xzf lnmp-full.tar.gz
	#tar xzf lnmp.tar.gz
	cd lnmp # 如果需要修改目录(安装、数据存储、Nginx日志)，请修改options.conf文件
	./install.sh
	cd ~;rm -rf lnmp
}
python3(){
#安装必要工具 yum-utils ，它的功能是管理repository及扩展包的工具 (主要是针对repository)
 sudo yum install yum-utils -y
#使用yum-builddep为Python3构建环境,安装缺失的软件依赖,使用下面的命令会自动处理.
  sudo yum-builddep python -7
#完成后下载Python3的源码包 
 curl -O https://www.python.org/ftp/python/3.8.0/Python-3.8.0rc1.tgz
#最后一步，编译安装Python3，默认的安装目录是 /usr/local 如果你要改成其他目录可以在编译(make)前使用 configure 命令后面追加参数 “–prefix=/alternative/path” 来完成修改。
 tar xf Python-3.8.0rc1.tgz
 cd Python-3.8.0rc1
 ./configure
 make; make install
#至此你已经在你的CentOS系统中成功安装了python3、pip3、setuptools，查看python版本
#python3 -V
#如果你要使用Python3作为python的默认版本，你需要修改一下 bashrc 文件，增加一行alias参数
echo "alias python='/usr/local/bin/python3.5'" >> ~/.bash_profile
}
##读取用户输入
readinput(){
	read -p "enter commond:" no
	#read -p "enter name:" name
	#echo you have entered $no, $name

	case $no in 
		a)
		init ;printhelp
		;;
		b)
		fastcmd;printhelp
		;;
		c)
		crt_1GB_swap;printhelp
		;;
		d)
		youtubedl;printhelp
		;;
		e)
		ffmpega;printhelp
		;;
		f)
		installBesttrace;printhelp
		;;
		g)
		install_web_bt;printhelp
		;;
		h)
		chnkrl;printhelp
		;;
		i)
		ruisu;printhelp
		;;
		j)
		ss;printhelp
		;;
		k)
		chn;printhelp
		;; 
		l)
		closeSelinuxforever;printhelp
		;;
		m)
		lnmp;printhelp
		;;
		n)
		python3;printhelp
		;;
		q)
		exit
		;;
		*)
		echo '请输入有效的命令(abcdefghijklq) '	
	esac
}

printhelp


