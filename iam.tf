resource "google_project_iam_member" "workload_identity_role" {
  depends_on = [
    google_container_cluster.primary,
    google_container_node_pool.primary_nodes
  ]
  project = var.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace_name}/clearblade-gsm-read]"
}