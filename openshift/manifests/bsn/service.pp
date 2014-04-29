class openshift::bsn::service {

	class{'mongodb::service': } ->
	Class['openshift::bsn::service']


}
