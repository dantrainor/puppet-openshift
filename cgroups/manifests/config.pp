class cgroups::config {

	include "cgroups::exec"

        file { "/etc/cgconfig.conf":
                source                          => "puppet:///modules/cgroups/etc/cgconfig.conf",
                notify                          => Class["cgroups::exec"],
                replace                         => false
        }

}

