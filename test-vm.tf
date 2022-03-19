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

# sample of using a drive as a base
resource "libvirt_volume" "server1" {
  name           = "server1.qcow2"
  base_volume_id = libvirt_volume.test_ubuntu.id
}
resource "libvirt_domain" "server1" {
    name = "ubuntu-server1"
    vcpu = 2
    memory = 2048
    running = true 
    # disk {
    #     volume_id = libvirt_volume.ubuntu_focal_server.id
    # }
    disk {
      volume_id = libvirt_volume.server1.id
    }
    network_interface {
      bridge = "virbr0"
    }
}
resource "libvirt_volume" "server2" {
  name           = "server2.qcow2"
  base_volume_id = libvirt_volume.test_ubuntu.id
}
resource "libvirt_domain" "server2" {
    name = "ubuntu-server2"
    vcpu = 2
    memory = 2048
    running = true 
    # disk {
    #     volume_id = libvirt_volume.ubuntu_focal_server.id
    # }
    disk {
      volume_id = libvirt_volume.server2.id
    }
    network_interface {
      bridge = "virbr0"
    }
}