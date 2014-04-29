class cgroups::service {

        service { "cgconfig":
                enable                          => true,
                ensure                          => running
        }

        service { "cgred":
                enable                          => true,
                ensure                          => running
        }

}

