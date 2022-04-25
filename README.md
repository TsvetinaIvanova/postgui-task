# PostGUI in Kubernetes

## Structure of the solution

### Files and Directories
* **helm-chart** - a Helm chart deploying the full solution (PostgreSQL + PostgREST + PostGUI in a Kubernetes cluster)
* **health-check.sh** - small script implementing the health check task
* **k8s-manifests** - a short manifest creating a persistent volume in the k8s cluster, which will be subsequently used by PostgreSQL to store data
* **image** - contains Dockerfile for postgui image

## Suggested Pipeline for execution
### Step 1
In **image** directory:
* Clone https://github.com/priyank-purohit/PostGUI.git
* Run `docker build -t postgui .` and push image to docker repo

### Step 2
In **k8s-manifests**:
* Run `kubectl -n NAMESPACE apply -f volume-postgres-db.yaml`, NAMESPACE should be the deployment namespace, where the Helm chart will be run

### Step 3
In root directory of repo:
* Run `helm upgrade --install RELEASE_NAME -n NAMESPACE helm-chart/postgres-stack`. Default chart values are enough to produce a running solution, except for the host urls in the ingress controllers. In a local environment (minikube), it's possible to create a fake host by creating a `~/.minikube/files/etc/hosts` file like this (IP is the address of the local k8s node):

```                                               
192.168.49.2    postgui.info
192.168.49.2    api.postgui.info

```

### Step 4
* Execute health check
