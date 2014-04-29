class openshift::broker::service {

	service { "openshift-broker":
		ensure				=> running,
		enable				=> true,
	}

}
