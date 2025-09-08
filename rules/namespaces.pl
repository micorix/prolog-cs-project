get_namespaces(Namespaces) :-
    findall(Namespace, namespace(Namespace), Namespaces).

is_namespace_empty(Ns) :-
    \+ in_namespace(_, Ns).

get_namespace(deployment(Name), Namespace) :-
    in_namespace(Name, Namespace).

get_namespace(service(Name), Namespace) :-
    in_namespace(Name, Namespace).

get_namespace(network_policy(Name), Namespace) :-
    in_namespace(Name, Namespace).

are_in_same_namespace([_]).
are_in_same_namespace([]).

are_in_same_namespace([A, B|Rest]) :-
    get_namespace(A, Namespace),
    get_namespace(B, Namespace),
    are_in_same_namespace([B|Rest]).

namespace_of(Resource, Ns) :-
    Resource =.. [Type, Name],
    (Type = deployment ; Type = service ; Type = network_policy),
    in_namespace(Name, Ns).
