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

```