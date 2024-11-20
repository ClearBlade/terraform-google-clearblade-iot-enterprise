terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project         = var.project_id
  access_token    = var.service_account_access_token
  zone            = var.region
}

data "google_container_engine_versions" "cluster_version" {
  version_prefix = var.gke_cluster_version_prefix
}

resource "google_container_cluster" "primary" {
  name                     = var.namespace_name
  location                 = var.region
  node_locations           = var.zones
  remove_default_node_pool = true
  initial_node_count       = 1
  release_channel {
    channel = var.release_channel
  }
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
  monitoring_config {
    enable_components = var.monitoring_components
    managed_prometheus {
      enabled = var.enable_prometheus
    }
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name               = "${var.namespace_name}-primary-pool"
  location           = var.region
  cluster            = google_container_cluster.primary.name
  initial_node_count = var.initial_node_count

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  management {
    auto_upgrade = var.auto_upgrade
  }

  node_config {
    preemptible  = true
    machine_type = var.node_machine_type
  }
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
  name    = "${var.namespace_name}-console"
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

resource "google_project_iam_member" "workload_identity_role" {
  depends_on = [
    google_container_cluster.primary,
    google_container_node_pool.primary_nodes
  ]
  project = var.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace_name}/clearblade-gsm-read]"
}