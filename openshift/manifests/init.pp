class openshift (

	$bsn = false,
	$node = false,
	$broker = false,
	$console = false,
	$openshift_cloud_domain = '',
	$openshift_mongo_host = '',	
	$openshift_mongo_port = '27017',
	$openshift_mongo_user = '',
	$openshift_mongo_pass = '',
	$openshift_mongo_db = '',
	$openshift_env_name = '',
	$openshift_bind_server = '',
	$openshift_bind_port = '53',
	$openshift_bind_zone = '',
	$openshift_bind_keyvalue = '',
	$openshift_session_secret = '',
	$openshift_auth_salt = '',
	$openshift_activemq_host = '',
	$openshift_activemq_user = '',
	$openshift_activemq_pass = '',
	$openshift_districts_max_capacity = '2000',
	$openshift_districts_first_uid = '15001',
	$openshift_mcollective_timeout = '360',
	$openshift_bind_krb_keytab = '',
	$openshift_bind_krb_principal = '',
	$openshift_activemq_topic = '',
	$openshift_activemq_port = '61613',
        $openshift_node_profile,
        $openshift_tc_max_bandwidth,
        $openshift_tc_user_share,
        $openshift_cpu_shares,
        $openshift_cpu_cfs_quota_us,
        $openshift_memory_limit_in_bytes,
        $openshift_memory_memsw_limit_in_bytes,
	$openshift_gear_min_uid = '15001',
	$openshift_gear_max_uid = '16999',
	$openshift_broker_host,
	$openshift_valid_gear_sizes,

) {

	if $broker == 'true' {
	        include "::httpd"
	        include "::ntp"

		class {'selinux': } ->
		class {'openshift::ruby193_mcollective::client': 
                	openshift_activemq_topic                => $openshift_activemq_topic,
                	openshift_activemq_host                 => $openshift_activemq_host,
                	openshift_activemq_port                 => $openshift_activemq_port,
                	openshift_activemq_user                 => $openshift_activemq_user,
                	openshift_activemq_pass                 => $openshift_activemq_pass,
		} ->
		class {'openshift::broker::install': } ->
		class {'openshift::broker::config': 
        		openshift_cloud_domain			=> $openshift_cloud_domain,
        		openshift_mongo_host			=> $openshift_mongo_host,
        		openshift_mongo_port			=> $openshift_mongo_port,
        		openshift_mongo_user			=> $openshift_mongo_user,
        		openshift_mongo_pass			=> $openshift_mongo_pass,
        		openshift_mongo_db			=> $openshift_mongo_db,
        		openshift_env_name			=> $openshift_env_name,
        		openshift_bind_server			=> $openshift_bind_server,
        		openshift_bind_port			=> $openshift_bind_port,
        		openshift_bind_zone			=> $openshift_bind_zone,
        		openshift_bind_keyvalue			=> $openshift_bind_keyvalue,
        		openshift_session_secret		=> $openshift_session_secret,
        		openshift_auth_salt			=> $openshift_auth_salt,
        		openshift_activemq_host			=> $openshift_activemq_host,
        		openshift_activemq_pass			=> $openshift_activemq_pass,
        		openshift_districts_max_capacity	=> $openshift_districts_max_capacity,
        		openshift_districts_first_uid		=> $openshift_districts_first_uid,
        		openshift_mcollective_timeout		=> $openshift_mcollective_timeout,
        		openshift_bind_krb_keytab		=> $openshift_bind_krb_keytab,
        		openshift_bind_krb_principal		=> $openshift_bind_krb_principal,
        		openshift_activemq_topic		=> $openshift_activemq_topic,
        		openshift_activemq_user			=> $openshift_activemq_user,
        		openshift_valid_gear_sizes		=> $openshift_valid_gear_sizes,
		} ->
		class {'openshift::broker::service': } ->
		Class ['openshift']
	}

	if $console == 'true' {
		class {'openshift::console::install': } ->
		class {'openshift::console::config' : } ~>
		class {'openshift::console::service': } ->
		Class ['openshift']
	}

	if $bsn == 'true' {
		class { 'openshift::bsn::install': } ->
		class { 'openshift::bsn::config': 
                	openshift_activemq_host => $openshift_activemq_host,
                	openshift_activemq_user => $openshift_activemq_user,
                	openshift_activemq_pass => $openshift_activemq_pass,
                	openshift_activemq_topic => $openshift_activemq_topic,
		} ->
		class { 'openshift::bsn::service': } ->
		Class [ 'openshift' ]
	}

	if $node == 'true' {
		class { 'selinux': } ~>
		class { 'modprobe': } ~>
		class { 'openshift::ruby193_mcollective::server': 
                openshift_activemq_topic                => $openshift_activemq_topic,
                openshift_activemq_host                 => $openshift_activemq_host,
                openshift_activemq_port                 => $openshift_activemq_port,
                openshift_activemq_user                 => $openshift_activemq_user,
                openshift_activemq_pass                 => $openshift_activemq_pass,
		} ~>
		class { 'openshift::node::install': } ~>
                class { 'pam': } ~>
		class { 'cgroups': } ~>
		class { 'openshift::node::config': 
			openshift_node_profile			=> $openshift_node_profile, 
			openshift_tc_max_bandwidth		=> $openshift_tc_max_bandwidth, 
			openshift_tc_user_share			=> $openshift_tc_user_share, 
			openshift_cpu_shares			=> $openshift_cpu_shares, 
			openshift_cpu_cfs_quota_us		=> $openshift_cpu_cfs_quota_us, 
			openshift_memory_limit_in_bytes		=> $openshift_memory_limit_in_bytes, 
			openshift_memory_memsw_limit_in_bytes	=> $openshift_memory_memsw_limit_in_bytes,
			openshift_gear_min_uid			=> $openshift_gear_min_uid,
			openshift_gear_max_uid			=> $openshift_gear_max_uid,
		} ~>
		class { 'openshift::node::service': } ~>
		Class [ 'openshift']

	}

}
			
	
