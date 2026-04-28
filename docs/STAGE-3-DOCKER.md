# Stage 3: Docker

## Goal
Containerize the .NET API and run the full monitoring stack locally.

## Quick Start
```bash
# Full stack (API + Prometheus + Grafana)
docker compose -f docker/docker-compose.yml up -d

# Just the API
docker build -t devopslab-api:latest -f docker/Dockerfile .
docker run -p 8080:8080 devopslab-api:latest
```

## Exercises
1. `docker ps` — see running containers
2. `docker logs devopslab-api -f` — follow live logs
3. `docker exec -it devopslab-api /bin/sh` — shell inside the container
4. Look at the Dockerfile — understand why there are two `FROM` statements
5. Add a `redis` service to `docker-compose.yml`

## URLs Once Running
| Service    | URL                               |
|------------|-----------------------------------|
| API        | http://localhost:8080             |
| Swagger    | http://localhost:8080/swagger     |
| Metrics    | http://localhost:8080/metrics     |
| Prometheus | http://localhost:9090             |
| Grafana    | http://localhost:3000             |
