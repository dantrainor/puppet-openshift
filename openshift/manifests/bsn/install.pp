class openshift::bsn::install {

	class{'mongodb::install': } ->
	Class['openshift::bsn::install']

}
