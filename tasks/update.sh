#!/bin/sh

# Puppet Task Name: yum::update
#

#ToDo(bchristianv): additional arguments - [--exclude=...] [--disablerepo=...] [--enablerepo=...] [--sec-severity=...] [--security]

YUM_CMD=/usr/bin/yum

if [[ $PT_package ]]; then
  $YUM_CMD --assumeyes update $PT_package
else
  $YUM_CMD --assumeyes update
fi

