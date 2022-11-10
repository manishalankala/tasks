#!/bin/sh



##### Install Dependencies ######

apt-get update -y
apt-get install git vim -y


##### if need to  clone repository  ######
### git clone 

##### RUN ansible playbook #####

ansible-playbook ./ansible/nginx/
