terraform {
  required_version = ">= 1.3.2"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.23.0"
    }
  }
}

resource "digitalocean_kubernetes_cluster" "this" {
  name = var.cluster.name
  # Para obter a listagem de regiões disponíveis na DigitalOcean,
  # use o comando do CLI `doctl kubernetes options regions`
  region = var.cluster.region
  # Para obter a listagem das versões do kubernetes disponíveis na DigitalOcean, 
  # use o comando do CLI `doctl kubernetes options versions`
  version = var.cluster.version

  tags = var.cluster.tags

  node_pool {
    name = var.cluster.node_pool.name
    # Para obter as opções de instâncias disponíveis na DigitalOcean,
    # use o comando do CLI `doctl kubernetes options sizes`
    size       = var.cluster.node_pool.size
    node_count = var.cluster.node_pool.count
    labels     = var.cluster.node_pool.labels

    tags = var.cluster.node_pool.tags

    dynamic "taint" {
      for_each = var.cluster.node_pool.taints
      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect
      }
    }
  }
}

resource "digitalocean_kubernetes_node_pool" "this" {
  cluster_id = digitalocean_kubernetes_cluster.this.id

  for_each = { for node_pool in var.cluster_node_pools : node_pool.name => node_pool }

  name = each.value.name
  # Para obter as opções de instâncias disponíveis na DigitalOcean,
  # use o comando do CLI `doctl kubernetes options sizes`
  size       = each.value.size
  node_count = each.value.count
  labels     = each.value.labels

  tags = each.value.tags

  dynamic "taint" {
    for_each = each.value.taints
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }
}