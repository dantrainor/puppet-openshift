class selinux {

	class { "selinux::install": } ->
	Class['selinux']
}
