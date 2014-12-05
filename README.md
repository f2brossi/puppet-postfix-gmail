puppet-postfix-gmail
====================

Puppet + Vagrant for configuring Postfix to Use Gmail SMTP on Ubuntu 

NB: No more than 500 mails a day are authorized.


## Quick Start with Vagrant openstack provider

Install the vagrant plugin for openstack, 

```
$ vagrant plugin install vagrant-openstack-provider
...
```

Within the Vagrantfile, specify your openstack credentials, your vm configuration and your gmail credentials

And finally run `vagrant up --provider=openstack`.

### Openstack Credentials

* `username` - The username with which to access Openstack.
* `password` - The API key for accessing Openstack.
* `tenant_name` - The Openstack project name to work on
* `openstack_auth_url` - The endpoint to authentication against. By default, vagrant will use the global
openstack authentication endpoint for all regions with the exception of :lon. IF :lon region is specified
vagrant will authenticate against the UK authentication endpoint.
* `openstack_compute_url` - The compute service URL to hit. This is good for custom endpoints. If not provided, vagrant will try to get it from catalog endpoint.
* `openstack_network_url` - The network service URL to hit. This is good for custom endpoints. If not provided, vagrant will try to get it from catalog endpoint.

### VM Configuration

* `server_name` - The name of the server within Openstack Cloud. 
* `flavor` - The name of the flavor to use for the VM
* `image` - The name of the image to use for the VM

### Gmail credentials  

In the Vagrantfile just replace 'mygmailaccount' and 'mypassword' with your actual credentials. Anjoy!


