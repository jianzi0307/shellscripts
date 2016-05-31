#!/bin/sh
echo "=================================="
echo "    CLOSED：无连接是活动的或正在进行
　　LISTEN：服务器在等待进入呼叫
　　SYN_RECV：一个连接请求已经到达，等待确认
　　SYN_SENT：应用已经开始，打开一个连接
　　ESTABLISHED：正常数据传输状态
　　FIN_WAIT1：应用说它已经完成
　　FIN_WAIT2：另一边已同意释放
　　ITMED_WAIT：等待所有分组死掉
　　CLOSING：两边同时尝试关闭
　　TIME_WAIT：另一边已初始化一个释放
　　LAST_ACK：等待所有分组死掉"
echo "=================================="
netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
