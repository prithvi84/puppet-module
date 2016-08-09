# puppet-module

Hi,

the task is to create a secured webserver which only uses https for it communications and the http request are directed 

by the nginx module we could install, restart and configure simple webserver from scratch on puppet nodes

first in AWS for demo :

1) we take three instances in same subnet so that all the machines are pingable to each other and discoverable to each other

2) then we pick puppet master and install puppet master ( in ubuntu -- apt-get install puppet puppetmaster facter)

3) install puppet agent on nodes 

4)puppet command 'puppet agent --server=puppet.master.com --no-daemonize --verbose' this will show the certificate requesting steps in detail
by puppet agent when connecting to puppet master(FQDN=puppet.master.com)

5) puppet master signs the certs from puppet agent ( eg : puppet cert --list & puppet cert --sign node1.puppet.com )

6) this would let secure & trusted communication between agent and master



Now moving to the nginx module:

to make it simple for readabililty I have put all the classes in nginx module in init.pp ( u could break it down for convinience)

the code in init.pp will install the nginx webserver on nodes, with for delivering simple content in html format (index.html) for it requestors

I have used self signed certs using openssl and used to secure communications on the webserver on port 443 (default.conf of nginx), iptables firewall rules can be put in place on servers to allow 

connections from accepted source address, we can add security layer by adding aws security groups (incase of AWS ),


nodes.pp (node definitions) & site.pp are created as per puppet "rule book"

directory structure :

/etc/puppet/modules/nginx/manifests/init.pp
/etc/puppet/modules/nginx/files/*
/etc/puppet/modules/templates/*
/etc/puppet/manifests/site.pp
/etc/puppet/manifests/node.pp

(please check the directories for details)
