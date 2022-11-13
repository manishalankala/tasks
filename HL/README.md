


## Still in progress ......



![image](https://user-images.githubusercontent.com/33985509/201499975-772933e0-7465-4ff3-a6e7-262ae40b5cbe.png)




Configure awscli

~~~

$ aws configure
AWS Access Key ID [None]: XXXXXXXXXXXXXXXXXXXX
AWS Secret Access Key [None]: xxxxxxxxxxxxxxxxxxx
Default region name [None]: 
Default output format [None]: json

~~~

#### Terraform :

1. local-exec provisioner  :   allow to invoke local executable

2. remote-exec provisioner :  that runs scripts directly in the remote


#### Reference links: 

https://openvpn.net/vpn-server-resources/amazon-web-services-ec2-byol-appliance-quick-start-guide/

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build#prerequisites

https://github.com/adammck/terraform-inventory


#### Note

It doesn’t support features like host-based routing or path-based routing. In other words, it simply distributes the load across all instances that are registered. As a result, the Classic Load Balancer can only distribute traffic to a single URL.
