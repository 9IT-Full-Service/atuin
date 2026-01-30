# atuin

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 18.0.0](https://img.shields.io/badge/AppVersion-18.0.0-informational?style=flat-square)

A Helm chart for Atuin - magical shell history sync

**Homepage:** <https://blog.kuepper.nrw>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Rüdiger Küpper |  | <https://github.com/ruedigerp> |

## Source Code

* <https://github.com/9it-full-service/atuin>

## Installation

### OCI Registry (recommended)

```bash
helm install atuin oci://ghcr.io/9it-full-service/charts/atuin --version 0.1.3
```

### With custom values

```bash
helm install atuin oci://ghcr.io/9it-full-service/charts/atuin \
  --version 0.1.3 \
  --set postgresql.auth.password=mysecretpassword \
  --set ingress.hosts[0].host=atuin.example.com
```

## Prerequisites

- Kubernetes 1.19+
- Helm 3.8+
- PV provisioner support in the underlying infrastructure (for PostgreSQL persistence)

## Configuration

See [values.yaml](./values.yaml) for the full list of configurable parameters.

### Using an existing PostgreSQL secret

For production deployments, it's recommended to use an existing Kubernetes secret:

```bash
kubectl create secret generic atuin-postgresql \
  --from-literal=postgresql-password=mysupersecretpassword

helm install atuin oci://ghcr.io/9it-full-service/charts/atuin \
  --set postgresql.auth.existingSecret=atuin-postgresql
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity rules for pod scheduling |
| atuin.host | string | `"0.0.0.0"` | Host address to bind the server to |
| atuin.logLevel | string | `"info,atuin_server=debug"` | Log level configuration |
| atuin.openRegistration | bool | `true` | Allow new user registrations |
| atuin.port | int | `8888` | Port for the Atuin server |
| fullnameOverride | string | `""` | Override the full name of the chart |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"ghcr.io/atuinsh/atuin"` | Atuin server image repository |
| image.tag | string | `""` | Overrides the image tag (default is the chart appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| ingress.annotations | object | `{"cert-manager.io/cluster-issuer":"letsencrypt-prod"}` | Ingress annotations |
| ingress.className | string | `"traefik"` | Ingress class name |
| ingress.enabled | bool | `true` | Enable ingress |
| ingress.hosts | list | `[{"host":"atuin.yourserver.de","paths":[{"path":"/","pathType":"Prefix"}]}]` | Ingress hosts configuration |
| ingress.tls | list | `[{"hosts":["atuin.yourserver.de"],"secretName":"atuin-tls"}]` | TLS configuration for ingress |
| nameOverride | string | `""` | Override the name of the chart |
| nodeSelector | object | `{}` | Node selector for pod scheduling |
| podAnnotations | object | `{}` | Annotations to add to the pod |
| podSecurityContext | object | `{}` | Security context for the pod |
| postgresql.auth.database | string | `"atuin"` | PostgreSQL database name |
| postgresql.auth.existingSecret | string | `""` | Use existing secret for password (key: postgresql-password) |
| postgresql.auth.password | string | `"yoursecret"` | PostgreSQL password (use existingSecret in production) |
| postgresql.auth.username | string | `"atuin"` | PostgreSQL username |
| postgresql.enabled | bool | `true` | Enable PostgreSQL deployment |
| postgresql.image.pullPolicy | string | `"IfNotPresent"` | PostgreSQL image pull policy |
| postgresql.image.repository | string | `"postgres"` | PostgreSQL image repository |
| postgresql.image.tag | string | `"14"` | PostgreSQL image tag |
| postgresql.persistence.accessModes | list | `["ReadWriteOnce"]` | Access modes for the PVC |
| postgresql.persistence.enabled | bool | `true` | Enable persistent storage for PostgreSQL |
| postgresql.persistence.size | string | `"10Gi"` | Size of the persistent volume |
| postgresql.persistence.storageClass | string | `""` | Storage class for the PVC (empty uses default) |
| postgresql.resources | object | `{}` | Resource requests and limits for PostgreSQL |
| replicaCount | int | `1` | Number of Atuin server replicas |
| resources | object | `{}` | Resource requests and limits for Atuin server |
| securityContext | object | `{}` | Security context for the container |
| service.port | int | `8888` | Service port |
| service.type | string | `"ClusterIP"` | Kubernetes service type |
| serviceAccount.annotations | object | `{}` | Annotations for the service account |
| serviceAccount.create | bool | `true` | Create a service account |
| serviceAccount.name | string | `""` | Name of the service account (auto-generated if empty) |
| tolerations | list | `[]` | Tolerations for pod scheduling |

## Upgrading

### From 0.x to 1.x

No breaking changes expected.

----------------------------------------------
Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)
