output "ip_address" {
  value = ibm_is_floating_ip.mgmt_instance_floating_ip.address
}

output "ssh_private_key" {
  value = tls_private_key.ssh_key_keypair.private_key_pem
}
