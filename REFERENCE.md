# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`vaultlocker`](#vaultlocker): This class installs a configures vaultlocker

#### Private Classes

* `vaultlocker::config`: Handles vaultlocker configurations
* `vaultlocker::install`: Handles optional python installation and vaultlocker installation

### Defined types

* [`vaultlocker::encrypt`](#vaultlockerencrypt): Automatically run vaultlocker to encrypt a block device.

## Classes

### <a name="vaultlocker"></a>`vaultlocker`

This module will optionally install Python and then install vaultlocker via pip as well as the cryptsetup tool.
A vaultlocker configuration file will also be placed in the correct location. An Array of block devices can
optionally be passed and a `vaultlocker encrypt` command will be executed on each unencrypted device.

#### Examples

##### 

```puppet
include vaultlocker
```

#### Parameters

The following parameters are available in the `vaultlocker` class:

* [`package_ensure`](#package_ensure)
* [`package_url`](#package_url)
* [`pip_env_variables`](#pip_env_variables)
* [`cmd_env_variables`](#cmd_env_variables)
* [`manage_python`](#manage_python)
* [`python_params`](#python_params)
* [`config`](#config)
* [`proxy`](#proxy)
* [`encrypted_block_devices`](#encrypted_block_devices)

##### <a name="package_ensure"></a>`package_ensure`

Data type: `Variant[Enum[present, absent, latest], String[1]]`

Specifies the vaultlocker pip package ensure value.

##### <a name="package_url"></a>`package_url`

Data type: `Variant[Boolean, String]`

Specifies the vaultlocker pip package url to use for installation if necessary (such as for installing from a Git repo).

##### <a name="pip_env_variables"></a>`pip_env_variables`

Data type: `Array`

Specifies an Array of environment variables to pass to pip for the vaultlocker package installation.

##### <a name="cmd_env_variables"></a>`cmd_env_variables`

Data type: `Array`

Specifies an Array of environment variables to pass to the `vaultlocker encrypt` command.

##### <a name="manage_python"></a>`manage_python`

Data type: `Boolean`

Specifies whether to attempt to manage Python and part of the module.

##### <a name="python_params"></a>`python_params`

Data type: `Hash`

Specifies a free-form Hash of parameters and their values to pass to the Python class if Python is being managed.

##### <a name="config"></a>`config`

Data type: `Hash[String, String]`

Specifies a Hash of configs and values for configuration of the vaultlocker tool.

##### <a name="proxy"></a>`proxy`

Data type: `Optional[Stdlib::Httpurl]`

Specifies a proxy if one is needed for external/internet connections.

##### <a name="encrypted_block_devices"></a>`encrypted_block_devices`

Data type: `Array[Stdlib::Unixpath]`

Specifies an Array of block device paths. Each block device would be encrypted with vaultlocker if it is not already encrypted.

## Defined types

### <a name="vaultlockerencrypt"></a>`vaultlocker::encrypt`

This type with execute `vaultlocker encrypt` on a block device unless the device is already encrypted.

#### Examples

##### 

```puppet
vaultlocker::encrypt { '/dev/sdb': }
```

#### Parameters

The following parameters are available in the `vaultlocker::encrypt` defined type:

* [`device`](#device)
* [`environment`](#environment)

##### <a name="device"></a>`device`

Data type: `Stdlib::Unixpath`

Specifies the full path to the block device that vaultlocker will encrypt.

Default value: `$title`

##### <a name="environment"></a>`environment`

Data type: `Optional[Array]`

Specifies an Array of environment variables that are passed to the `vaultlocker encrypt` command.
This is useful because the Python `requests` module does not use the system CA trust store. You can
inject a specific CA cert bundle that includes your Vault server by setting this parameter to
something like `environment => ['REQUESTS_CA_BUNDLE=/path/to/my/ca-bundle.crt']`

Default value: ``undef``

