resource "cloudflare_dns_record" "domain" {
    count = var.create_dns_record ? 1 : 0
    zone_id = var.cloudflare_zone_id
    name    = split(".", var.helm_values.base_url)[0]
    content   = var.helm_values.primary_ip == "" ? google_compute_address.cb_primary[0].address : var.helm_values.primary_ip
    type    = "A"
    ttl     = 3600
}