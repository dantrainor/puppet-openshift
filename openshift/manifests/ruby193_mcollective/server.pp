class openshift::ruby193_mcollective::server (

        $openshift_activemq_topic,                       
        $openshift_activemq_host,                        
        $openshift_activemq_port,                        
        $openshift_activemq_user,                        
        $openshift_activemq_pass, 

) {

	class { 'openshift::ruby193_mcollective::install': } ->
	class { 'openshift::ruby193_mcollective::server::install': } ->
	class { 'openshift::ruby193_mcollective::server::config': 
        	openshift_activemq_topic		=> $openshift_activemq_topic,                       
        	openshift_activemq_host			=> $openshift_activemq_host,                        
        	openshift_activemq_port			=> $openshift_activemq_port,                        
        	openshift_activemq_user			=> $openshift_activemq_user,                        
        	openshift_activemq_pass			=> $openshift_activemq_pass, 
	} ~>
	class { 'openshift::ruby193_mcollective::server::service': } ->
	Class['openshift::ruby193_mcollective::server']
	

}

