class mongodb::users (

	$mongodb_user				= $::openshift::params::mongodb_user,
	$mongodb_pass				= $::openshift::params::mongodb_pass

) inherits openshift::params {

	mongob::user { "$mongodb_user":
		password		=> "$mongodb_pass"
	}

}

