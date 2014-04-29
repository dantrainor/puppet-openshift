class openshift::ruby193_mcollective::client::install {

	package { "ruby193-mcollective-client":
		ensure					=> latest
	}

}
