output "cluster_id" {
  value = ibm_container_vpc_cluster.vpc_cluster.id
}

output "cluster_name" {
  value = ibm_container_vpc_cluster.vpc_cluster.name
}

output "entrypoint" {
  value = ibm_container_vpc_cluster.vpc_cluster.public_service_endpoint_url
}
