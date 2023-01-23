# Kubernetes Notes

Jump to
- [Development tools](#development-tools)
- [IaC and CICD](#iac-and-cicd)
- [Infrastructure testing](#infrastructure-testing)
- [MLA and Dashboards](#mla-and-dashboards)
- [Access Control and Security](#access-control-and-security)
- [Networking](#networking)
- [Backup](#backup)
- [Some good reads](#some-good-reads)
- [Kubernetes certifications](../../quick-notes/Certs-Kubernetes.md)


---
## Development tools

- AWS resources (e.g. EKS, CDK, CDK8s) -> [kyhau/aws-tools/EKS](https://github.com/kyhau/aws-tools/tree/master/EKS)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/)
    - A command line tool for communicating with a Kubernetes cluster's control plane, using the Kubernetes API.
    - kubectl [Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [minikube](https://github.com/kubernetes/minikube)
    - minikube implements a local Kubernetes cluster on macOS, Linux, and Windows.
- [k8slens.dev](https://k8slens.dev/)
    - Lens - The Kubernetes IDE, provides the full situational awareness for everything that runs in Kubernetes.
- [k9s](https://github.com/derailed/k9s)
    - K9s - K9s provides a terminal UI to interact with Kubernetes clusters.
- [pixie](https://github.com/pixie-io/pixie)
    - Pixie is an open-source observability tool for Kubernetes applications.


---
## IaC and CICD

- AWS resources (e.g. EKS, CDK, CDK8s) -> [kyhau/aws-tools/EKS](https://github.com/kyhau/aws-tools/tree/master/EKS)
- GitHub Actions
    - [actions-runner-controller](https://github.com/actions-runner-controller/actions-runner-controller) - This controller operates self-hosted runners for GitHub Actions on your Kubernetes cluster.
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
- Postman
    - [Making calls to the Kube API through Postman](https://swiber.dev/automating-kubernetes-deployments-with-postman#the-big-reveal)

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
## Access Control and Security

- [rbac-police](https://github.com/PaloAltoNetworks/rbac-police) - Retrieve the RBAC permissions of serviceAccounts, pods and nodes in a Kubernetes cluster, and evaluate them using policies written in Rego.
- [Kubernetes Privilege Escalation: Excessive Permissions in Popular Platforms](https://www.paloaltonetworks.com/apps/pan/public/downloadResource?pagePath=/content/pan/en_US/resources/whitepapers/kubernetes-privilege-escalation-excessive-permissions-in-popular-platforms) White Paper,  Palo Alto Network, 2022


---
## Networking

- [Multus-CNI](https://github.com/k8snetworkplumbingwg/multus-cni) - Multus CNI enables attaching multiple network interfaces to pods in Kubernetes.


---
## Backup
- [Velero](https://velero.io/) - Velero is an open source tool to safely backup and restore, perform disaster recovery, and migrate Kubernetes cluster resources and persistent volumes.
- [backube/snapscheduler](https://github.com/backube/snapscheduler) - SnapScheduler provides scheduled snapshots for Kubernetes CSI-based volumes.


---
## Some good reads
- [Server Side Apply Is Great And You Should Be Using It](https://kubernetes.io/blog/2022/10/20/advanced-server-side-apply/)
