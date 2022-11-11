#!/bin/sh

##### Install Dependencies ######


sudo amazon-linux-extras install -y epel
sudo apt-get update -y
sudo apt-get install git vim curl wget -y
sudo apt-get install software-properties-common python3.6 -y
sudo useradd ubuntu
echo -e 'ubuntu\nubuntu' | sudo passwd ubuntu
echo 'ubuntu ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/ubuntu
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo systemctl restart sshd.service



##### RUN ansible playbook #####
## ansible-playbook -i hosts ./ansible/nginx/
