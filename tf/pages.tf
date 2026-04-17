variable "zola_version" {
  description = "Version of Zola, the static site generator to install"
  type        = string
  default     = "0.20.0"
}

resource "cloudflare_pages_project" "taimihud" {
  account_id        = var.cloudflare_account_id
  name              = "taimihud"
  production_branch = "main"

  source = {
    type = "github"
    config = {
      owner                         = "TaimiHUD"
      repo_name                     = "website"
      production_branch             = "main"
      deployments_enabled           = true
      pr_comments_enabled           = false
      production_deployment_enabled = true

    }
  }
  build_config = {
    build_command   = "zola build"
    destination_dir = "public"
    #root_dir = "/"
  }
  deployment_configs = {
    production = {
      env_vars = {
        UNSTABLE_PRE_BUILD = {
          type  = "plain_text"
          value = "true"
        }
        ZOLA_VERSION = {
          type  = "plain_text"
          value = var.zola_version
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      deployment_configs,
      source
    ]
  }
}

resource "cloudflare_pages_domain" "taimihud_root" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.taimihud.name
  name         = var.base_domain_name
}

resource "cloudflare_dns_record" "taimihud_root_pages" {
  name    = var.base_domain_name
  proxied = false
  ttl     = 3600
  type    = "CNAME"
  content = cloudflare_pages_project.taimihud.subdomain
  zone_id = cloudflare_zone.taimihud.id
}

resource "cloudflare_page_rule" "taimihud_www_redir" {
  zone_id = cloudflare_zone.taimihud.id
  target = "${cloudflare_dns_record.taimihud_www.name}/*"
  priority = 1
  status = "active"
  actions = {
    forwarding_url = {
      url = "https://${var.base_domain_name}/"
      status_code = 301
    }
  }
}
resource "cloudflare_dns_record" "taimihud_www" {
  name    = "www.${var.base_domain_name}"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  content = cloudflare_pages_project.taimihud.subdomain
  zone_id = cloudflare_zone.taimihud.id
}
