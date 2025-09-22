resource "google_compute_region_disk" "postgres_disk" {
  count   = var.pg_disk_count
  project = var.project_id
  name    = "${var.namespace_name}-postgres-${count.index}"
  type    = var.disk_type
  region  = var.region
  size    = var.pg_disk_size

  replica_zones = var.zones
}

resource "google_compute_region_disk_resource_policy_attachment" "pg_disk_attachment" {
  count      = var.pg_disk_count
  name       = google_compute_resource_policy.policy.name
  disk       = google_compute_region_disk.postgres_disk[count.index].name
  project    = var.project_id
  region     = var.region
  depends_on = [google_compute_region_disk.postgres_disk]
}

resource "google_compute_region_disk" "iotcore_disk" {
  count   = var.iotcore_disk_count
  project = var.project_id
  name    = "${var.namespace_name}-iotcore"
  type    = var.disk_type
  region  = var.region
  size    = var.iotcore_disk_size

  replica_zones = var.zones
}

resource "google_compute_region_disk" "console_disk" {
  count   = var.console_disk_count
  project = var.project_id
  name    = "${var.namespace_name}-ia"
  type    = var.disk_type
  region  = var.region
  size    = var.console_disk_size

  replica_zones = var.zones
}

resource "google_compute_region_disk_resource_policy_attachment" "iotcore_disk_attachment" {
  count      = var.iotcore_disk_count
  name       = google_compute_resource_policy.policy.name
  disk       = google_compute_region_disk.iotcore_disk[0].name
  project    = var.project_id
  region     = var.region
  depends_on = [google_compute_region_disk.iotcore_disk]
}

resource "google_compute_region_disk" "file_hosting_disk" {
  count   = 1
  project = var.project_id
  name    = "${var.namespace_name}-file-hosting"
  type    = var.disk_type
  region  = var.region
  size    = var.file_hosting_disk_size

  replica_zones = var.zones
}

resource "google_compute_region_disk_resource_policy_attachment" "file_hosting_disk_attachment" {
  count      = 1
  name       = google_compute_resource_policy.policy.name
  disk       = google_compute_region_disk.file_hosting_disk.name
  project    = var.project_id
  region     = var.region
  depends_on = [google_compute_region_disk.file_hosting_disk]
}

resource "google_compute_resource_policy" "policy" {
  name   = "${var.namespace_name}-snapshot"
  region = var.region
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = var.days_in_cycle
        start_time    = var.start_time
      }
    }
  }
}