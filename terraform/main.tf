resource "random_id" "this" {
  byte_length = 5
}

locals {
  cluster_name = "${var.cluster_name}-${random_id.this.hex}"
}

module "doks-cluster" {
  source = "./modules/doks-cluster"
  cluster = {
    name      = local.cluster_name
    region    = var.cluster_region
    version   = var.cluster_version
    tags      = var.cluster_tags
    node_pool = var.cluster_node_pool
  }
  # Cria um 'node_pool' adicional para cada item da lista 'cluster_node_pools'
  cluster_node_pools = var.cluster_node_pools
}

module "doks-kubeconfig" {
  source = "./modules/doks-kubeconfig"
  cluster = {
    id   = module.doks-cluster.cluster_id
    name = module.doks-cluster.cluster_name
  }
}