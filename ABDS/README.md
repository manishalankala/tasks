
control node  we will install ansible 


Steps :

RHEL 7 - Python 2.7 installed by default

RHEL 8 - Python 3.6 installed by default


If you are using RHEL Satellite to install Ansible on an RHEL 8 system, 

make sure you add the repositories for Red Hat Ansible Engine 2.9 for RHEL 8 x86_64 (RPMs) from the Satellite GUI and 

sync the repositories from the CDN to the Satellite. 

On the control node, you must register with the Satellite server, enable the Satellite tools, and enable the Ansible repository.

~~~

# subscription-manager repos --enable satellite-tools-6.6-for-rhel-8-x86_64-rpms

Repository' satellite-tools-6.6-for-rhel-8-x86_64-rpms' is enabled for this system.

# subscription-manager repos --enable ansible-2.9-for-rhel-8-x86_64-rpms

Repository' ansible-2.9-for-rhel-8-x86_64-rpms' is enabled for this system.

~~~


$ssh-keygen


To copy ssh public key

~~~
ssh-copy-id managedhost@IPADDRESS

ssh-copy-id publiccloudvm@PUBLICIPADDRESS

# ssh-copy-id <target user>@<IP address/Hostname of the managed node>

#### sshd_config file and disable the password authentication

The command ssh-copy-id will copy the control node's public key to the authorized_keys file on the managed nodes

~~~

On control node


sudo yum install python3

sudo yum update python3

python3 -V

sudo yum install ansible  - RHEL
