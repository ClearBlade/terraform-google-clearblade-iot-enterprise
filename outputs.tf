output "clearblade_registration_key" {
    value = clearblade-google_random_string.registration_key.value
}

output "primary_ip" {
    value = var.primary_ip == "" ? google_compute_address.cb_primary[0].address : var.primary_ip
}

output "mqtt_ip" {
    value = var.create_mqtt_ip == true ? google_compute_address.cb_mqtt[0].address : ""
}

output "url" {
    value = var.base_url == "" ? "${var.namespace_name}.${var.base_url_suffix}" : var.base_url
}

