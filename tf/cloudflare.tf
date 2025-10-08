variable "cloudflare_account_email" {
  description = "Cloudflare account email"
  type = string
  sensitive = true
}

variable "cloudflare_api_key" {
  description = "Cloudflare API key"
  type = string
  sensitive = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare account ID"
  type = string
  sensitive = true
}

provider "cloudflare" {
  email = var.cloudflare_account_email
  api_key = var.cloudflare_api_key
}
