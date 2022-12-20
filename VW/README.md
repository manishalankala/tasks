
### Terraform :

terraform init

terraform plan

terraform apply



### Resources to use for implementaion

aws_autoscaling_group

aws_route53_zone

aws_route53_record

aws_vpc

aws_subnet

aws_internet_gateway

aws_main_route_table_association

aws_route_table

aws_ec2_transit_gateway

aws_ec2_transit_gateway_vpc_attachment

aws_ec2_transit_gateway_route_table

aws_ec2_transit_gateway_route_table_association






Transit gateway :

To connect multiple VPCs,acts as a gateway connecting up to 5.000 networks best alternative to vpc peering


## Blue Green deployment

Scaling of nodes can be implemented via replica set in deployment.yaml - approach would be a blue green deployment


Green application online, blue application down, traffic goes to green

Green application online, blue application online, traffic goes to green

Green application online, blue application online, traffic goes to blue

Green application down, blue application online, traffic goes to blue




