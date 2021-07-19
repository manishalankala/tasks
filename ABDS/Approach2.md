
elk.yaml

~~~

---
- hosts: managednode
  become: true
  gather_facts: yes
  
  tasks:
    - name: CREATE elastic search volume
      docker_volume:
        name: elastic_data
        driver: local
    - name: RUN elastic search container
      docker_container:
        name: elastic_container
        image: docker.elastic.co/elasticsearch/elasticsearch:7.13.3
        env:
          discovery.type: "single-node"
          ES_JAVA_OPTS: "-Xms512m -Xmx512m"
          xpack.security.enabled: "true"
          xpack.monitoring.collection.enabled: "true"
        volumes:
        - "elastic_data:/usr/share/elasticsearch/data"
        
~~~



Reference links:

https://www.docker.elastic.co/r/elasticsearch
https://www.docker.elastic.co/r/logstash
https://www.docker.elastic.co/r/kibana
