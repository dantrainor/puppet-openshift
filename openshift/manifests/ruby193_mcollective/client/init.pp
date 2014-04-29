class openshift::ruby193_mcollective::client::config {

        include "::openshift::params"

        $openshift_activemq_topic                       = $::openshift::params::activemq_topic
        $openshift_activemq_host                        = $::openshift::params::activemq_host
        $openshift_activemq_port                        = $::openshift::params::activemq_port
        $openshift_activemq_user                        = $::openshift::params::activemq_user
        $openshift_activemq_pass                        = $::openshift::params::activemq_pass

        file { "/opt/rh/ruby193/root/etc/mcollective/client.cfg":
                content                                 => template("openshift/ruby193_mcollective/opt/rh/ruby193/root/etc/mcollective/client.cfg.erb"),
        }

}
class openshift::ruby193_mcollective::client::install {

        include "::openshift::ruby193_mcollective::install"

        realize(
                Package["ruby193-mcollective-client"]
        )

}

