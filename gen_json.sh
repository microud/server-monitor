#!/usr/bin/env bash


# get computer info and output as a json
echo '{'
cpu_usage=`grep 'cpu ' /proc/stat |awk '{usage=($2+$4)/($2+$4+$5)} END {print usage}'`
echo '"cpu_usage":'${cpu_usage}','
cpu_num=`grep -E 'cpu[0-9]+' /proc/stat |wc -l`
echo '"cpu_num":'${cpu_num}','
mem_usage=`free -b |grep "Mem"|awk '{print $3/$2}' `
echo '"mem_usage":'${mem_usage}','
mem_total=`free -b |grep "Mem"|awk '{print $2}'`
echo '"mem_total":'${mem_total}','
#disk_usage=`df |sed -n "2p"|awk '{print $3/$2}'`
disk_usage=`df |sed '1d'|awk '{ALL+=$2;USED+=$3}END {print USED/ALL}'`
echo '"disk_usage":'${disk_usage}','
disk_total=`df |sed '1d'|awk '{ALL+=$2}END {print ALL}'`
echo '"disk_total":'${disk_total}','
# ifcfg 发送TX 接收RX  总流量 bit
#if_total=`ifconfig|sed -n '/.X packets/p'|awk '{sum+=$5} END {print sum}'`
if_total=`lspci | grep Ethernet |sed -E "s/.*?: //g"` # 网卡类型
echo '"if_total":'${if_total}
echo '}'
