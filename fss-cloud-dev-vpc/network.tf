resource "ibm_is_vpc" "vpc_vpc" {
  name = "${var.project_name}-${var.environment}-vpc"
  resource_group = data.ibm_resource_group.group.id
  address_prefix_management = "manual"
}

resource "ibm_is_vpc_address_prefix" "vpc_address_prefix" {
  count                     = local.max_size
  name                      = "${var.project_name}-${var.environment}-range-${format("%02s", count.index)}"
  zone                      = var.vpc_zone_names[count.index]
  vpc                       = ibm_is_vpc.vpc_vpc.id
  cidr                      = "172.26.${format("%01s", count.index)}.0/24"
}

resource "ibm_is_subnet" "vpc_subnet" {
  count                    = local.max_size
  name                     = "${var.project_name}-${var.environment}-subnet-${format("%02s", count.index)}"
  zone                     = var.vpc_zone_names[count.index]
  vpc                      = ibm_is_vpc.vpc_vpc.id
  ipv4_cidr_block          = "172.26.${format("%01s", count.index)}.0/26"
  # total_ipv4_address_count = 64
  resource_group           = data.ibm_resource_group.group.id
  public_gateway           = ibm_is_public_gateway.vpc_gateway[count.index].id
  
  depends_on  = [ibm_is_vpc_address_prefix.vpc_address_prefix]
}

resource "ibm_is_security_group_rule" "vpc_security_group_rule_tcp_k8s" {
  count     = local.max_size
  group     = ibm_is_vpc.vpc_vpc.default_security_group
  direction = "inbound"
  remote    = ibm_is_subnet.vpc_subnet[count.index].ipv4_cidr_block

  tcp {
    port_min = 30000
    port_max = 32767
  }
}

resource "ibm_tg_gateway" "new_tg_gw"{
  name      = "ts-tg"
  location  = "eu-de"
  global    =  true
  resource_group="6664a071c0b546deb4703269b54a5d9a"
}

resource "ibm_is_public_gateway" "vpc_gateway" {
    name  = "${var.project_name}-${var.environment}-gateway-${format("%02s", count.index)}"
    vpc   = ibm_is_vpc.vpc_vpc.id
    zone  = var.vpc_zone_names[count.index]
    count = local.max_size

    //User can configure timeouts
    timeouts {
        create = "90m"
    }
}
