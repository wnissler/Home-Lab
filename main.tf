resource "vsphere_virtual_machine" "ansible" {
  name             = "ansible"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"

  num_cpus = 2
  memory   = 8192
  guest_id = "ubuntu64Guest"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0"
    size  = 40
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu.id
    customize {
      network_interface {
        ipv4_address = var.ansible-ip
        ipv4_netmask = 24
      }
      linux_options {
        host_name = "ansible"
        domain    = var.domain
      }
      ipv4_gateway = var.gateway
      dns_server_list = var.dns
    }
  }
}

#Connecting to the Ansible control node using SSH connection
resource "null_resource" "nullremote-ansible" {
depends_on = [vsphere_virtual_machine.ansible] 
connection {
 type     = "ssh"
 user     = "ansible"
 password = "ansible"
     host= "${vsphere_virtual_machine.ansible.default_ip_address}" 
}
#Copying the generated inventory file to Ansible 
provisioner "file" {
    source      = "${path.module}/ansible/inventory.cfg"
    destination = "/home/ansible/inventory.cfg"
    }
#Copying the config script for ansible
provisioner "file" {
    source      = "${path.module}/scripts/ansible.sh"
    destination = "/home/ansible/ansible.sh"
    }
provisioner "remote-exec" {
  inline = [
    "chmod +x ./ansible.sh",
    "./ansible.sh"
  ]
}
}

resource "vsphere_virtual_machine" "master" {
  name             = "k8s-master"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"

  num_cpus = 2
  memory   = 8192
  guest_id = "ubuntu64Guest"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0"
    size  = 40
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu.id
    customize {
      network_interface {
        ipv4_address = var.k8s-master-ip
        ipv4_netmask = 24
      }
      linux_options {
        host_name = "k8s-master"
        domain    = var.domain
      }
      ipv4_gateway = var.gateway
      dns_server_list = var.dns
    }
  }
}

resource "vsphere_virtual_machine" "node" {
  count            = "2"
  name             = "k8s-worker-${count.index + 1}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"

  num_cpus = 2
  memory   = 16384
  guest_id = "ubuntu64Guest"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0"
    size  = 200
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu.id
    customize {
      network_interface {
        ipv4_address = "192.168.1.1${count.index + 1}"
        ipv4_netmask = 24
      }
      linux_options {
        host_name = "k8s-worker-${count.index + 1}"
        domain    = var.domain
      }
      ipv4_gateway = var.gateway
      dns_server_list = var.dns
    }
  }
}

resource "local_file" "inventory" {
  content = templatefile("${path.module}/ansible/inventory.tpl",
    {
      master_nodes = vsphere_virtual_machine.master.default_ip_address
      worker_nodes = vsphere_virtual_machine.node.*.default_ip_address
    }
  )
  filename = "./ansible/inventory.cfg"
}


