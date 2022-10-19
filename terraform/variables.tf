variable "cluster_name" {
  type        = string
  description = "Nome do cluster"
  default     = "do-cluster-k8s"
}

variable "cluster_region" {
  type        = string
  description = "Região do cluster"
  default     = "nyc1"
}

variable "cluster_version" {
  type        = string
  description = "Versão do cluster"
  default     = "1.23.9-do.0"
}

variable "cluster_tags" {
  type        = list(string)
  description = "Tags para identificar o cluster"
  default     = ["k8s", "do-cluster-k8s"]
}

variable "cluster_node_pool" {
  type = object({
    name   = string
    size   = string
    count  = number
    labels = map(string)
    tags   = list(string)
    taints = list(map(string))
  })
  description = "Configuração do 'node_pool' padrão do cluster kubernetes"
  default = {
    name  = "default-node-pool"
    size  = "s-1vcpu-4gb"
    count = 2
    labels = {
      role = "default-node-pool"
    }
    tags = ["default-node-pool"]
    # Formato é list(taint): [{key:XXX, value: XXX, effect:XXX},...]
    taints = [
      {
        key    = "dedicated"
        value  = "default-node-pool"
        effect = "NoSchedule"
      }
    ]
  }
}

variable "cluster_node_pools" {
  type = list(object({
    name   = string
    size   = string
    count  = number
    labels = map(string)
    tags   = list(string)
    taints = list(map(string))
  }))
  description = "Lista de 'node_pools' adicionais para o cluster kubernetes"
  # Formato é list(node_pool): [{name:XXX, size:XXX, auto_scale:XXX, node_count:XXX, min_nodes:XXX, max_nodes:XXX, labels:XXX, tags:XXX, taints:XXX},...]
  default = []
}