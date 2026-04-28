variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Must be dev, staging, or prod."
  }
}

variable "app_version" {
  description = "Application version tag"
  type        = string
  default     = "1.0.0"
}

variable "app_port" {
  description = "Host port to expose the API on"
  type        = number
  default     = 8080
}
