#! /bin/bash

printhelp(){
	echo '########################################'
	echo 'init 安装wget vim sed epel-release gcc等'
	echo 'help 显示帮助'
	echo 'chn 安装中文字体,安装完成请重连'
	
	echo '########################################'
}

##开发套件
init(){
	yum install -y wget curl vim sed tsar  epel-release unzip; #安装下载，文本处理，系统监控，第三方源
	yum groupinstall 'Development Tools' -y ;                  #安装开发工具
	service crond start;                                       #启动crontable
	setenforce 0;                                              #关闭  selinux
}
##安装中文
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

}
##读取用户输入
readinput(){

	printhelp
	read -p "enter commond:" no
	#read -p "enter name:" name
	#echo you have entered $no, $name


	case $no in 
		init)
		init 
		;;
		help)
		echo 'printhelp'
		;;
		*)
		echo 'wrong'
		
	esac

}


readinput


