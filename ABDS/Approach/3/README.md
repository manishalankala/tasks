## Approach 3

![image](https://user-images.githubusercontent.com/33985509/127287742-f4631405-0166-49cf-ac94-7e9a20f93467.png)





## Alternative approach

![image](https://user-images.githubusercontent.com/33985509/127288933-7f38203d-5836-4251-af99-5bc429eda03c.png)










create instance in azure ubuntu 18 or 20

### Docker
~~~

apt update
apt upgrade
apt-get install curl apt-transport-https ca-certificates software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update
apt install docker-ce
~~~

### ansible

~~~
apt-get install python3-pip python-dev
apt install software-properties-common
apt-add-repository ppa:ansible/ansible
apt update
apt-get install ansible -y

~~~

### Specific version

~~~
sudo add-apt-repository --update ppa:ansible/ansible-2.9.7
sudo apt install ansible

or 

apt-get install python-pip python-dev
sudo -H pip install ansible==2.9.7
~~~


### jenkins

~~~
sudo apt update	
sudo apt install openjdk-8-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl status jenkins

~~~


### Instance

![image](https://user-images.githubusercontent.com/33985509/127038871-eb1d3376-c800-439b-8659-aadc9424b365.png)

### Network

![image](https://user-images.githubusercontent.com/33985509/127039248-9ddfe93d-9192-4b1d-ad1c-9756e8463a29.png)


### jenkins
![image](https://user-images.githubusercontent.com/33985509/127039391-a190c8c7-9a0a-4117-8d99-5bb09c850469.png)

![image](https://user-images.githubusercontent.com/33985509/127039571-b127be02-4ad5-4bb0-a972-41266520150b.png)

![image](https://user-images.githubusercontent.com/33985509/127039815-736f0c62-09f8-4f93-9525-47dad20fd1a0.png)

![image](https://user-images.githubusercontent.com/33985509/127039862-a9783bfd-d120-4a6b-a2e4-a6e0f1922791.png)

![image](https://user-images.githubusercontent.com/33985509/127039928-46b905a5-3260-466c-aa84-7c4bda137ebe.png)

![image](https://user-images.githubusercontent.com/33985509/127040044-da29f350-1009-4e3c-9ac1-f1f3ce0a733a.png)


![image](https://user-images.githubusercontent.com/33985509/127040116-d6c4d1e8-4c71-4c0e-93b5-d2441c206f4a.png)

![image](https://user-images.githubusercontent.com/33985509/127040268-f7bcf572-ca9f-4898-bb91-ab87a01fff0b.png)

![image](https://user-images.githubusercontent.com/33985509/127040442-d72aa2ef-fcd4-41a8-96ad-d0adb20cbc16.png)

![image](https://user-images.githubusercontent.com/33985509/127040924-56177a7d-91fc-4025-ad34-c89882c2df03.png)

![image](https://user-images.githubusercontent.com/33985509/127043309-ccc021cc-802f-4d80-85e0-e747fd029cc2.png)


![image](https://user-images.githubusercontent.com/33985509/127043384-1a7a8fe8-0240-4ee7-9133-2b3f0b1114ff.png)

![image](https://user-images.githubusercontent.com/33985509/127045765-8bff12b4-7dbf-47cc-a7c6-0b4a5257a412.png)


![image](https://user-images.githubusercontent.com/33985509/127209077-140a0906-f895-4e68-b2f1-443d175de642.png)

![image](https://user-images.githubusercontent.com/33985509/127209203-3bd78a7f-1747-4cb2-86a7-5f3cdeaa7759.png)

![image](https://user-images.githubusercontent.com/33985509/127209255-6b390bc9-5b52-460e-80ba-38f242c3c528.png)

![image](https://user-images.githubusercontent.com/33985509/127209320-9c6b245d-168b-4dd2-bb42-c367c0488960.png)







### Errors :

![Pasted Graphic 1](https://user-images.githubusercontent.com/33985509/128192628-2800df36-fe03-4121-ba0e-ae4c0dbbbd27.png)

sol : add under /etc/ansible/ansible.cfg

![image](https://user-images.githubusercontent.com/33985509/128192997-b3c91a6d-89c6-4f1f-be19-ae261f9391f9.png)

![image](https://user-images.githubusercontent.com/33985509/127304389-744a3c5d-3156-4991-b237-0df3c054ac46.png)

![Pasted Graphic 2](https://user-images.githubusercontent.com/33985509/128193022-1da729f7-ddc1-4626-ab00-f04761635ec2.png)

Sol : 

chmod 666 /var/run/docker.sock

sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget build-essential checkinstall


![Pasted Graphic](https://user-images.githubusercontent.com/33985509/128193224-d0d64257-bf39-419b-9270-69e481ebedc2.png)

sol: 

ansible-galaxy collection install community.docker

ansible-galaxy collection install ansible.posix



Steps to run in local : 

ssh -i pemfile user@ip (on a vm)

git clone https://github.com/manishalankala/dectask1.git

cd dectask1/ABDS/Approach/3/

ansible-playbook -i inventory.ini site.yml -vvv


