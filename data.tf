#Read environment variables set from setenv.ps1
data "external" "env" {
  program = ["${path.module}/scripts/env.ps1"]
}
#vSphere straightforward-ness
data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "ubuntu" {
  name          = "ubuntu18"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
#Export environment variables to read in later
output "env" {
  value = data.external.env.result
}
