resource "clearblade-google_mek" "clearblade_mek" {
    project_id = var.project_id
    namespace = var.namespace_name
    suffix = "_clearblade-mek"
}

resource "clearblade-google_random_string" "postgres_primary_password" {
    project_id = var.project_id
    namespace = var.namespace_name
    suffix = "_postgres-primary-password"
    type = "password"
    length = var.postgres_primary_password_length
}

resource "clearblade-google_random_string" "postgres_replica_password" {
    project_id = var.project_id
    namespace = var.namespace_name
    suffix = "_postgres-replica-password"
    type = "password"
    length = var.postgres_replica_password_length
}

resource "clearblade-google_random_string" "postgres_postgres_password" {
    project_id = var.project_id
    namespace = var.namespace_name
    suffix = "_postgres-postgres-password"
    type = "password"
    length = var.postgres_postgres_password_length
}

resource "clearblade-google_random_string" "registration_key" {
    project_id = var.project_id
    namespace = var.namespace_name
    suffix = "_registration-key"
    type = "registration_key"
    length = var.registration_key_length
}

resource "clearblade-google_tls_certificate" "clearblade_tls_certificate" {
    project_id = var.project_id
    namespace = var.namespace_name
    suffix = "_tls-certificates"
    tls_certificate = var.tls_certificate == "" ? "" : var.tls_certificate
}