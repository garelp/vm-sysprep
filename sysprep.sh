#!/bin/bash
#
# sysprep script to remove unwanted information before mastering.
#

/sbin/service rsyslog stop
/sbin/service auditd stop

setenforce 0
sed -i -e 's!^SELINUX=.*!SELINUX=disabled!' /etc/selinux/config

chkconfig iptables off
ckkconfig iptables6 off
chkconfig postfix off

/usr/bin/yum clean all

/usr/sbin/logrotate –f /etc/logrotate.conf
/bin/rm –f /var/log/*-???????? /var/log/*.gz
/bin/rm -f /var/log/dmesg.old
/bin/rm -rf /var/log/anaconda

/bin/cat /dev/null > /var/log/audit/audit.log
/bin/cat /dev/null > /var/log/wtmp
/bin/cat /dev/null > /var/log/lastlog
/bin/cat /dev/null > /var/log/grubby

/bin/rm -f /etc/udev/rules.d/70*

/bin/sed -i '/^(HWADDR|UUID)=/d' /etc/sysconfig/network-scripts/ifcfg-eth0

/bin/rm –rf /tmp/*
/bin/rm –rf /var/tmp/*

/bin/rm –f /etc/ssh/*key*

/bin/rm -f ~root/.bash_history
unset HISTFILE

/bin/rm -rf ~root/.ssh/
/bin/rm -f ~root/anaconda-ks.cfg

