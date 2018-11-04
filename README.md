
# yum

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with yum](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with yum](#beginning-with-yum)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

The yum module configures the Yellowdog Update Manager utility and yum repository configurations on Red Hat Enterprise Linux and CentOS 7.

## Setup

### Setup Requirements

puppetlabs/stdlib >= 4.13.0

### Beginning with yum

Use your preferred method to install the yum module.

`include yum` will get you up and running with module defaults on EL 7.

## Usage

Note: The preferred way to set yum configuration parameters and repository configurations is by using hiera.

Setting up base yum management:

```
class { 'yum': }
```

Require all yum repositories to be configured before packages are installed.

This parameter utilizes a resource collector and includes all package providers except `rpm` while also excluding `pe-*` packages used by Puppet Enterprise:

```
class { 'yum':
  yumrepos_before_packages => true,
}
```

Pass in additional yum repository configurations:

```
class { 'yum':
  repositories => {
    'epel' => {
      'ensure' => 'present',
      'descr' => 'Extra Packages for Enterprise Linux 7 - $basearch'
      'enabled' => '1'
      'metalink' => 'https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch'
      'baseurl' => 'absent'
      'failovermethod' => 'priority'
      'gpgcheck' => '1'
      'gpgkey' => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7'
    }
  },
}
```

## Reference

Classes and defined resources are documented using Puppet Strings code comments.

## Limitations

The base yum configurations in this yum module are slightly modified from the OS default installation configurations.
They should still use the original configuration files for default OS repositories.

## Development

* Clone https://github.com/bchristianv/puppet-yum.git
* Make your changes in a working branch and test them
* `git` add/commit/push
* Submit a pull request with any supporting comments for review.

## Release Notes/Contributors/Etc.

None.
