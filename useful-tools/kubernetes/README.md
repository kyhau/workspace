# Kubernetes Notes

Jump to
- [Development tools](#development-tools)
- [IaC and CICD](#iac-and-cicd)
- [Infrastructure testing](#infrastructure-testing)
- [MLA and Dashboards](#mla-and-dashboards)
- [Networking](#networking)
- [Useful diagrams](#useful-diagrams)


---
## Development tools

- AWS resources (e.g. EKS, CDK, CDK8s) -> [kyhau/aws-tools/EKS](https://github.com/kyhau/aws-tools/tree/master/EKS)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/)
    - A command line tool for communicating with a Kubernetes cluster's control plane, using the Kubernetes API.
- [minikube](https://github.com/kubernetes/minikube)
    - minikube implements a local Kubernetes cluster on macOS, Linux, and Windows.
- [k8slens.dev](https://k8slens.dev/)
    - Lens - The Kubernetes IDE, provides the full situational awareness for everything that runs in Kubernetes.


---
## IaC and CICD

- AWS resources (e.g. EKS, CDK, CDK8s) -> [kyhau/aws-tools/EKS](https://github.com/kyhau/aws-tools/tree/master/EKS)
- [Kustomize](https://kustomize.io/)
    - Kustomize uses a template-free approach to customize application configuration.
    - Kustomize traverses a Kubernetes manifest to add, remove or update configuration options without forking.
- [Helm](https://helm.sh)
    - Helm is a package manager for Kubernetes that allows developers and operators to more easily package, configure, and deploy applications and services onto Kubernetes clusters.
    - [Artifact Hub](https://artifacthub.io/packages/)
    - See also [EKS Charts](https://github.com/aws/eks-charts).
- [Skaffold](https://github.com/GoogleContainerTools/skaffold)
    - Skaffold handles the workflow for building, pushing, and deploying your application, and provides building blocks for creating CI/CD pipelines.
- [Flux](https://github.com/fluxcd/flux2)
    - Flux is a tool for keeping Kubernetes clusters in sync with sources of configuration (like Git repositories), and automating updates to configuration when there is new code to deploy.
    - Requires Kubernetes clusters to have access to GitHub repositories. There will also be an additional bootstrap process to install Flux first.
- [Argo Rollouts](https://github.com/argoproj/argo-rollouts/)
    - Argo Rollouts is a Kubernetes controller and set of CRDs which provide advanced deployment capabilities such as blue-green, canary, canary analysis, experimentation, and progressive delivery features to Kubernetes.
    - It does not support StatefulSets.
- [Flagger](https://github.com/fluxcd/flagger)
    - Flagger can run automated application analysis, testing, promotion and rollback for the following deployment strategies: Canary, A/B Testing, Blue/Green).
    - Flagger is similar to Argo Rollouts as it stores state to rollback deployments.
    - Flagger does not support StatefulSets.

---
## Infrastructure testing

- [Datree](https://github.com/datreeio/datree)
    - Datree is a CLI tool that supports Kubernetes admins in their roles by preventing developers from making errors in Kubernetes configurations that can cause clusters to fail in production.
- [kube-bench](https://github.com/aquasecurity/kube-bench)
    - kube-bench is a tool that checks whether Kubernetes is deployed securely by running the checks documented in the [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes/).
- [Popeye](https://github.com/derailed/popeye) (Kubernetes Cluster Sanitizer)
    - Popeye is a utility that scans live Kubernetes cluster and reports potential issues with deployed resources and configurations. It sanitizes your cluster based on what's deployed and not what's sitting on disk.
- [KUTTL](https://kuttl.dev/docs/what-is-kuttl.html) (KUbernetes Test TooL)
    - A testing framework that uses declarative YAML to validate Kubernetes deployments.
    - This tool is mainly used to test against Kubernetes operators but can also be used to do e2e cluster checks.
    - It requires an entirely separate tool just to test Kube API calls to check cluster state
- [kubepug](https://github.com/rikatz/kubepug)
    - A tool used to check for Kubernetes version API deprecations. This tool provides observations on new API changes to Kubernetes against our current cluster environment.
- [Sonobuoy](https://sonobuoy.io/docs/v0.56.2/)
    - A Kubernetes conformance testing tool to ensure the Kubernetes cluster meets the minimum set of features. This is a subset of e2e tests.
- [bats-detik](https://github.com/bats-core/bats-detik)
    - Kubernetes e2e testing on a well-known Bash test framework.
- [KubeLibrary](https://github.com/devopsspiral/KubeLibrary)
    - RobotFramework library to test Kubernetes clusters.

---
## MLA and Dashboards

- AWS EKS logging and monitoring -> [kyhau/aws-tools/EKS](https://github.com/kyhau/aws-tools/tree/master/EKS)
- [Kubernetes Dashboard](https://github.com/kubernetes/dashboard)
- [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics) (KSM)
    - kube-state-metrics vs. metrics-server (see [source](https://github.com/kubernetes/kube-state-metrics))
- Kubernetes Metrics Server
    - [deploy-metrics-server.sh](./deploy-metrics-server.sh)
    - https://docs.aws.amazon.com/eks/latest/userguide/metrics-server.html
    - https://github.com/kubernetes/dashboard/blob/master/docs/user/integrations.md
    - https://www.replex.io/blog/the-ultimate-guide-to-the-kubernetes-dashboard-how-to-install-and-integrate-metrics-server
- Collecting metrics with built-in Kubernetes monitoring tools
    - How to collect and graph kubernetes metrics? ([Source](https://www.datadoghq.com/blog/how-to-collect-and-graph-kubernetes-metrics/))
        - Querying and visualizing resource metrics from Kubernetes
        - Gathering cluster-level status information
        - Viewing logs from Kubernetes pods
- Netdata
    - https://github.com/netdata/helmchart


---
## Networking

- [Multus-CNI](https://github.com/k8snetworkplumbingwg/multus-cni) - Multus CNI enables attaching multiple network interfaces to pods in Kubernetes.


---
## Useful diagrams

### Overview of Kubernetes Architecture
![Overview of Kubernetes Architecture](https://i.redd.it/cqud3rjkss361.png)
