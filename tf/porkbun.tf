variable "porkbun_api_key" {
  description = "Porkbun API key for nameserver management"
  type        = string
  sensitive   = true
}

variable "porkbun_secret_key" {
  description = "Porkbun API secret key for nameserver management"
  type        = string
  sensitive   = true
}

provider "porkbun" {
  api_key        = var.porkbun_api_key
  secret_api_key = var.porkbun_secret_key
}
