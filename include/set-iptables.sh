#!/bin/bash

opNum=`iptables -nvL |grep 'tcp spt'|wc -l`

if [ $opNum -gt 0 ]; then
    for((cnt=0;cnt<$opNum;cnt++)) do
                iptables -D OUTPUT 1
    done

fi

iptables -A OUTPUT -p tcp --sport 1521
iptables -A OUTPUT -p tcp --sport 1522
iptables -A OUTPUT -p tcp --sport 1433
iptables -A OUTPUT -p tcp --sport 1434
iptables -A OUTPUT -p tcp --sport 3306
iptables -A OUTPUT -p tcp --sport 21
iptables -A OUTPUT -p tcp --sport 33891
iptables -A OUTPUT -p tcp --sport 33892
iptables -A OUTPUT -p tcp --sport 33894
iptables -A OUTPUT -p tcp --sport 7000
iptables -A OUTPUT -p tcp --sport 65522
iptables -A OUTPUT -p tcp --sport 65523


iptables -nvL
