# Building
```bash
g++ main.cpp -o server
```
Building docker image
```bash
docker build . -t hello-world
```

# Kubernetes
I already have minicube configured, im using that for the project.
```
minicube start
kubectl apply -f deployment.yaml
kubectl get po -w
```
Ha a pod running state-be tér akkor elerhető ip:30080 címen. Ip cím megszerzéseÉ
```
minicube ip
```
Gyors tesztelés
```
curl <minicube-ip>:30080
```
cleanup
```
kubectl delete -f deployment.yaml
```
# Terraform
lehet konfigurálni kell a kubeconfig helyét a fájlban más gépeken
```
terraform init
terraform plan
terraform apply
```
