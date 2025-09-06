variable "server_name" {
  description = "Name of the server. Must be unique."
  type        = string

  validation {
    condition     = var.server_name != ""
    error_message = "The server must have a unique name."
  }
}

variable "location" {
  description = "Hetzner location ID. See: https://docs.hetzner.com/cloud/general/locations/#what-locations-are-there"
  type        = string
  nullable    = true
}

variable "datacenter" {
  description = "Hetzner datacenter ID. See: https://docs.hetzner.com/cloud/general/locations/#what-datacenters-are-there"
  type        = string
  nullable    = true
}

resource "hcloud_server" "server" {
  name        = var.server_name
  image       = "debian-13"
  server_type = "CPX11"
  location    = var.location
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
  value       = hcloud_primary_ip.static_ipv4.ip_address
}

output "ipv6" {
  description = "Server public IPv6 address"
  value       = hcloud_primary_ip.static_ipv6.ip_address
}
