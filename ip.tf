resource "google_compute_address" "cb_primary" {
  count = var.primary_ip == "" ? 1 : 0
  name = "${var.namespace_name}-cb-primary"
  region = var.region
}

resource "google_compute_address" "cb_mqtt" {
  count = var.create_mqtt_ip == true ? 1 : 0
  name = "${var.namespace_name}-cb-mqtt"
  region = var.region
}