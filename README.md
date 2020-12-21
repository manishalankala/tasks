# dectask1



deployment.yaml


```

apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus
  labels:
    app: monitor
spec:
  selector:
    matchLabels:
      app: monitor
  template:
    metadata:
      labels:
        app: monitor
    spec:
      containers:
      - name: prometheuscontainer
        image: prom/prometheus:latest
        ports:
        - containerPort: 9090	
	spec:
      containers:
      - name: grafanacontainer
        image: grafana/grafana:latest
        ports:
        - containerPort: 3000
        env:
        - name: MESSAGE
          value: Deployed successfully

```


Service.yaml

```

apiVersion: v1
kind: Service
metadata:
  name: monitor
spec:
  type: ClusterIP
  ports:
  - port: 80
    protocol: TCP
    targetPort: 9090
  selector:
    app: monitor




```
