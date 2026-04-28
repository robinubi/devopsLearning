#!/bin/bash
# Stage 5: Terraform workflow
# Run: bash scripts/terraform-apply.sh [dev|staging|prod]
set -e

ENV=${1:-dev}

echo "📋 Running Terraform for environment: $ENV"
cd terraform

echo ""
echo "⬇️  Initializing..."
terraform init

echo ""
echo "🔍 Planning..."
terraform plan -var="environment=$ENV"

echo ""
echo "✅ Applying..."
terraform apply -auto-approve -var="environment=$ENV"

echo ""
echo "📤 Outputs:"
terraform output
