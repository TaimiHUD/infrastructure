resource "cloudflare_zone" "taimihud" {
  account = {
    id = var.cloudflare_account_id
  }
  name = var.base_domain_name
  type = "full"
}
