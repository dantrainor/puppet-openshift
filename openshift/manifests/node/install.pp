class openshift::node::install { 

        $openshift_cartridges                   = ["openshift-origin-cartridge-php.noarch", "openshift-origin-cartridge-mysql.noarch", "openshift-origin-cartridge-nodejs.noarch" , "openshift-origin-cartridge-haproxy.noarch" ]

	Package {
		ensure				=> latest
	}

	package { "rubygem-openshift-origin-node":
	}

	package { "ruby193-rubygem-passenger-native":
	}

	package { "openshift-origin-node-util":
	}

	package { "rubygem-openshift-origin-container-selinux":
	}

	package { "rubygem-openshift-origin-frontend-nodejs-websocket":
	}

	package { "rubygem-openshift-origin-frontend-apache-mod-rewrite":
	}

	package { "openshift-origin-msg-node-mcollective":
	}

	package { $openshift_cartridges:
	}

}
