# yum - main class
#
# @summary Manage YUM configuration and repositories
#
# @example Simple include usage
#   include yum
#
# @example Hiera parameter lookup
#   ---
#   yum::yumrepos_before_packages: true
#   yum::repositories:
#     custom_repo:
#       ensure: present
#       descr: YUM Repository
#       enabled: 1
#       baseurl: https://server.example.org/repo
#       gpgcheck: 0
#     ...
#   include yum
#
# @example Resource-like class declaration usage
#   $repo = {
#     custom_repo: {
#       ensure: present,
#       descr: 'YUM Repository',
#       enabled: 1,
#       baseurl: 'https://server.example.org/repo',
#       gpgcheck: 0
#     },
#     {...}
#   }
#   yum { 'namevar':
#     yumrepos_before_packages => true,
#     repositories => $repo
#   }
#
# @param [Boolean] yumrepos_before_packages
#   Whether to require all yumrepo resources be applied before any packages. Default value: false.
#
# @param [Hash] repositories
#  A hash of (yumrepo resource) repository names and their parameter key/values. Default value: { }.
#
class yum (
  Boolean $yumrepos_before_packages = false,
  Hash $repositories = {}
){

  include yum::config

  if $yumrepos_before_packages {
    Yumrepo <| |> -> Package <| provider == 'yum' |>
  }

  $repositories.each |String $repository, Hash $repository_params| {
    yumrepo { $repository:
      *       => $repository_params,
      require => Class['yum::config'],
    }
  }

}
