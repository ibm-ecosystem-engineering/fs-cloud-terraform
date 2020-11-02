data "ibm_is_image" "mgmt_image" {
  name = var.image_name
}

resource "ibm_is_instance" "mgmt_instance" {
  name    = "${var.project_name}-${var.environment}-instance"
  resource_group  = data.ibm_resource_group.group.id
  image   = data.ibm_is_image.mgmt_image.id
  profile = var.profile

  primary_network_interface {
    name            = "eth0"
    subnet          = ibm_is_subnet.mgmt_subnet[0].id
    security_groups = [ibm_is_security_group.mgmt_security_group.id]
  }

  vpc  = ibm_is_vpc.mgmt_vpc.id
  zone = var.zone
  keys = [ data.ibm_is_ssh_key.mgmt_ssh_key.id, ibm_is_ssh_key.public_key.id ]

  user_data = file("${path.module}/scripts/setup.sh")

  tags = ["mgmt-${var.project_name}-${var.environment}"]
}

resource null_resource "wait-4-cloudinit" {

  depends_on = [ ibm_is_instance.mgmt_instance ]
  
  provisioner "remote-exec" {
    inline = [ "while [ ! -f '/root/cloudinit.done' ]; do echo 'waiting for userdata to complete...'; sleep 10; done" ]

    connection {
      type        = "ssh"
      user        = "root"
      host        = ibm_is_floating_ip.mgmt_instance_floating_ip.address
      private_key = tls_private_key.ssh_key_keypair.private_key_pem
    }
  }
}
