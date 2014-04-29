class cgroups {

	class { 'cgroups::install': } ->
	class { 'cgroups::config': } ~>
	class { 'cgroups::service': } ->
	Class [ 'cgroups' ]

}

