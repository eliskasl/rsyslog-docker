#!/bin/sh
# Wrapper to start rsyslog.d with appropriate sysconfig options

echo $$ > /var/run/syslogd.pid

source /etc/sysconfig/rsyslog
exec /usr/sbin/rsyslogd -n $SYSLOGD_OPTIONS
