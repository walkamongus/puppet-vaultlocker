# @summary This class installs a configures vaultlocker
#
# This module will optionally install Python and then install vaultlocker via pip as well as the cryptsetup tool.
# A vaultlocker configuration file will also be placed in the correct location. An Array of block devices can
# optionally be passed and a `vaultlocker encrypt` command will be executed on each unencrypted device.
#
# @example
#   include vaultlocker
#
# @param package_ensure
#   Specifies the vaultlocker pip package ensure value.
#
# @param package_url
#   Specifies the vaultlocker pip package url to use for installation if necessary (such as for installing from a Git repo).
#
# @param pip_env_variables
#  Specifies an Array of environment variables to pass to pip for the vaultlocker package installation. 
#
# @param cmd_env_variables
#   Specifies an Array of environment variables to pass to the `vaultlocker encrypt` command.
#
# @param manage_python
#   Specifies whether to attempt to manage Python and part of the module.
#
# @param python_params
#   Specifies a free-form Hash of parameters and their values to pass to the Python class if Python is being managed.
#
# @param config
#   Specifies a Hash of configs and values for configuration of the vaultlocker tool.
#
# @param proxy
#   Specifies a proxy if one is needed for external/internet connections.
#
# @param encrypted_block_devices
#   Specifies an Array of block device paths. Each block device would be encrypted with vaultlocker if it is not already encrypted.
#
class vaultlocker (
  Variant[Enum[present, absent, latest], String[1]] $package_ensure,
  Variant[Boolean, String] $package_url,
  Array $pip_env_variables,
  Array $cmd_env_variables,
  Boolean $manage_python,
  Hash $python_params,
  Hash[String, String] $config,
  Optional[Stdlib::Httpurl] $proxy,
  Array[Stdlib::Unixpath] $encrypted_block_devices,
){

  class { 'vaultlocker::install':
    package_ensure => $package_ensure,
    package_url    => $package_url,
    env_variables  => $pip_env_variables,
    manage_python  => $manage_python,
    python_params  => $python_params,
    proxy          => $proxy,
  }

  class { 'vaultlocker::config':
    config      => $config,
  }

  contain 'vaultlocker::install'
  contain 'vaultlocker::config'

  Class['vaultlocker::install']
  -> Class['vaultlocker::config']
  -> Vaultlocker::Encrypt <| tag == 'vaultlocker_module' |>

  $encrypted_block_devices. each |$device| {
    vaultlocker::encrypt { $device:
      environment => $cmd_env_variables,
      tag         => 'vaultlocker_module',
    }
  }

}
