terraform {
  required_version = ">= 1.3.2"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.23.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.2.3"
    }
  }
}

data "digitalocean_kubernetes_cluster" "this" {
  name = var.cluster.name
}

resource "local_sensitive_file" "kube_config" {
  content              = data.digitalocean_kubernetes_cluster.this.kube_config.0.raw_config
  filename             = "${path.root}/files/kube_config-${terraform.workspace}.yaml"
  file_permission      = "0700"
  directory_permission = "0655"

  depends_on = [
    var.cluster
  ]
}