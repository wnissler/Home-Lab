variable "vsphere_server" {
  description = "vSphere server IP"
  default = "192.168.1.201"
}

variable "vsphere_datacenter" {
  description = "vSphere datacenter"
  default = "DC-01"
}

variable "vsphere_compute_cluster" {
  description = "vSphere compute cluster"
  default = "home-lab"
}

variable "vsphere_datastore" {
  description = "vSphere datastore"
  default = "datastore1"
}

variable "vsphere_network" {
  description = "vSphere network"
  default = "VM Network"
}

variable "vsphere_sandbox_network" {
  description = "vSphere sandbox network"
  default = "Sandbox Network"
}

variable "gateway" {
  description = "vSphere gateway IP"
  default = "192.168.1.1"
}

variable "dns" {
  description = "vSphere DNS servers"
  default = ["192.168.1.205", "8.8.8.8"]
}

variable "domain" {
  description = "vSphere domain"
  default = "homelab.local"
}

variable "ansible-ip" {
  description = "IP address for ansible control server"
  default = "192.168.1.15"
}

variable "k8s-master-ip" {
  description = "IP address for k8s master node"
  default = "192.168.1.10"
}


