output "environment" {
  description = "The deployed environment name"
  value       = var.environment
}

output "config_file" {
  description = "Path to the generated environment config"
  value       = local_file.app_config.filename
}

output "app_port" {
  description = "The port the app is exposed on"
  value       = var.app_port
}
