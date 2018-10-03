# yum::config - yum configuration setting class
#
# @summary Manage YUM configuration via /etc/yum.conf
#
# @param [Stdlib::Absolutepath] cachedir
#   Directory where yum should store its cache and db files. Default value: /var/cache/yum/$basearch/$releasever.
#
# @param [Enum['0', '1']] keepcache
#   Determines whether or not yum keeps the cache of headers and packages after successful installation.
#   Default value: 1 (keep files).
#
# @param [Enum['0', '1', '2', '3', '4', '5', '6', '7', '8','9', '10']] debuglevel
#   Debug message output level. Practical range is 0-10. Default value: 2.
#
# @param [Stdlib::Absolutepath] logfile
#   Full directory and file name for where yum should write its log file. Default value: /var/log/yum.log.
#
# @param [Enum['0', '1']] exactarch
#   Only update the architectures of packages that are installed. Updates must precisely preserve the architecture.
#   Default value: 1.
#
# @param [Enum['0', '1']] obsoletes
#   Enables yum's obsoletes processing logic. Useful when doing distribution level upgrades. Default value: 1.
#
# @param [Enum['0', '1']] gpgcheck
#   Tells yum whether or not it should perform a GPG signature check on packages. Default value: 1.
#
# @param [Enum['0', '1']] plugins
#   Global switch to enable or disable yum plugins. Default value: 1.
#
# @param [Integer] installonly_limit
#   Number of packages listed in installonlypkgs to keep installed at the same time.
#   Default value: 5 (on CentOS; Red Hat default value: 3).
#
# @param [Stdlib::Httpurl] bugtracker_url
#   URL where bugs should be filed for yum. Default value: null (distro-specific).
#
# @param [String] distroverpkg
#   The package used by yum to determine the "version" of the distribution.
#   Default value: centos-release (on CentOS; Red Hat default value: null).
#
# @param [Hash] extra_options
#   Other yum configuration options to set. See yum_config-extra_options.example in this module's data directory.
#   Default value: null.
#
class yum::config (
  Stdlib::Absolutepath $cachedir,
  Enum['0', '1'] $keepcache,
  Enum['0', '1', '2', '3', '4', '5', '6', '7', '8','9', '10'] $debuglevel,
  Stdlib::Absolutepath $logfile,
  Enum['0', '1'] $exactarch,
  Enum['0', '1'] $obsoletes,
  Enum['0', '1'] $gpgcheck,
  Enum['0', '1'] $plugins,
  Integer $installonly_limit,
  Optional[Stdlib::Httpurl] $bugtracker_url,
  Optional[String] $distroverpkg,
  Optional[Hash] $extra_options,
){

  file { '/etc/yum.conf':
    ensure  => present,
    group   => '0',
    mode    => '0644',
    owner   => '0',
    content => template('yum/yum.conf.erb'),
  }

  file { '/etc/yum.repos.d':
    ensure   => directory,
    group    => '0',
    mode     => '0755',
    owner    => '0',
  }

}
