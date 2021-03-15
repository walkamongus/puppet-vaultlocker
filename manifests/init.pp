# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include vaultlocker
class vaultlocker (
  Variant[Enum[present, absent, latest], String[1]] $package_ensure,
  Boolean $manage_python,
  Hash $python_params,
  Hash[String, String] $config,
  Optional[Stdlib::Httpurl] $proxy,
  Array[Stdlib::Unixpath] $encrypted_block_devices,
){

  class { 'vaultlocker::install':
    package_ensure => $package_ensure,
    manage_python  => $manage_python,
    python_params  => $python_params,
    proxy          => $proxy,
  }
  ->class { 'vaultlocker::config':
    config      => $config,
  }

  contain 'vaultlocker::install'
  contain 'vaultlocker::config'

  $encrypted_block_devices. each |$device| {
    vaultlocker::encrypt { $device:
    }
  }

}