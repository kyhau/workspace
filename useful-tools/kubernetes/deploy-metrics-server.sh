# Deploy the Metrics Server

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Verify that the metrics-server deployment is running the desired number of pods with the following command

kubectl get deployment metrics-server -n kube-system
# NAME             READY   UP-TO-DATE   AVAILABLE   AGE
# metrics-server   1/1     1            1           57s

# Usage

# 1. View metric snapshots using kubectl top
kubectl top node
kubectl top pod --all-namespaces

# 2. Use kubectl get to query the Metrics API

# 2.a) To query the CPU and memory usage of a node
kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes/<NODE_NAME> | jq

# 2.b) To query the CPU and memory usage of a pod
kubectl get --raw /apis/metrics.k8s.io/v1beta1/namespaces/<NAMESPACE>/pods/<POD_NAME> | jq
