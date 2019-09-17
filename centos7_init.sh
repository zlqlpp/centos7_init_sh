#!/bin/bash

yum install -y wget curl vim sed tsar  epel-release unzip; #安装下载，文本处理，系统监控，第三方源

yum groupinstall 'Development Tools' -y ;

service crond start; 

setenforce 0;
