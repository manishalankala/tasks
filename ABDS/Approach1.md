![image](https://user-images.githubusercontent.com/33985509/126074565-0968498c-12c8-475c-967e-ba1f86c5fad6.png)


# Steps

Create 2 vm in azure 

### VM1

Nodes network configuration : Home -> VM -> VM1-> Networking Add inbound rule -> Elasticsearch -> allow port 9200 - 9300


### 1.Install elasticsearch

curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.1-amd64.deb

dpkg -i elasticsearch-7.10.1-amd64.deb

vi /etc/elasticsearch/elasticsearch.yml

~~~
cluster name: test-azure
node.name: VM1
node.master: true
network.host: ["10.0.0.4", "localhost"]
discovery.seed_hosts: ["10.0.0.4", "10.0.0.5"]
cluster.initial_master_nodes: ["10.0.0.4", "10.0.0.5"]
~~~

curl localhost:9200


# VM2


Nodes network configuration : Home -> VM -> VM2-> Networking Add inbound rule -> Kibana -> 5601 

Nodes network configuration : Home -> VM -> VM2-> Networking Add inbound rule -> logstash -> 5050



### 1.Install elasticsearch

curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.1-amd64.deb

dpkg -i elasticsearch-7.10.1-amd64.deb

vi /etc/elasticsearch/elasticsearch.yml

~~~
cluster name: test-azure
node.name: VM2
node.master: true
network.host: ["10.0.0.5", "localhost"]
discovery.seed_hosts: ["10.0.0.4", "10.0.0.5"]
cluster.initial_master_nodes: ["10.0.0.4", "10.0.0.5"]
~~~

curl localhost:9200

Check the cluster health:  curl -X GET "localhost:9200/_cluster/health?pretty"


### 2.Install Logstash

apt-get install default-jre

curl -L -O https://artifacts.elastic.co/downloads/logstash/logstash-7.10.1-amd64.deb

dpkg -i logstash-7.10.1-amd64.deb

vi /etc/logstash/logstash.yml

~~~

Uncomment and change this line to true: --> config.reload.automatic: true

Edit pipelines.yml file:

nano /etc/logstsh/pipelines.yml
put these 2 lines in the file
- pipeline.id: azurelogstash
  path.config: "/etc/logstash/conf.d/azurelogstash.conf"

nano /etc/logstash/conf.d/azurelogstash.conf
Put these lines in it:

input {
  beats {
    port => 5050
  }
}

# filter {
#
# }

output {
  elasticsearch {
    hosts => ["http://localhost:9200", "http://10.0.0.4:9200"(optional)]
    index => "azureestest-%{+yyyy-MM-dd}"
  }
}
~~~

systemctl start logstash

Check that the pipeline is up and running: --->  tail -f /var/log/logstash/logstash-plain.log


### 3.Install Kibana

curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-7.10.1-amd64.deb

dpkg -i kibana-7.10.1-amd64.deb

vi /etc/kibana/kibana.yml

replace this line (server.host: "10.0.0.5")

systemctl start kibana

systemctl status kibana



### In local machine

https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.10.1-windows-x86_64.zip

filebeat.yml

~~~
  enabled: true
  
  paths:
    #- /var/log/*.log
    - C:\Users\nbglink\Desktop\logs\*.log 
    
output.logstash:
  # The Logstash hosts
  hosts:["Put here the Azure public IP for your Losgtash node(VM2):5050"]
~~~


Run .\filebeat.exe -c filebeat.yml -e -d "*"
