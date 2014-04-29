class oddjob::service {

	include "oddjob::install"

	Class["oddjob::install"] -> Class["oddjob::service"]

	service { "oddjobd":
		ensure					=> running,
		enable					=> true
	}

}
