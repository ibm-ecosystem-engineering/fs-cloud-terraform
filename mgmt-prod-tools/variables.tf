variable "project_name" {}
variable "environment" {}

variable "resource_group" {
  default = "mgmt-tools-prod"
}

variable "ssh_keyname" {
  default = "mgmt_ssh_key"
}

# default to using CentOS 8
variable "image_name" {
  default = "ibm-centos-7-0-minimal-amd64-1"
}

variable "profile" {
  default = "cx2-2x4"
}

variable "region" {
  default = "eu-de"
}

variable "zone" {
  default = "eu-de-1"
}

variable "vpc_zone_names" {
  type    = list
  default = ["eu-de-1"]
}

locals {
  max_size = length(var.vpc_zone_names)
}
