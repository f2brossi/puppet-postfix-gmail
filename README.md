puppet-postfix-gmail
====================

Puppet Configuring Postfix to Use Gmail SMTP on Ubuntu 

NB: No more than 500 mails a day are authorized.


## Quick Start with Vagrant

After installing the vagrant plugin for openstack, 

```
$ vagrant plugin install vagrant-openstack-provider
...
```

you need to specify all the details manually within a `config.vm.provider` block in the Vagrantfile

And then run `vagrant up --provider=openstack`.


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

* `server_name` - The name of the server within Openstack Cloud. This
  defaults to the name of the Vagrant machine (via `config.vm.define`), but
  can be overridden with this.
* `flavor` - The name of the flavor to use for the VM
* `image` - The name of the image to use for the VM

#### Floating IPs

* `floating_ip` - The floating IP to associate with the VM. This IP must be formerly allocated.

#### Networks

* `networks` - Network list the server must be connected on. Can be omitted if only one private network exists
  in the Openstack project



