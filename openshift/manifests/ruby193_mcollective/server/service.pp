class openshift::ruby193_mcollective::server::service {

	service { "ruby193-mcollective":
		ensure					=> running,
		enable					=> true,
		subscribe				=> Class["openshift::ruby193_mcollective::install"]
	}

}
