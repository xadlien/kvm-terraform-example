# Configure the Libvirt provider
terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}
provider "libvirt" {
    uri = "qemu:///system"
}
resource "libvirt_volume" "ubuntu_focal_server" {
    name   = "ubuntu_focal_server"
    source = "/home/xadlien/images/os/ubuntu-20.04.2-live-server-amd64.iso"
}
resource "libvirt_volume" "test_ubuntu" {
  name           = "test_ubuntu.qcow2"
  size = 10000000000
}
resource "libvirt_domain" "default" {
    name = "testvm-ubuntu1"
    vcpu = 2
    memory = 2048
    running = true 
    # disk {
    #     volume_id = libvirt_volume.ubuntu_focal_server.id
    # }
    disk {
      volume_id = libvirt_volume.test_ubuntu.id
    }
    network_interface {
      bridge = "virbr0"
    }
}