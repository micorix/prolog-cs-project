:- consult('./nodes.pl').

sum_resource_limits(TotalCPU, TotalMem) :-
    findall(CPU, (deployment_resource_limits(_, CPU, _)), CPUs),
    findall(Mem, (deployment_resource_limits(_, _, Mem)), Mems),
    sum_list(CPUs, TotalCPU),
    sum_list(Mems, TotalMem).

sum_resource_limits(TotalCPU, TotalMem, Node) :-
    findall(CPU,
        (can_schedule_on_node(Deployment, Node),
         deployment_resource_limits(Deployment, CPU, _)),
        CPUs),
    findall(Mem,
        (can_schedule_on_node(Deployment, Node),
         deployment_resource_limits(Deployment, _, Mem)),
        Mems),
    sum_list(CPUs, TotalCPU),
    sum_list(Mems, TotalMem).