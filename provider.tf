provider "vsphere" {
  user                 = data.external.env.result["vsphere_user"]
  password             = data.external.env.result["vsphere_password"]
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}