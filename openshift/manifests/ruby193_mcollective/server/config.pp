class openshift::ruby193_mcollective::server::config (

        $openshift_activemq_topic,
        $openshift_activemq_host,
        $openshift_activemq_port,
        $openshift_activemq_user,
        $openshift_activemq_pass,

) inherits openshift::params {

	file { "/opt/rh/ruby193/root/etc/mcollective/server.cfg":
		content					=> template("openshift/ruby193_mcollective/opt/rh/ruby193/root/etc/mcollective/server.cfg.erb"),
	}

	file { "/opt/rh/ruby193/root/etc/mcollective/client.cfg":
		ensure					=> absent
	}

	file { "/var/log/openshift/ruby193-mcollective.log":
		owner					=> "apache",
		group					=> "root",
		ensure					=> present
	}


}
