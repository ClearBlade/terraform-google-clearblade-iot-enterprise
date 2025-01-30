output "clearblade_registration_key" {
    value = clearblade-google_random_string.registration_key.value
}

output "primary_ip" {
    value = var.helm_values.primary_ip == "" ? google_compute_address.cb_primary[0].address : var.helm_values.primary_ip
}

output "mqtt_ip" {
    value = var.helm_values.create_mqtt_ip == true ? google_compute_address.cb_mqtt[0].address : ""
}

output "url" {
    value = var.helm_values.base_url == "" ? "${var.namespace_name}.${var.helm_values.base_url_suffix}" : var.helm_values.base_url
}

