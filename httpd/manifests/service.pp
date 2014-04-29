class httpd::service {

        service { "httpd":
                ensure                  => running,
                enable                  => true
        }

}
