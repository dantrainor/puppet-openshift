class openshift::broker::config ( 

	$openshift_cloud_domain,
	$openshift_mongo_host,
	$openshift_mongo_port,
	$openshift_mongo_user,
	$openshift_mongo_pass,
	$openshift_mongo_db,
	$openshift_env_name,
	$openshift_bind_server,
	$openshift_bind_port,
	$openshift_bind_zone,
	$openshift_bind_keyvalue,
	$openshift_session_secret,
	$openshift_auth_salt,
	$openshift_activemq_host,
	$openshift_activemq_user,
	$openshift_activemq_pass,
	$openshift_districts_max_capacity,
	$openshift_districts_first_uid,
	$openshift_mcollective_timeout,
	$openshift_bind_krb_keytab,
	$openshift_bind_krb_principal,
	$openshift_activemq_topic,
	$openshift_activemq_user,
	$openshift_activemq_pass,
	$openshift_valid_gear_sizes,

) {

	File {
		notify				=> Class["openshift::broker::service"],
	}

	file { "/etc/httpd/conf.d/000002_openshift_origin_broker_servername.conf":
		content				=> template("openshift/etc/httpd/conf.d/000002_openshift_origin_broker_servername.conf.erb"),
		owner				=> apache,
		group				=> apache,
		mode				=> 0640
	}

	file { "/etc/openshift/broker.conf":
		content				=> template("openshift/etc/openshift/broker.conf.erb"),
		owner				=> apache,
		group				=> apache,
		mode				=> 0640,
		notify				=> Class["openshift::broker::service"],
	}

	file { "/etc/openshift/plugins.d/openshift-origin-auth-remote-user.conf":
		source				=> "puppet:///modules/openshift/etc/openshift/plugins.d/openshift-origin-auth-remote-user.conf",
		notify				=> Class["openshift::broker::service"]
	}

	file { "/etc/openshift/plugins.d/openshift-origin-msg-broker-mcollective.conf":
		content				=> template("openshift/etc/openshift/plugins.d/openshift-origin-msg-broker-mcollective.conf.erb"),
		notify				=> Class["openshift::broker::service"]
	}

	file { "/var/www/openshift/broker/httpd/conf.d/openshift-origin-auth-remote-user-ldap.conf":
		content				=> template("openshift/var/www/openshift/broker/httpd/conf.d/openshift-origin-auth-remote-user-ldap.conf.erb"),
		notify				=> Class["openshift::broker::service"]
	}

	file { "/etc/openshift/plugins.d/openshift-origin-dns-nsupdate.conf":
		content				=> template("openshift/etc/openshift/plugins.d/openshift-origin-dns-nsupdate.conf.erb"),
		notify				=> Class["openshift::broker::service"]
	}

	exec { "/etc/openshift/server_priv.pem":
		command				=> "/usr/bin/openssl genrsa -out /etc/openshift/server_priv.pem 2048",
		creates				=> "/etc/openshift/server_priv.pem",
	}

	exec { "gem bundle":
		cwd				=> "/var/www/openshift/broker",
		command				=> "/usr/bin/scl enable ruby193 'bundle --local'",
		refreshonly			=> true
	}

	exec { "/etc/openshift/server_pub.pem":
		command				=> "/usr/bin/openssl rsa -in /etc/openshift/server_priv.pem -pubout > /etc/openshift/server_pub.pem; chown apache:apache /etc/openshift/server_pub.pem; chmod 640 /etc/openshift/server_pub.pem",
		creates				=> "/etc/openshift/server_pub.pem"
	}

	exec { "/usr/bin/ssh-keygen -t rsa -b 2048 -N '' -f /etc/openshift/rsync_id_rsa":
		creates				=> "/etc/openshift/rsync_id_rsa",
	}

        selinux::boolean { "httpd_unified":
                value                           => on,
        }

        selinux::boolean { "httpd_execmem":
                value                           => on,
        }

        selinux::boolean { "httpd_can_network_connect":
                value                           => on,
        }

        selinux::boolean { "httpd_can_network_relay":
                value                           => on,
        }

        selinux::boolean { "httpd_read_user_content":
                value                           => on,
        }

        selinux::boolean { "httpd_enable_homedirs":
                value                           => on,
        }

        selinux::boolean { "httpd_run_stickshift":
                value                           => on,
        }

        selinux::boolean { "allow_polyinstantiation":
                value                           => on,
        }

        selinux::boolean { "allow_ypbind":
                value                           => on,
        }

        selinux::boolean { "named_write_master_zones":
                value                           => on,
        }

#	exec { "openshift initial user seed":
#		command				=> "/usr/bin/htpasswd -b -c /etc/openshift/htpasswd $openshift_env_name $openshift_env_name",
#		creates				=> "/etc/openshift/htpasswd"
#	}


}

