class pam {

	class { "pam::config": } ->
	Class ["pam"]

}
