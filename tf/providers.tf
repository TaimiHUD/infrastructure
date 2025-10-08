terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
    porkbun = {
      source = "kyswtn/porkbun"
      version = "0.1.3"
    }
  }
}
