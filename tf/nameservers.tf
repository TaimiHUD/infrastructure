variable "base_domain_name" {
  description = "The base domain name for our infrastructure"
  type = string
  sensitive = true

  default = "taimihud.com"
}

resource "porkbun_nameservers" "taimihud" {
  domain = var.base_domain_name
  nameservers = cloudflare_zone.taimihud.name_servers
}
