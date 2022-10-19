variable "cluster" {
  type = object({
    name    = string
    region  = string
    version = string
    tags    = list(string)
    node_pool = object({
      name   = string
      size   = string
      count  = number
      labels = map(string)
      tags   = list(string)
      taints = list(map(string))
    })
  })
  description = "Configuração do cluster"
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
  description = "Lista de 'node_pools' adicionais para o cluster"
  default     = []
}