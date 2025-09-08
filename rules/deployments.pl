get_deployments(Deployments, Namespace) :-
    findall(Deployment, (in_namespace(Deployment, Namespace), deployment(Deployment, _, _)), Deployments).

get_deployments(Deployments) :-
    get_deployments(Deployments, _).


get_pod_containers(Deployment, PodContainers) :-
    findall(PodContainer, pod_container(PodContainer, Deployment, _), PodContainers).


match_deployment_by_labels(ExpectedDeploymentLabels, Deployment) :-
    is_list(ExpectedDeploymentLabels),
    deployment(Deployment, _, DeploymentLabels),
    subset(ExpectedDeploymentLabels, DeploymentLabels).

match_deployment_by_labels(podSelectorWithLabels(PolicySelectorLabels), Deployment) :-
    match_deployment_by_labels(PolicySelectorLabels, Deployment).


deployment_has_no_pod_containers(Deployment) :-
    deployment(Deployment),
    \+ pod_container(_, Deployment, _).


is_deployment_ha(Deployment) :-
    deployment(Deployment, Replicas, _),
    Replicas > 1.


runs_as_root(Deployment) :-
    deployment(Deployment, _, _),
    security_context(Deployment, user(User)),
    User = 'root'.

