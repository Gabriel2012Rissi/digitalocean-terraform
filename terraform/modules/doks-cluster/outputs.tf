output "cluster_id" {
  description = "ID do cluster na DigitalOcean"
  value       = digitalocean_kubernetes_cluster.this.id
}

output "cluster_name" {
  description = "Nome do cluster na DigitalOcean"
  value       = digitalocean_kubernetes_cluster.this.name
}