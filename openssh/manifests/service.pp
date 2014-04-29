class openssh::service {

	include "::openssh::config"

	Class["openssh::config"] -> Class["openssh::service"]

	service { "sshd":
		ensure				=> running,
		enable				=> true
	}

}
