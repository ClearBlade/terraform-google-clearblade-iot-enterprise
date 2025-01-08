resource "google_compute_address" "cb_primary" {
  name = "${var.namespace_name}-cb-primary"
  region = var.region
}

resource "google_compute_address" "cb_mqtt" {
  name = "${var.namespace_name}-cb-mqtt"
  region = var.region
}