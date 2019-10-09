#! /bin/bash

####################打印帮助
printhelp(){
	echo '########################################'
	echo 'init 	 安装wget vim sed epel-release gcc等'
	echo 'help 	 显示帮助'
	echo 'chn  	 安装中文字体,安装完成请重连'
	echo 'ss     安装ss-server服务端,默认启动端口1521，密码123456,加密aes-256-gcm'
	echo 'chnkrl  更换内核来安装锐速，更换内核后会重启'
	echo 'ruisu  安装锐速（需要先更换内核心，执行chnkrl命令)，默认一路回车即可'
	echo 'fastcmd  快捷命令，如welcome加载bash_profile等'
	echo '########################################'
	
	readinput
}

fastcmd(){
	if !test -d ~/.zlq/ 
		then 
	mkdir ~/.zlq/
	fi
	cd ~/.zlq/
	rm -rf s_ssMonitor_netstat_iptables.sh set-iptables.sh
	wget https://raw.githubusercontent.com/zlqlpp/centos7_init_sh/master/s_ssMonitor_netstat_iptables.sh
	wget https://raw.githubusercontent.com/zlqlpp/centos7_init_sh/master/set-iptables.sh
	 
	echo "alias welcome='source ~/.bash_profile'"  >> ~/.bash_profile
	echo "alias monitor='bash ~/.zlq/s_ssMonitor_netstat_iptables.sh'" >> ~/.bash_profile
	echo "alias setiptables='bash ~/.zlq/set-iptables.sh'" >> ~/.bash_profile
}


#更换内核
chnkrl(){
#centos7 x64 os
#换内核
yum install -y wget;   
wget --no-check-certificate -O rskernel.sh https://raw.githubusercontent.com/uxh/shadowsocks_bash/master/rskernel.sh && bash rskernel.sh
}

#锐速
ruisu(){
#一路回车
yum install net-tools -y && wget --no-check-certificate -O appex.sh https://raw.githubusercontent.com/0oVicero0/serverSpeeder_Install/master/appex.sh && bash appex.sh install

#启动： /serverspeeder/bin/serverSpeeder.sh start
#停止：/serverspeeder/bin/serverSpeeder.sh stop
#状态： service serverSpeeder status
#检查是否有appex0模块：lsmod
}

##ss-server服务端安装，并启动一个进程 
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
rm -rf shadowsocks-;
#5 shadowsocks-libev 配置文件
mkdir /etc/shadowsocks;
cat <<-EOF > /etc/shadowsocks/ss.json
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
  setsid ss-server -c /etc/shadowsocks/ss.json -u &

}
##################开发套件
init(){
	yum install -y wget curl vim sed tsar  epel-release unzip; #安装下载，文本处理，系统监控，第三方源
	yum groupinstall 'Development Tools' -y ;                  #安装开发工具
	service crond start;                                       #启动crontable
	setenforce 0;                                              #关闭  selinux
	
	readinput
}
################安装中文
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
	yum install ibus-table-chinese*
	#重新连接终端即可
	readinput

}


##读取用户输入
readinput(){

	read -p "enter commond:" no
	#read -p "enter name:" name
	#echo you have entered $no, $name

	case $no in 
		init)
		init 
		;;
		help)
		printhelp
		;;
		chn)
		chn
		;;
		ss)
		ss
		;;
		chnkrl)
		chnkrl
		;;
		ruisu)
		ruisu
		;;
		fastcmd)
		fastcmd
		;;
		*)
		echo 'wrong'
		
	esac

}

printhelp
readinput


