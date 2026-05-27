terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "web" {
  name  = "nginx-server"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }
}

resource "local_file" "ci_output" {
  filename = "${path.module}/ci-output.txt"
  content  = "Terraform + CI/CD ejecutado correctamente"
}
