class openshift::ruby193_mcollective::install {

	package { "ruby193-mcollective-common":
		ensure					=> latest
	}

}
