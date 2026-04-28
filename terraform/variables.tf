variable "app_name" {
  description = "Application name"
  type        = string
  default     = "devops-api"
}

variable "app_port" {
  description = "Port exposed by the application"
  type        = number
  default     = 8000
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be development, staging, or production."
  }
}

variable "replicas" {
  description = "Number of container replicas"
  type        = number
  default     = 1

  validation {
    condition     = var.replicas >= 1 && var.replicas <= 5
    error_message = "Number of replicas must be between 1 and 5."
  }
}

variable "cpu_limit" {
  description = "Container CPU limit (in shares)"
  type        = number
  default     = 512
}

variable "memory_limit" {
  description = "Container memory limit (in MB)"
  type        = number
  default     = 256
}
