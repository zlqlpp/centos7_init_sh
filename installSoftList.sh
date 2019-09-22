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
