class openshift::ruby193_mcollective::server::install {

	package { "ruby193-mcollective":
		ensure				=> latest
	}

}

