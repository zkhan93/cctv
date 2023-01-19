#!/bin/bash
declare -x >> /etc/environment
cron -f -L /dev/stdout
