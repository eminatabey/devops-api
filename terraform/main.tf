resource "docker_image" "api" {
  name = "${var.app_name}:latest"

  build {
    context    = "${path.module}/.."
    dockerfile = "Dockerfile"
    tag        = ["${var.app_name}:latest"]
  }
}

resource "docker_network" "app_network" {
  name   = "${var.app_name}-network"
  driver = "bridge"

  ipam_config {
    subnet = "172.28.0.0/16"
  }
}

resource "docker_container" "api" {
  count = var.replicas
  name  = "${var.app_name}-${count.index}"
  image = docker_image.api.image_id

  ports {
    internal = var.app_port
    external = var.app_port + count.index
  }

  env = [
    "APP_ENVIRONMENT=${var.environment}",
    "APP_DEBUG=false",
  ]

  networks_advanced {
    name = docker_network.app_network.name
  }

  # Security: read-only filesystem
  read_only = true

  # Security: no privilege escalation
  capabilities {
    drop = ["ALL"]
  }

  # Resource limits
  cpu_shares = var.cpu_limit
  memory     = var.memory_limit

  healthcheck {
    test         = ["CMD", "python", "-c", "import urllib.request; urllib.request.urlopen('http://localhost:${var.app_port}/api/v1/health')"]
    interval     = "30s"
    timeout      = "5s"
    retries      = 3
    start_period = "10s"
  }

  restart = "unless-stopped"
}
