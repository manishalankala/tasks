# dectask1


mkdir ~/.kube

kubectl version

kubectl create namespace jenkinsprod

A deployment is responsible for keeping a set of pods running


deployment.yaml


```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: jenkins-deploymment
  template:
    metadata:
      labels:
        app: jenkins-deployment
    spec:
      containers:
      - name: jenkins
        image: jenkins/jenkins:lts
        ports:
          - name: http-port
            containerPort: 8080
          - name: jnlp-port
            containerPort: 50000
	env:
       - name: JENKINS_ROOT_PASSWORD
         valueFrom:
           secretKeyRef:
             name: jenkins-root-password
             key: ryd$@!!!!ryd
        envFrom:
        - secretRef:
            name: jenkins-user-credentials
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



 create ingress rules that expose your deployment to the external world
 
 kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
 
 kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud-generic.yaml

Kubernetes ingress is an "object that manages external access to services in a cluster, typically through HTTP". With an ingress, you can support load balancing, TLS termination, and name-based virtual hosting from within your cluster

Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the Ingress resource.


service1.yaml

```
apiVersion: v1
kind: Service
metadata:
  name: jenkins-service
spec:
  type: NodePort
  ports:
    - port: 8080
      targetPort: 8080
      nodePort: 30000
  selector:
    app: jenkins-deployment
  type: ClusterIP

```

service2.yaml

```
apiVersion: v1
kind: Service
metadata:
  name: jenkins-service-jnlp
spec:
  type: ClusterIP
  ports:
    - port: 50000
      targetPort: 50000
  selector:
    app: jenkins-deployment
  type: ClusterIP

```

kubectl create -f service1.yaml --namespace jenkinsprod  or kubectl apply -f service1.yaml

kubectl create -f service2.yaml --namespace jenkinsprod  or kubectl apply -f service2.yaml

kubectl get services --namespace jenkinsprod

kubectl get service 

kubectl get service jenkins

kubectl get nodes -o wide

open a web browser and navigate to http://your_external_ip:30000


kubectl get pods -n ingress-nginx

kubectl get svc


ingress.yaml

```

apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: jenkins-ingress
spec:
  rules:
  - http:
      paths:
      - path: /data
        backend:
          serviceName: jenkins-service
          servicePort: 8080
      - path: /data
        backend:
          serviceName: jenkins-service-jnlp
          servicePort: 50000
	  
```


kubectl apply -f ingress.yaml

kubectl get svc -n ingress-nginx ingress-nginx -o=jsonpath='{.status.loadBalancer.ingress[0].ip}'


secrets.yaml

```
apiVersion: v1
kind: Secret
metadata:
  name: jenkins-root-password
type: Opaque
data:
  password: ryd$@!!!!ryd
  
```
