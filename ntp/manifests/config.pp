class ntp::config {

	file { "/etc/ntp.conf":
		content					=> template("ntp/etc/ntp.conf.erb"),
		notify					=> Class["ntp::service"]
	}

}
