define selinux::boolean($value) {

	selboolean { "$title":
		value                           => $value,
		persistent                      => true
	}

}
