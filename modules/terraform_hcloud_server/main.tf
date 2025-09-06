terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.52.0"
    }
  }

  required_version = ">= 1.13"
}

variable "server_name" {
  description = "Name of the server. Must be unique."
  type        = string

  validation {
    condition     = var.server_name != ""
    error_message = "The server must have a unique name."
  }
}

variable "datacenter" {
  description = "Hetzner datacenter ID. See: https://docs.hetzner.com/cloud/general/locations/#what-datacenters-are-there"
  type        = string
  nullable    = false
}

resource "hcloud_server" "server" {
  name        = var.server_name
  image       = "debian-13"
  server_type = "cpx11"
  datacenter  = var.datacenter
  shutdown_before_deletion = true
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

output "id" {
  description = "ID of the server"
  value       = hcloud_server.server.id
}

output "name" {
  description = "Name of the server"
  value       = hcloud_server.server.name
}

output "ipv4" {
  description = "Server public IPv4 address"
  value       = hcloud_server.server.ipv4_address
}

output "ipv6" {
  description = "Server public IPv6 address"
  value       = hcloud_server.server.ipv6_address
}
