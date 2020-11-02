resource "ibm_resource_instance" "cos_instance" {
  name     = "${var.project_name}-${var.environment}-ocp_cos_instance"
  service  = "cloud-object-storage"
  resource_group_id = data.ibm_resource_group.group.id
  plan     = "standard"
  location = "global"
}


resource "ibm_container_vpc_cluster" "vpc_cluster" {
  name              = "${var.project_name}-${var.environment}-ocp"
  vpc_id            = ibm_is_vpc.vpc_vpc.id
  flavor            = var.flavors[0]
  worker_count      = var.workers_count[0]
  kube_version      = var.k8s_version
  entitlement       = "cloud_pak"
  cos_instance_crn  = ibm_resource_instance.cos_instance.id
  resource_group_id = data.ibm_resource_group.group.id
  disable_public_service_endpoint = var.public_endpoint_disable
  wait_till         = "OneWorkerNodeReady"
  zones {
    name      = var.vpc_zone_names[0]
    subnet_id = ibm_is_subnet.vpc_subnet[0].id
  }
}

resource "ibm_container_vpc_worker_pool" "vpc_cluster_pool" {
  count             = local.max_size - 1
  cluster           = ibm_container_vpc_cluster.vpc_cluster.id
  worker_pool_name  = "${var.project_name}-${var.environment}-wp-${format("%02s", count.index + 1)}"
  flavor            = var.flavors[count.index + 1]
  vpc_id            = ibm_is_vpc.vpc_vpc.id
  worker_count      = var.workers_count[count.index + 1]
  resource_group_id = data.ibm_resource_group.group.id
  zones {
    name      = var.vpc_zone_names[count.index + 1]
    subnet_id = ibm_is_subnet.vpc_subnet[count.index + 1].id
  }
}
