class openshift::ruby193_mcollective::client (

        $openshift_activemq_topic,                       
        $openshift_activemq_host,                        
        $openshift_activemq_port,                        
        $openshift_activemq_user,                        
        $openshift_activemq_pass, 
) {

        class { 'openshift::ruby193_mcollective::install': } ->
        class { 'openshift::ruby193_mcollective::client::install': } ->
        class { 'openshift::ruby193_mcollective::client::config': 
        	openshift_activemq_topic		=> $openshift_activemq_topic,                       
        	openshift_activemq_host			=> $openshift_activemq_host,                        
        	openshift_activemq_port			=> $openshift_activemq_port,                        
        	openshift_activemq_user			=> $openshift_activemq_user,                        
        	openshift_activemq_pass			=> $openshift_activemq_pass, 
	} ->
        Class [ 'openshift::ruby193_mcollective::client']

}

