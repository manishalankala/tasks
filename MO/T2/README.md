


### Commands

az account list-locations

az login

az group create --name rg --locaton westus

az acr create --resource-group rg --name lab --sku basic

az acr repository list --name lab --output table

az appservice plan create --name app1 --sku F1 --is-linux

az webapp create --plan app1 --name web --deployment-container-image-name lab.azurecr.o/web:$(Build.buildId)

az configure --defaults group=web location=westus





terraform init

terraform validate

terraform plan

terraform apply






### Create a Service Connection  and name the service connection


![image](https://user-images.githubusercontent.com/33985509/130935456-495e88e9-dbdf-47dd-b45c-8193b45085f8.png)

1.

![image](https://user-images.githubusercontent.com/33985509/130935834-b99ec4c5-b1fb-41b3-bb78-446702e35290.png)

2.

![image](https://user-images.githubusercontent.com/33985509/130936093-76a095ee-dacd-4d0b-b028-702c2b18c36c.png)




### For Releases :

![image](https://user-images.githubusercontent.com/33985509/130936856-b179db4c-859c-4bd5-b621-cc78d7695e1a.png)


![image](https://user-images.githubusercontent.com/33985509/130936650-75965437-425e-42be-9f10-d4f18b8f371a.png)


### to add compose task:

![image](https://user-images.githubusercontent.com/33985509/130940979-e303295c-d0b2-44be-a1a0-f02b11c6f4bb.png)


### Errors

ERROR: unauthorized: You do not have permission to download this server image. Please ensure that this server was purchased with your most recent order.

Username: maltego

Password: tasx
