variable "cluster" {
  type = object({
    id   = string
    name = string
  })
  description = "Configuração do cluster para criação do arquivo 'kubeconfig'"
}