class openshift::node::service {

	service { "openshift-node-web-proxy":
		ensure				=> running,
		enable				=> true
	}

	service { "openshift-gears":
		ensure				=> running,
		enable				=> true
	}

}
