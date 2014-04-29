class openshift::ruby193_mcollective::client::config (

        $openshift_activemq_topic                       = hiera(openshift::local::activemq_topic,$::openshift::params::activemq_topic),
        $openshift_activemq_host                        = hiera(openshift::local::activemq_host,$::openshift::params::activemq_host),
        $openshift_activemq_port                        = hiera(openshift::local::activemq_port,$::openshift::params::activemq_port),
        $openshift_activemq_user                        = hiera(openshift::local::activemq_user,$::openshift::params::activemq_user),
        $openshift_activemq_pass                        = hiera(openshift::local::activemq_pass,$::openshift::params::activemq_pass),

) inherits openshift::params {
	file { "/opt/rh/ruby193/root/etc/mcollective/client.cfg":
		content					=> template("openshift/ruby193_mcollective/opt/rh/ruby193/root/etc/mcollective/client.cfg.erb"),
	}

	file { "/var/log/openshift/ruby193-mcollective.log":
		owner					=> "apache",
		group					=> "root",
		ensure					=> present
	}

}
