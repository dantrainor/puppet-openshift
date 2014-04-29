class cgroups::install {

        package { "libcgroup":
                ensure                          => latest,
        }

        package { "libcgroup-pam":
                ensure                          => latest,
        }

}

