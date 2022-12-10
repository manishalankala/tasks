### Task:

Using Helm, write the necessary Kubernetes deployment and service files that can be used to create the full application, running 2 instances of each microservice.

Only /calc of acceleration-calc microservices can be available outside of the kubernetes cluster.

Run the application on a kubernetes cluster like Minikube or Docker for Mac.

Make sure the application is stable.

Please do not change a code in services.



-----------------------------------------------------------------------------------

https://helm.sh/docs/intro/install/


helm init

helm create myapp-chart

helm install ./myapp-chart

helm install my-chart --name my-release --namespace my-namespace



To access the /calc endpoint of the acceleration-calc microservice from outside the cluster, you can use the load balancer's IP address and port.

Edit the templates/deployment.yaml and templates/service.yaml files to specify the desired configuration for the deployment and service, respectively.

To make the /calc endpoint of the acceleration-calc microservice available outside the cluster, you can create a Kubernetes ingress resource and specify the path and backend service in the templates/ingress.yaml file.

helm install myapp -f values.yaml

kubectl get deployment

kubectl get services

kubectl logs myapp-acceleration-calc-xxxxx

kubectl command to create a proxy and then access the dashboard in your web browser

kubectl proxy

http://localhost:8001/api/v1/namespaces/kube-system/services/https
