#!/bin/sh

##### Install Dependencies ######

apt-get update -y
apt-get install git vim -y


##### RUN ansible playbook #####
## ansible-playbook -i hosts ./ansible/nginx/
