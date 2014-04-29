class mongodb::config { 

	file { "/etc/mongodb.conf":
		content				=> template("mongodb/etc/mongodb.conf.erb"),
		notify				=> Class["mongodb::service"]
	}	
	
}
