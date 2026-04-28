# 🛠️ DevOps Learning Lab

A hands-on repository to learn all 8 core DevOps tools — sequentially, locally, **for free**.

> Built for .NET developers. Each folder is a self-contained learning stage with working code and exercises.

## 🗺️ Learning Path

| Stage | Tool | Folder | Free? |
|-------|------|--------|-------|
| 1 | Git | *(this repo itself)* | ✅ 100% Free |
| 2 | GitHub Actions | `.github/workflows/` | ✅ Free (2000 min/month on private repos) |
| 3 | Docker | `docker/` | ✅ Free (Docker Desktop personal) |
| 4 | Kubernetes | `kubernetes/` | ✅ Free (minikube locally) |
| 5 | Terraform | `terraform/` | ✅ Free OSS CLI |
| 6 | Ansible | `ansible/` | ✅ Free OSS |
| 7 | Prometheus | `prometheus/` | ✅ Free OSS |
| 8 | Grafana | `grafana/` | ✅ Free OSS (Cloud free tier too) |

## 🚀 Getting Started

```bash
# 1. Clone
git clone https://github.com/YOUR_USERNAME/devops-learning-lab.git
cd devops-learning-lab

# 2. Check your tools are installed
bash scripts/setup.sh

# 3. Start the full local stack
docker compose -f docker/docker-compose.yml up -d
```

Then open:
- API → http://localhost:8080/swagger
- Metrics → http://localhost:8080/metrics
- Prometheus → http://localhost:9090
- Grafana → http://localhost:3000 (admin / devopslab)

## 📁 Structure

```
devops-learning-lab/
├── .github/workflows/     # Stage 2: CI + CD pipelines
├── src/DevOpsLab.Api/     # .NET 10 Web API (the app used throughout)
├── docker/                # Stage 3: Dockerfile + docker-compose
├── kubernetes/            # Stage 4: K8s manifests for minikube
├── terraform/             # Stage 5: Infrastructure as Code
├── ansible/               # Stage 6: Configuration management
├── prometheus/            # Stage 7: Scrape config + alert rules
├── grafana/               # Stage 8: Dashboard JSON
├── scripts/               # Helper scripts (setup, deploy, etc.)
└── docs/                  # Step-by-step guide per stage
```

## 📚 Docs

Follow these in order:

1. [Stage 1 — Git](docs/STAGE-1-GIT.md)
2. [Stage 2 — GitHub Actions](docs/STAGE-2-GITHUB-ACTIONS.md)
3. [Stage 3 — Docker](docs/STAGE-3-DOCKER.md)
4. [Stage 4 — Kubernetes](docs/STAGE-4-KUBERNETES.md)
5. [Stage 5 — Terraform](docs/STAGE-5-TERRAFORM.md)
6. [Stage 6 — Ansible](docs/STAGE-6-ANSIBLE.md)
7. [Stage 7 & 8 — Prometheus + Grafana](docs/STAGE-7-8-MONITORING.md)

## 🛠️ Prerequisites (macOS M1)

```bash
brew install git
brew install --cask docker        # Docker Desktop
brew install minikube kubectl
brew tap hashicorp/tap && brew install hashicorp/tap/terraform
brew install ansible
# .NET 10 SDK: https://dotnet.microsoft.com/download
```
