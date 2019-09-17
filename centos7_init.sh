#!/bin/bash

yum install -y wget curl vim sed tsar  epel-release unzip; #安装下载，文本处理，系统监控，第三方源

service crond start; 

setenforce 0;
