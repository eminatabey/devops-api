terraform {
  required_version = ">= 1.7.0"

  required_providers {
    # these providers can be used with any cloud (Cloud agnostic)
    # or locally for demonstration
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}
