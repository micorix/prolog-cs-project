get_nodes(Nodes) :-
    findall(Node, node(Node, _), Nodes).

get_nodes(NetworkPolicies) :-
    get_network_policies(NetworkPolicies, _).


can_schedule_on_node(Deployment, Node) :-
    deployment(Deployment, _, _),
    node(Node, _),
    (
    node_selector(Deployment, RequiredNodeLabels),
         node(Node, NodeLabels),
         subset(RequiredNodeLabels, NodeLabels)
    ) ; (
        \+ node_selector(Deployment, _)
    ).

find_node_for_deployment(Deployment, Node) :-
    node(Node, _),
    deployment(Deployment, _, _),
    can_schedule_on_node(Deployment, Node),
    !.