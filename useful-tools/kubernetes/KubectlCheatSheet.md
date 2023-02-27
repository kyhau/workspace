# kubectl CheatSheet

```
kubectl api-resources

kubectl get all

# Get doco for a resource type
kubectl explain

kubectl describe [pod | deployment] [pod-name | deployment-name]

######################################
# Deployment

# Alternate way to create or apply changes to a Deployment
kubectl apply -f xxx.yaml

# Use --save-config when you want to use kubectl appply in the future
kubectl create deploy <name> --image=<image> --replicas=<replicas>
kubectl create -f xxx.yaml --save-config

# List all Deployments and their labels
kubectl get deployments --show-labels

# Get all Deployments with a specific label (e.g. app)
kubectl get deployment -l app=nginx

# Delete a Deployment
kubectl delete deployment [deployment-name]
kubectl delete -f xxx.yaml

# Scale the Deployment Pods to 5
kubectl scale deployment [deployment-name] --replicas=5
kubectl scale -f xxx.yaml --replicas=5

######################################
# Port forward

# Listen on port 8080 locally and forward to port 80 in Pod
kubectl port-forward pod/[pod-name] 8080:80

# Listen on port 8080 locally and forward to Deployment's Pod
kubectl port-forward deployment/[deployment-name] 8080:80

# Listen on port 8080 locally and forward to Service's Pod
kubectl port-forward service/[service-name] 8080:80

######################################
# Service

# Create a Service (default type==ClusterIP)
kubectl create -f file.service.yml

# Update a Service
# Assume --save-config was used with create
kubectl apply -f file.service.yml

# Delete a Service
kubectl delete -f file.service.yml

######################################
# exec - e.g. Test a Service and Pod with curl

# Shell into a Pod and test a URL
# Add -c [containereID] in cases where multiple containers are running in the Pod
kubectl exec [pod-name] -- curl -s http://podIP

# Interactive mode
kubectl exec [pod-name] -it sh
> apk add curl
> curl -s http://podIP


```