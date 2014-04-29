class httpd::config {

        file { "/etc/httpd/conf.d/ssl.conf":
                source                  => "puppet:///modules/httpd/etc/httpd/conf.d/ssl.conf"
        }

}

