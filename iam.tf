resource "google_service_account_iam_binding" "svc_account_iam_binding" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/clearblade-gsm-read@${var.project_id}.iam.gserviceaccount.com"
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace_name}/clearblade-gsm-read]",
  ]
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