% https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

deployment(frontend_web, 1, ['app:frontend-web']).
deployment(backend, 3, ['app:backend', 'db-access']).
deployment(inference_api, 3, ['app:inference-api']).
deployment(database, 2, ['app:db']).
deployment(staging_frontend, 2, ['app:staging-frontend']).

pod_container(frontend_web_c, frontend_web, 3000).
pod_container(backend_c, backend, 80).
pod_container(inference_api_c, inference_api, 8080).
pod_container(db_c, database, 5432).
pod_container(staging_frontend_c, staging_frontend, 80).

% https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/
node_selector(inference_api, ['gpu']).
node_selector(backend, ['high-ram']).

% https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
security_context(backend, user('root')).

% https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
deployment_resource_limits(frontend_web, 0.5, 128).
deployment_resource_limits(backend, 2, 512).
deployment_resource_limits(inference_api, 5, 512).
deployment_resource_limits(database, 5, 1024).