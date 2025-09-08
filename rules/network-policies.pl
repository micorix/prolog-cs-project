:- use_module(library(lists)).

get_network_policies(NetworkPolicies, Namespace) :-
    findall(NetworkPolicy, (in_namespace(NetworkPolicy, Namespace), network_policy(NetworkPolicy, _, _, _)), NetworkPolicies).

get_network_policies(NetworkPolicies) :-
    get_network_policies(NetworkPolicies, _).

has_network_policy_in_namespace(Namespace) :-
    in_namespace(Deployment, Namespace),
    deployment(Deployment, _, DeploymentLabels),
    network_policy(_, podSelectorWithLabels(PolicySelectorLabels), _, _),
    subset(PolicySelectorLabels, DeploymentLabels).

namespace_has_no_network_policy(Namespace) :-
    namespace(Namespace),
    \+ has_network_policy_in_namespace(Namespace).


is_ingress_allowed(SourceDeployment, DestDeployment, DestPort) :-
    deployment(DestDeployment, _, DestLabels),
    network_policy(_, podSelectorWithLabels(PolicySelectorLabels), IngressRules, _),
    subset(PolicySelectorLabels, DestLabels),
    member(allow(podSelectorWithLabels(RuleSourceSelector), port(RulePort)), IngressRules),
    deployment(SourceDeployment, _, SourceLabels),
    subset(RuleSourceSelector, SourceLabels),
    RulePort = DestPort.

