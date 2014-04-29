class openssh::config {

	include "::openssh::install"

	Class["openssh::install"] -> Class["openssh::config"]

	augeas { 'Tune sshd config':
		context 				=> "/files/etc/ssh/sshd_config",
		changes 				=> [
		'set MaxSessions 40',
		'set MaxStartups 40',
		'set AcceptEnv[5]/01 GIT_SSH',
		],
		onlyif					=> "match AcceptEnv[*]/*[. = 'GIT_SSH'] size == 0",
		notify					=> Class["openssh::service"]
	}

}
