# @api private
# @summary Handles optional python installation and vaultlocker installation
class vaultlocker::install (
  $package_ensure,
  $package_url,
  $env_variables,
  $manage_python,
  $python_params,
  $proxy,
){

  assert_private()

  if $manage_python {
    class { 'python':
      * => $python_params,
    }
  }

  package { 'cryptsetup':
    ensure =>  present,
  }

  python::pip { 'vaultlocker' :
    ensure      => $package_ensure,
    pkgname     => 'vaultlocker',
    url         => $package_url,
    environment => $env_variables,
    owner       => 'root',
    timeout     => 1800,
    proxy       => $proxy,
  }

}
