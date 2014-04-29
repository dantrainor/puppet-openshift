class openshift::bsn::config (

        $openshift_activemq_host,
        $openshift_activemq_user,
        $openshift_activemq_pass,
        $openshift_activemq_topic,

) {

        # Use puppetlabs' provided activemq module
        class { 'activemq':
                openshift_activemq_host => $openshift_activemq_host,
		openshift_activemq_user => $openshift_activemq_user,
		openshift_activemq_pass => $openshift_activemq_pass,
		openshift_activemq_topic => $openshift_activemq_topic,
        }

	class{'mongodb::config': } ->
	Class['openshift::bsn::config']

}

