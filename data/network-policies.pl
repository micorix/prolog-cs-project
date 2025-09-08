% https://kubernetes.io/docs/concepts/services-networking/network-policies/

% network_policy(name, pod_selector, ingress_rules, egress_rules)
network_policy(db_access, podSelectorWithLabels(['app:db']), [
    allow(podSelectorWithLabels(['db-access']), port(5432))
], [
    allow_all
]).

network_policy(inference_api_access, podSelectorWithLabels(['app:inference-api']), [
    allow(podSelectorWithLabels(['inference-api-access']), port(8080))
], [
    allow_all
]).

network_policy(backend_access, podSelectorWithLabels(['app:backend']), [
    allow(podSelectorWithLabels(['app:frontend-web']), port(80))
], [
    allow_all
]).



