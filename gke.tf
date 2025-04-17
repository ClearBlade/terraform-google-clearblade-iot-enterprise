data "google_container_engine_versions" "cluster_version" {
  version_prefix = var.gke_cluster_version_prefix
}

data "google_client_config" "provider" {}

data "google_container_cluster" "primary" {
  name       = var.gke_cluster_name == "" ? "${var.project_id}-primary-cluster" : var.gke_cluster_name
  depends_on = [ google_container_cluster.primary ]
}

resource "google_container_cluster" "primary" {
  count                    = "${var.create_gke_cluster ? 1 : 0}"
  name                     = var.gke_cluster_name == "" ? "${var.project_id}-primary-cluster" : var.gke_cluster_name
  location                 = var.region
  node_locations           = var.zones
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection = false
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

  depends_on = [
    clearblade-google_mek.clearblade_mek,
    clearblade-google_random_string.postgres_primary_password,
    clearblade-google_random_string.postgres_replica_password,
    clearblade-google_random_string.postgres_postgres_password,
    clearblade-google_random_string.registration_key
  ]
}

resource "google_container_node_pool" "primary_nodes" {
  count              = "${var.create_gke_node_pool ? 1 : 0}"
  name               = var.gke_node_pool_name == "" ? "${var.project_id}-primary-pool" : var.gke_node_pool_name
  location           = var.region
  cluster            = data.google_container_cluster.primary.name
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