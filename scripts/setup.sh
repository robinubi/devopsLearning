#!/bin/bash
# ============================================================
# DevOps Learning Lab — Local Setup Checker
# Run: bash scripts/setup.sh
# ============================================================
set -e

echo ""
echo "🔍 Checking required tools..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

MISSING=0

check_tool() {
  local name=$1
  local install_hint=$2
  if command -v "$name" &>/dev/null; then
    local ver
    ver=$("$name" --version 2>&1 | head -1)
    echo "  ✅ $name — $ver"
  else
    echo "  ❌ $name NOT found"
    echo "     Install: $install_hint"
    MISSING=$((MISSING + 1))
  fi
}

check_tool git          "brew install git"
check_tool docker       "brew install --cask docker"
check_tool kubectl      "brew install kubectl"
check_tool minikube     "brew install minikube"
check_tool terraform    "brew tap hashicorp/tap && brew install hashicorp/tap/terraform"
check_tool ansible      "brew install ansible"
check_tool dotnet       "https://dotnet.microsoft.com/download/dotnet/9.0"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ "$MISSING" -gt 0 ]; then
  echo "⚠️  $MISSING tool(s) missing. Install them and re-run."
  exit 1
fi

echo ""
echo "🐳 Starting full local stack..."
docker compose -f docker/docker-compose.yml up -d --build

echo ""
echo "✅ Done! Your stack is running:"
echo "   🌐 API        → http://localhost:8080/swagger"
echo "   📊 Metrics    → http://localhost:8080/metrics"
echo "   🔥 Prometheus → http://localhost:9090"
echo "   📈 Grafana    → http://localhost:3000  (admin / devopslab)"
echo ""
echo "👉 Start learning: cat docs/STAGE-1-GIT.md"
