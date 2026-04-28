# Stage 5: Terraform — Local provider (no cloud account needed to start)
# Simulates infrastructure provisioning by writing local config files
# Run: cd terraform && terraform init && terraform plan && terraform apply

terraform {
  required_version = ">= 1.6.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

# Simulate writing an environment config
resource "local_file" "app_config" {
  filename = "${path.module}/outputs/app.env"
  content  = <<-EOT
    APP_ENV=${var.environment}
    APP_VERSION=${var.app_version}
    APP_PORT=${var.app_port}
    MANAGED_BY=terraform
  EOT
}

# Simulate writing a Docker Compose override
resource "local_file" "compose_override" {
  filename = "${path.module}/outputs/docker-compose.override.yml"
  content  = <<-EOT
    version: "3.9"
    services:
      api:
        environment:
          - APP_ENV=${var.environment}
          - APP_VERSION=${var.app_version}
        ports:
          - "${var.app_port}:8080"
  EOT
}

resource "null_resource" "print_summary" {
  triggers = {
    env     = var.environment
    version = var.app_version
  }
  provisioner "local-exec" {
    command = "echo '✅ Terraform applied: ${var.environment} environment, port ${var.app_port}'"
  }
  depends_on = [local_file.app_config]
}
