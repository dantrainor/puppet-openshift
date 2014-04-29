puppet-openshift
================

Puppet OpenShift module with Foreman integration

This module is to facilitate the deployment of OpenShift Enterprise 2.0 installations.

It is comprised of several parts:
* "Meta" modules, used to provide supporting infrastructure pieces.  These pieces may or may not already exist in your organization; however, if they do exist, modifications must be made to them to incorporate the core OpenShift module
* Foreman Class Parameters, which must be defined on a per-Hostgroup basis under which hosts fall
* Foreman Host Groups
* ...
* ...
* ...

# System preparation #

A number of system preparation tasks must take place prior to deploying the Puppet OpenShift module on a host or host group.  Pleas ensure the following steps are taken prior to deployment:

- Systems must be fully updated
- SELinux must be enabled
	- sed -i 's/SELINUX=.*/SELINUX=enforcing/g' /etc/selinux/config
	- touch /.autorelabel
	- reboot
- A broker must have a working Kerberos configuration to facilitate DNS updates.  By default, the Puppet OpenShift module will look for a Keytab located at /etc/dns.keytab
	- This Keytab location can be overriden by adjusting the $openshift_bind_krb_keytab paramater
	- Ensure you are able to kinit, klist, kdestroy to vett Kerberos configuration
- Repos must be properly configured and nodes assigned to them ### needs fixing
	- Brokers
		- OpenShift_Client
		- OpenShift_Infrastructire
		- RHSCL
	- BSNs
		- OpenShift_Infrastructure
	- Nodes
		- rhel-6-server-ose-2.0-node-rpms
		- rhel-6-server-ose-2.0-node-jbosseap-rpms
		- rhel-server-rhscl-6-rpms
		- openshift_dwa_cartridges
		- jb-eap-6-for-rhel-6-server-rpms
		- jb-ews-2-for-rhel-6-server-rpms

# Module organization #

Each module is broken down, as necessary, in to an ::install, ::config::, and ::service sub-module.  Additional classes, such as ::exec and ::selinux may also be present depending on the function of the module or primary class.  Each module may also contain associated files and templates under a files/ or templates/ directory under each respective module, depending on the function of the module.  This format follows the standard Puppet module auto-discovery features and layouts.

# Foreman environments #

The Puppet OpenShift module is designed to work in Foreman on systems classified by one specific Host Group and three or more additional, specific Host Groups
- Host Group (Environment)
- Host Group (Environment) / OSE Brokers
- Host Group (Environment) / OSE Nodes
- Host Group (Environment) / OSE Nodes / Small
- Host Group (Environment) / OSE Nodes / Medium
- Host Group (Environment) / OSE Nodes / (additional node profiles)

Each "Host Group" should indicate a logical separation of Brokers, BSNs, and each Node profile (e.g. small, medium).  Each host should be added to one of these groups.  Doing so allows you to override Class Paramaters that are specific to each host role.


# Module installation #

Copy the contents of the Puppet OpenShift Module git repo to the environment in which your Puppet installation represents.

Once copied, refresh Foreman's view of the environment with Configure -> Puppet Classes -> "Import from ....", and select the Puppet OpenShift module ('openshift') along with all the other meta modules.

Once refreshed, attach the 'openshift' module to the Primary Environment Name, represented as a Host Group.

After the 'openshift' module has been attached, Class Parameters can be specified as Smart Class Paramaters and assigned to the 


# Module configuration #

The OpenShift Module relies heavily on Paramaterized Classes.  These classes can take paramaterized arguments of configuration directives to specify functions and operations of the OpenShift module.  A complete list of these paramaters can be found inside the openshift/manifests/init.pp manifest file, listed as arguments of the 'openshift' class itself.

Additionally, a list of each Foreman-interpreted paramater, along with the paramater name, setting, type, default value and additional notes can be found in the 'paramaters.txt' file.

Each of these paramaters can be overwritten in Foreman's Puppet Class, Smart Class Paramater interface.  To set a specific paramater, use the following procedure:

1)  Navigate to the Smart Class Paramater tab for the 'openshift' module
1a) Configure -> Puppet Classes -> 'openshift' -> Smart Class Paramaters
2)  Select the Paramater on the left that you wish to override
3)  Click the 'Override' check box
4)  

All of the Class paramaters should be evaluated and set on a per-Host Group basis, with the exception of the following.  The following Paramaters should be set on a per-Node group basis, corresponding to a specific Node Profile:
- openshift cpu cfs quota us
- openshift cpu shares
- openshift memory limit in bytes
- openshift memory memsw limit in bytes
- openshift node profile
- openshift tc max bandwidth
- openshift tc user share

Four special Class Paramaters exist to designate the purpose of a Host.  They can be set on a per-Host group basis.  The following are true/false Paramaters which define the purpose of a system, e.g. Broker, Node, BSN and/or Console:
- broker
- node
- bsn
- console


# Special BSN considerations #

Due to the volatile nature of databases as a whole, the Mongo installation on the BSN must be initialized by hand.  This process involves creating a new Mongo schema and assigning a username and password to the schema.  The following steps must be preformed after the BSN components are installed, on the BSN itself:

# mongo
> use <given mongo schema name of environment>
> db.addUser("<given mongo user name of environment>","<given mongo password of environment>")
^D


# Final steps #

Once the Puppet OpenShift Module has been deployed on all required hosts, and after the Mongo schema has been initialized by hand, reboot all hosts starting with the BSN.  This gives the OpenShift environment an opportunity to ensure all dependent services re-start and to warm the rest of the environment components.


# Testing and Verification of Environment #

Once the environment has been rebooted, you should be able to issue an 'rhc setup --server <fqdn of broker>'.  You will then be asked to create and submit SSH key pairs.  Once client setup is complete, you should be able to create OpenShift applications.

In addition to testing with 'rhc', it should also be possible to run 'oo-accept-broker' and 'oo-accept-node' on respective hosts and see these commands execute with complete success.

The OpenShift Console should also be available at a URL which is that of a Broker's FQDN.



# Extending the module #

Additional configuration items and Paramaters will be desired as the number of deployments increase and familiarity of OpenShift as a whole grows.  It is anticipated that most of these additional items will be implemented in the form of template changes.  Simple knowledge of ERB will be required to implement this, though plenty of examples of simple ERB variable substitution and array walking exists throughout the code base.  These changes are found in the 'templates/' directory of each module.

To add Paramaters, study the contents and flow of the openshift/manifests/init.pp manifest.  Assign a new Paramater where the other Paramaters are located, and follow the flow of Class calls and respective arguments to make the variables interoperable from within a template.  






