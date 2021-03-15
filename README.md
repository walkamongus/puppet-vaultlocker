# vaultlocker

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with vaultlocker](#setup)
    * [What vaultlocker affects](#what-vaultlocker-affects)
    * [Beginning with vaultlocker](#beginning-with-vaultlocker)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module will install and configure vaultlocker and its requirements (such as the cryptsetup utility).

## Setup

### What vaultlocker affects

By default, this module will attempt to install and manage Python using the
https://forge.puppet.com/modules/puppet/python module and also install
the `cryptsetup` package.

### Beginning with vaultlocker

```
include vaultlocker
```

will install the vaultlocker tool and a default configuration file.
The default configuration will not work as site-specific Vault configuration
is necessary for Vault storage of encryption keys.

## Usage

An example of passing in a working vaultlocker configuration:
```
class { 'vaultlocker':
  config => {
    'url'       => https://my-vault-server:8200,
    'approle'   => 'approle-id',
    'secret_id' => 'secret-id',
    'backend'   => 'secret/vaultlocker',
  },
}
```

An example of passing in devices for encryption:
```
class { 'vaultlocker':
  config                  => {
    ...
  },
  encrypted_block_devices => [
    '/dev/sdd1',
    '/dev/sde',
  ],
}
```

## Limitations

Developed and tested only on RHEL 8.

## Development

All pull requests welcome. `pdk test unit` should pass for all contributions.
