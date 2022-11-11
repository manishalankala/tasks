#!/bin/sh

##### Install Dependencies ######

apt-get update -y
apt-get install git vim curl wget software-properties-common python3.6 -y


##### RUN ansible playbook #####
## ansible-playbook -i hosts ./ansible/nginx/
