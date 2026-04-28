output "container_names" {
  description = "Names of deployed containers"
  value       = [for c in docker_container.api : c.name]
}

output "container_ports" {
  description = "External ports of containers"
  value       = [for c in docker_container.api : c.ports[0].external]
}

output "network_name" {
  description = "Docker network name"
  value       = docker_network.app_network.name
}
