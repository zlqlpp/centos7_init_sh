#!/bin/bash

yum install -y wget curl vim sed tsar  epel-release unzip; #安装下载，文本处理，系统监控，第三方源

yum groupinstall 'Development Tools' -y ;                  #安装开发工具

service crond start;                                       #启动crontable

setenforce 0;                                              #关闭  selinux
