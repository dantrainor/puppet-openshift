class httpd {

	class { 'httpd::install': } ->
	class { 'httpd::config': } ->
	class { 'httpd::service': } ->
	Class [ 'httpd' ]


}

