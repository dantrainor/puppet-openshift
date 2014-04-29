class openshift::console::install {

	package { "openshift-origin-console":
		ensure				=> latest
	}

}
