
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
        name: "elastic_container"
        image: docker.elastic.co/elasticsearch/elasticsearch:7.13.3
        env:
          discovery.type: "single-node"
          ES_JAVA_OPTS: "-Xms512m -Xmx512m"
          xpack.security.enabled: "true"
          xpack.monitoring.collection.enabled: "true"
        volumes:
        - "elastic_data:/usr/share/elasticsearch/data"
        log_driver: "json-file"
        log_options: 
          max-size: "50m"
          max-file: "3"
        
        
    - name: RUN kibana container
      docker_container:
        name: "kibana_container"
        image: docker.elastic.co/elasticsearch/kibana:7.13.3
        env:
          server_name: prod.airbus.de
          ELASTICSEARCH_HOSTS: http://{{ elastic_container}}:9200"
          ELASTICSEARCH_USERNAME: "kibana"
          ELASTICSEARCH_PASSWORD: "DSEwW$*]_5P3m-}@Hqb@"
        log_driver:
        log_options: 
          max-size: "50m"
          max-file: "3"  
          
          
          
    - name: logstash pipeline conf check
      file:
        path: "/usr/share/logstash/pipeline"
        state: directory
        
    - name: Copy logstash pipeline conf
      template: src={{ item.src }} dest={{ item.dest }}
      with_items:
        - { src: 'templates/syslog.conf', dest: '/{{ logstash_conf_dir }}/pipeline/syslog.conf' }
        - { src: 'templates/beats.conf', dest: '/{{ logstash_conf_dir }}/pipeline/beats.conf' }
      notify: Restart logstash container
    
    - name: Start logstash container
      docker_container:
        name: "logstash_container"
        image: docker.elastic.co/elasticsearch/logstash:7.13.3
        env:
        ports:
        - 5000:5000
        - 5044:5044
        volumes:
        - "/usr/share/logstash/pipeline://usr/share/logstash/pipeline:ro"
        log_driver:
        log_options: 
          max-size: "50m"
          max-file: "3" 
        
     
        
~~~



Reference links:

https://www.docker.elastic.co/r/elasticsearch
https://www.docker.elastic.co/r/logstash
https://www.docker.elastic.co/r/kibana
