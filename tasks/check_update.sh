#!/bin/sh

# Puppet Task Name: yum::check_update
#

YUM_CMD=/usr/bin/yum

if [[ $PT_show_obsoletes && $PT_show_obsoletes = 'true' ]]; then
  YUM_CMD="${YUM_CMD} --verbose"
fi

$YUM_CMD check-update

if [[ $? -eq 100 || $? -eq 0 ]]; then
  exit
else
  exit $?
fi

