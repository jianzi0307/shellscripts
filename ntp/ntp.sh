#!/bin/sh
# 10 7 *  *  *
/usr/sbin/ntpdate 10.143.0.44
/usr/sbin/hwclock -w
