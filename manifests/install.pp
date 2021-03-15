# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include vaultlocker::install
class vaultlocker::install (
  $package_ensure,
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

  python::pip { 'vaultlocker' :
    ensure  => $package_ensure,
    pkgname => 'vaultlocker',
    owner   => 'root',
    timeout => 1800,
    proxy   => $proxy,
  }

}
