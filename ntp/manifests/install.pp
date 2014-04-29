class ntp::install {

	package { "ntp":
		ensure				=> latest
	}

}
