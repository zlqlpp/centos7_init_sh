#! /bin/bash



init(){
	yum install -y wget curl vim sed tsar  epel-release unzip; #安装下载，文本处理，系统监控，第三方源
	yum groupinstall 'Development Tools' -y ;                  #安装开发工具
	service crond start;                                       #启动crontable
	setenforce 0;                                              #关闭  selinux
}


echo '1 初始化centos服务器，安装基础软件'

read -p "enter number:" no
#read -p "enter name:" name
#echo you have entered $no, $name


case $no in 
	1)
	init 
	;;
	2)
	echo '222'
	;;
	*)
	echo 'wrong'
	
esac


#echo $LANG可以查看当前使用的系统语言
#locale命令，如有zh cn 表示已经安装了中文语言
#
#查看系当前语言包 locale
#查看系统拥有语言包 locale -a
#安装简体中文语言包 yum install kde-l10n-Chinese
#
#
#Centos7是Centos系列的最新版本，与老版本出现了较大操作差异，下面是安装中文支持
#
####中文支持
#
#安装语言包
#
#yum install kde-l10n-Chinese -y
#修改系统默认语言
#
#localectl set-locale LANG=zh_CN.utf8
#安装中文字体
#
#yum install ibus-table-chinese*
#
#重新连接终端即可
