% https://kubernetes.io/docs/concepts/services-networking/service/

% service(name, selector, port, target_port)
service(frontend_web_svc, podSelectorWithLabels(['app:frontend-web']), port(8080), port(8070)).
service(backend_svc, podSelectorWithLabels(['app:backend']), port(8080), port(8070)).
service(inference_api_svc, podSelectorWithLabels(['app:inference-api']), port(5432), port(5432)).
service(database_svc, podSelectorWithLabels(['app:db']), port(5432), port(5432)).
