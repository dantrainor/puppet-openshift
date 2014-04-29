class mongodb { 

	class { 'mongodb::install': } ->
	class { 'mongodb::config': } ~>
	class { 'mongodb::service': } ->
	Class [ 'mongodb' ]

}
