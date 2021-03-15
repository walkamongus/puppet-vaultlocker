# @summary Automatically run vaultlocker to encrypt a block device.
#
# This type with execute `vaultlocker encrypt` on a block device unless the device is already encrypted.
#
# @example
#   vaultlocker::encrypt { '/dev/sdb': }
#
# @param device
#   Specifies the full path to the block device that vaultlocker will encrypt.
#
# @param environment
#   Specifies an Array of environment variables that are passed to the `vaultlocker encrypt` command.
#   This is useful because the Python `requests` module does not use the system CA trust store. You can
#   inject a specific CA cert bundle that includes your Vault server by setting this parameter to
#   something like `environment => ['REQUESTS_CA_BUNDLE=/path/to/my/ca-bundle.crt']`
#
define vaultlocker::encrypt (
  Stdlib::Unixpath $device = $title,
  Optional[Array] $environment = undef,
) {

  exec { "vaultlocker_encrypt_${device}":
    command     => "vaultlocker encrypt ${device}",
    path        => ['/usr/local/bin','/usr/bin'],
    environment => $environment,
    unless      => "cryptsetup isLuks ${device}",
  }

}
