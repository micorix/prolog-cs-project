% https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/

% namespace(name)
namespace(prod).
namespace(staging).
namespace(dev).

in_namespace(frontend_web, prod).
in_namespace(backend, prod).
in_namespace(inference_api, prod).
in_namespace(database, prod).
in_namespace(staging_frontend, staging).

in_namespace(frontend_web_svc, prod).
in_namespace(backend_svc, prod).
in_namespace(inference_api_svc, prod).
in_namespace(database_svc, prod).

in_namespace(db_access, prod).
in_namespace(inference_api_access, prod).
in_namespace(backend_access, prod).