## prolog-cs-project

This project was created as part of a computer science class assignment. 
The task was to demonstrate the use of Prolog for logical inference.
While the domain was open-ended, I chose to (partially) model a subset of Kubernetes concepts:

* Deployments – containers, replicas, resource limits, and security contexts
* Services – whether they allow traffic between deployments
* Network Policies – label-based ingress rules controlling connectivity
* Namespaces – grouping resources, checking whether namespace is empty
* Nodes – scheduling constraints and resource usage


| Feature                            | Used               | File                                                   |
|------------------------------------|--------------------|--------------------------------------------------------|
| logical and mathematical operators | :white_check_mark: | [rules/deployments.pl](rules/deployments.pl)           |
| library predicates                 | :white_check_mark: | [rules/network-policies.pl](rules/network-policies.pl) |
| lists                              | :white_check_mark: | [rules/network-policies.pl](rules/network-policies.pl) |
| recursion                          | :white_check_mark: | [rules/namespaces.pl](rules/namespaces.pl)             |
| cut operator                       | :white_check_mark: | [rules/nodes.pl](rules/nodes.pl)                       |
| special operators                  | :white_check_mark: | [rules/namespaces.pl](rules/namespaces.pl)             |
| loading facts from file            | :white_check_mark: | [run.pl](run.pl)                                       |


## Prerequisites

* [SWI-Prolog](https://www.swi-prolog.org)
* or [nix](https://nixos.org) with flakes (`nix develop`)

Run `swipl` and then `[run].`

## Sample queries

## Namespaces

[Namespaces k8s docs](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)

## Get namespaces

```prolog
get_namespaces(X).
```

### Check whether namespace is empty

```prolog
is_namespace_empty(prod). % false
is_namespace_empty(dev). % true
```


### Check whether resources are in the same namespace

```prolog
are_in_same_namespace([network_policy(backend_access), deployment(backend), deployment(inference_api)]). % true
```

### Check namespace of a resource (deployment, service, network policy)

```prolog
namespace_of(deployment(staging_frontend), X).
```

## Deployments

[Deployment k8s docs](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)

### Get deployments

```prolog
get_deployments(X, prod).
get_deployments(X).
```

### Get deployment containers

```prolog
get_pod_containers(frontend_web, X).
```

### Match deployment by labels

```prolog
match_deployment_by_labels(['db-access'], X). % backend
match_deployment_by_labels(podSelectorWithLabels(['db-access']), X). % backend
```

### Find deployments with no associated pods

```prolog
deployment_has_no_pod_containers(X).
```

### Check whether deployment is highly available / find those deployments

```prolog
is_deployment_ha(frontend_web). % false
is_deployment_ha(backend). % true
is_deployment_ha(X).
```

### Check whether deployment runs as a root user / find those deployments

```prolog
runs_as_root(inference_api). % false
runs_as_root(backend). % true
runs_as_root(X).
```

## Resource limits

[Resource limits k8s docs](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)

### Sum resource limits

```prolog
sum_resource_limits(CPU, Mem).
sum_resource_limits(CPU, Mem, srv_gpu1). % works only if deployments are explicitly assigned to nodes
```

## Network policies

[Network policies k8s docs](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

### Get network policies

```prolog
get_network_policies(X, prod).
get_network_policies(X).
```

### Find namespaces without network policies

```prolog
namespace_has_no_network_policy(X).
```

### Check whether ingress from one deployment to another is permitted

```prolog
is_ingress_allowed(frontend_web, backend, 80). % true
is_ingress_allowed(frontend_web, backend, 8080). % false
```

## Services

[Service k8s docs](https://kubernetes.io/docs/concepts/services-networking/service/)

### Get services

```prolog
get_services(X, prod).
get_serivces(X).
```

### Whether ingress is possible from one deployment to another

```prolog
is_ingress_possible(backend, database, 5432). % true
is_ingress_possible(backend, database, 3000). % false
```


## Nodes

[Assigning Pods to Nodes k8s docs](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/)


### Check whether deployment can be scheduled on certain node

```prolog
can_schedule_on_node(inference_api, srv1). % false
can_schedule_on_node(inference_api, srv_gpu1). % true
```

### Find nodes suitable for given deployment

```prolog
find_node_for_deployment(backend, X). % srv2
```


## Assumptions

* ingress allowed `==` there exist a network policy allowing for traffic (no same ns check, ingress disabled by default)
* ingress possible `==` there exist a service that forwards traffic between deployments (no same ns check)
* deployment with 2 or more pod replicas is highly available