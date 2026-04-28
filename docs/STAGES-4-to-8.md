# Stage 4: Kubernetes

## Goal
Deploy the containerized API to a local Kubernetes cluster using minikube.

## Prerequisites
```bash
brew install minikube kubectl
```

## Quick Start
```bash
bash scripts/minikube-deploy.sh
```

## Manual Commands
```bash
minikube start --driver=docker
eval $(minikube docker-env)
docker build -t devopslab-api:latest -f docker/Dockerfile .
kubectl apply -f kubernetes/
kubectl get pods -n devopslab
minikube service devopslab-api -n devopslab --url
```

## Exercises
1. Scale up: `kubectl scale deployment devopslab-api --replicas=4 -n devopslab`
2. Watch pods: `kubectl get pods -n devopslab -w`
3. Kill a pod — watch it self-heal automatically
4. View logs: `kubectl logs -l app=devopslab-api -n devopslab`
5. Edit `deployment.yml` resource limits and re-apply

---

# Stage 5: Terraform

## Goal
Define infrastructure as code — locally first, cloud later.

## Prerequisites
```bash
brew tap hashicorp/tap && brew install hashicorp/tap/terraform
```

## Quick Start
```bash
bash scripts/terraform-apply.sh dev
cat terraform/outputs/app.env
```

## Exercises
1. Change `app_port` to `9090` and re-apply — see output file update
2. Run `terraform plan -var="environment=prod"` — see the diff
3. Run `terraform destroy` — see everything removed
4. Add a new `local_file` resource that writes an `nginx.conf`

---

# Stage 6: Ansible

## Goal
Automate configuration management — run against localhost first.

## Prerequisites
```bash
brew install ansible   # or: pip3 install ansible
```

## Quick Start
```bash
ansible-playbook -i ansible/inventory/localhost.ini ansible/playbook.yml
cat /tmp/devopslab/.env
cat /tmp/devopslab/logs/deploy.log
```

## Exercises
1. Run with `-v` for verbose output — understand each task
2. Run twice — observe **idempotency** (no changes on second run)
3. Add a task that writes a `version.txt` file
4. Add a `when: ansible_system == 'Darwin'` condition to a task

---

# Stage 7 & 8: Prometheus + Grafana

## Goal
Observe the running API with real metrics and dashboards.

## Quick Start
```bash
docker compose -f docker/docker-compose.yml up -d
```

## Access
| Service    | URL                   | Login             |
|------------|-----------------------|-------------------|
| Prometheus | http://localhost:9090 | none              |
| Grafana    | http://localhost:3000 | admin / devopslab |

## Exercises
1. Prometheus → Status → Targets — confirm API is being scraped
2. Run a PromQL query: `rate(http_requests_received_total[1m])`
3. Grafana → Add data source → Prometheus → URL: `http://prometheus:9090`
4. Import dashboard from `grafana/dashboards/devopslab.json`
5. Generate traffic: `for i in {1..50}; do curl http://localhost:8080/hello/robin; done`
6. Stop the API container — watch the `ApiDown` alert fire in Prometheus

## Essential PromQL
```promql
# Request rate
rate(http_requests_received_total[1m])

# P90 latency
histogram_quantile(0.9, rate(http_request_duration_seconds_bucket[5m]))

# API up/down
up{job="devopslab-api"}

# Error rate
rate(http_requests_received_total{code=~"5.."}[5m])
```
