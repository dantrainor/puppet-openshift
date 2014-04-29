class openshift::ruby193_mcollective::server::config (

        $openshift_activemq_topic,
        $openshift_activemq_host,
        $openshift_activemq_port,
        $openshift_activemq_user,
        $openshift_activemq_pass,

) inherits openshift::params {

        file { "/opt/rh/ruby193/root/etc/mcollective/server.cfg":
                content                                 => template("ruby193_mcollective/opt/rh/ruby193/root/etc/mcollective/server.cfg.erb"),
        }

        file { "/opt/rh/ruby193/root/etc/mcollective/server.cfg":
                ensure                                  => absent
        }

}
class openshift::ruby193_mcollective::server::install {

        include "::openshift::ruby193_mcollective::install"

        realize(
                Package["ruby193-mcollective-client"]
        )

}

class openshift::ruby193_mcollective::server::service {

        Class["openshift::ruby193_mcollective::server::config"] -> Class["openshift::ruby193_mcollective::server::service"]

        service { "ruby193-mcollective":
                ensure                                  => running,
                enable                                  => true,
                subscribe                               => Class["openshift::ruby193_mcollective::server::config", "openshift::ruby193_mcollective::server::install"]
        }

}

