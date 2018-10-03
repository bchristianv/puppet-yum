#!/bin/sh

# Puppet Task Name: yum::clean
#

YUM_CMD=/usr/bin/yum

if [[ $PT_cache_type = 'expire_cache' ]]; then
  yum_cache=expire-cache
else
  yum_cache=$PT_cache_type
fi

if [[ $PT_clean_disabled_repos && $PT_clean_disabled_repos = 'true' ]]; then
  echo 'Including any disabled repos in clean operation...'
  YUM_CMD="${YUM_CMD} --enablerepo=*"
fi

echo "Running 'yum clean ${yum_cache}'..."

if [[ ${yum_cache} = 'all' ]]; then
  if [[ $($YUM_CMD clean $yum_cache) && $(rm -rf /var/cache/yum) -eq 0 ]]; then
    echo 'Removed yum cache directories.'
  fi
else
  if [[ $($YUM_CMD clean $yum_cache) ]]; then
    echo "'yum clean ${yum_cache}' completed successfully."
  fi
fi
