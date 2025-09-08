get_services(Services, Namespace) :-
    findall(Service, (in_namespace(Service, Namespace), service(Service, _, _, _)), Services).

get_services(Services) :-
    get_services(Services, _).


is_ingress_possible(SourceDeployment, DestDeployment, DestPort) :-
    deployment(SourceDeployment, _, _),
    deployment(DestDeployment, _, DestDeploymentLabels),
    service(_, podSelectorWithLabels(DestDeploymentRequiredLabels), port(DestPort), port(DestDeploymentInternalPort)),
    subset(DestDeploymentRequiredLabels, DestDeploymentLabels),
    pod_container(_, DestDeployment, DestDeploymentInternalPort).
