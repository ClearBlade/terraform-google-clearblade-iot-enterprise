provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.primary.endpoint}"
    token                  = var.service_account_access_token
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
  }
}

resource "helm_release" "deploy" {
  name  = var.helm_chart_name
  chart = var.helm_chart

  depends_on = [
    google_container_cluster.primary,
    google_container_node_pool.primary_nodes,
    google_compute_resource_policy.policy,
    google_compute_region_disk.postgres_disk,
    google_compute_region_disk.console_disk,
    google_compute_region_disk.iotcore_disk,
    google_compute_region_disk_resource_policy_attachment.pg_disk_attachment,
    google_compute_region_disk_resource_policy_attachment.iotcore_disk_attachment,
    google_project_iam_member.workload_identity_role
  ]

  values = [
    "${file("${var.helm_values_file}")}"
  ]
}