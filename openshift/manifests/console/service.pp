class openshift::console::service {

	service { "openshift-console":
		enable				=> true,
		ensure				=> running
	}

}
