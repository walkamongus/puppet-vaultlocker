# @api private
# @summary Handles vaultlocker configurations
class vaultlocker::config (
  $config,
){

  assert_private()

  $conf_epp = @(END)
    <%- | $config | -%>
    [vault]
    <% $config.each |$k, $v| { -%>
    <%= $k %>=<%= $v %>
    <% } -%>
    |-END

  file { '/etc/vaultlocker':
    ensure => directory,
    mode   => '0750',
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/vaultlocker/vaultlocker.conf':
    ensure   => file,
    mode     => '0640',
    owner    => 'root',
    group    => 'root',
    content  => inline_epp($conf_epp, 'config' => $config), #lint:ignore:arrow_alignment
  }
}
