class ntp::service {

	service { "ntpd":
		ensure				=> running,
		enable				=> true
	}

}
