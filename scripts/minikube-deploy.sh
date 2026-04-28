#!/bin/bash
# Stage 4: Deploy to local minikube cluster
# Run: bash scripts/minikube-deploy.sh
set -e

echo "🚀 Starting minikube (docker driver)..."
minikube start --driver=docker

echo ""
echo "🐳 Switching to minikube Docker context (so K8s can see the image)..."
eval $(minikube docker-env)

echo ""
echo "🔨 Building image inside minikube..."
docker build -t devopslab-api:latest -f docker/Dockerfile .

echo ""
echo "📦 Applying Kubernetes manifests..."
kubectl apply -f kubernetes/namespace.yml
kubectl apply -f kubernetes/configmap.yml
kubectl apply -f kubernetes/deployment.yml
kubectl apply -f kubernetes/service.yml

echo ""
echo "⏳ Waiting for rollout..."
kubectl rollout status deployment/devopslab-api -n devopslab --timeout=90s

echo ""
echo "🔍 Pod status:"
kubectl get pods -n devopslab

echo ""
echo "🌐 Getting service URL..."
minikube service devopslab-api -n devopslab --url
