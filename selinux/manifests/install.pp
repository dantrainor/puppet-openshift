class selinux::install {

        package { "policycoreutils-python":
                ensure                          => latest
        }

}

