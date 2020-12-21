# dectask1


kubectl create namespace jenkinsprod

A deployment is responsible for keeping a set of pods running


deployment.yaml


```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins
spec:
  replicas: 2
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      containers:
      - name: jenkins
        image: jenkins/jenkins:lts
        ports:
          - name: http-port
            containerPort: 8080
          - name: jnlp-port
            containerPort: 50000
        volumeMounts:
          - name: jenkinsdata
            mountPath: /var/jenkinsdata
      volumes:
        - name: jenkinsdata
          emptyDir: {}	  
	env:
        - name: MESSAGE
          value: Deployed successfully

```




kubectl create -f jenkins.yaml --namespace jenkinsprod

kubectl get pods -n jenkinsprod




A service is responsible for enabling network access to a set of pods

service1.yaml

```
apiVersion: v1
kind: Service
metadata:
  name: jenkins
spec:
  type: NodePort
  ports:
    - port: 8080
      targetPort: 8080
      nodePort: 30000
  selector:
    app: jenkins

```

service2.yaml

```
apiVersion: v1
kind: Service
metadata:
  name: jenkins-jnlp
spec:
  type: ClusterIP
  ports:
    - port: 50000
      targetPort: 50000
  selector:
    app: jenkins

```

kubectl create -f service1.yaml --namespace jenkinsprod  or kubectl apply -f service1.yaml

kubectl create -f service2.yaml --namespace jenkinsprod  or kubectl apply -f service2.yaml

kubectl get services --namespace jenkinsprod

kubectl get service 

kubectl get service jenkins

kubectl get nodes -o wide

open a web browser and navigate to http://your_external_ip:30000



 create ingress rules that expose your deployment to the external world
 
 
Kubernetes ingress is an "object that manages external access to services in a cluster, typically through HTTP". With an ingress, you can support load balancing, TLS termination, and name-based virtual hosting from within your cluster

Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource.
