class httpd::install {

        package { "httpd":
                ensure                  => latest
        }

	package { "mod_ssl":
		ensure			=> latest
	}

}

