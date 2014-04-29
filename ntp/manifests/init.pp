class ntp {

	class { 'ntp::install': } ->
	class { 'ntp::config': } ->
	class { 'ntp::service': } ->
	Class [ 'ntp' ]

}
