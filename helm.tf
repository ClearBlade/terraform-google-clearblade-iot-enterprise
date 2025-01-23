data "clearblade-google_helm_values" "cb_helm_values" {
  options = {
    global = {
        namespace = var.namespace_name
        image_puller_secret = var.image_puller_secret
        enterprise_base_url = var.base_url == "" ? "${var.namespace_name}.${var.base_url_suffix}" : var.base_url
        enterprise_blue_version = var.blue_version
        enterprise_green_version = var.green_version
        enterprise_slot = var.blue_green_slot
        enterprise_instance_id = var.instance_id
        enterprise_registration_key = clearblade-google_random_string.registration_key.value
        iotcore_enabled = var.iotcore_enabled
        ia_enabled = var.ia_enabled
        gcp_cloudsql_enabled = var.cloudsql_enabled
        gcp_memorystore_enabled = var.memorystore_enabled
        gcp_project = var.project_id
        gcp_region = var.region
        gcp_gsm_service_account = var.gcp_gsm_service_account
        storage_class_name = var.storage_class
    }
    cb_console = {
        request_cpu = var.console_request_cpu
        request_memory = var.console_request_memory
        limit_cpu = var.console_limit_cpu
        limit_memory = var.console_limit_memory
    }
    cb_file_hosting = {
        request_cpu = var.file_hosting_request_cpu
        request_memory = var.file_hosting_request_memory
        limit_cpu = var.file_hosting_limit_cpu
        limit_memory = var.file_hosting_limit_memory
    }
    cb_haproxy = {
        replicas = var.haproxy_replicas
        enabled = var.haproxy_enabled
        primary_ip = var.primary_ip == "" ? google_compute_address.cb_primary[0].address : var.primary_ip
        mqtt_ip = var.create_mqtt_ip == true ? google_compute_address.cb_mqtt[0].address : ""
        mqtt_over_443 = var.haproxy_mqtt_over_443
        request_cpu = var.haproxy_request_cpu
        request_memory = var.haproxy_request_memory
        limit_cpu = var.haproxy_limit_cpu
        limit_memory = var.haproxy_limit_memory
        cert_renewal = var.tls_certificate == "" ? true : false
        renewal_days = var.renewal_days
    }
    cb_iotcore = {
        check_clearblade_readiness = var.iotcore_check_clearblade_rediness
        request_cpu = var.iotcore_request_cpu
        request_memory = var.iotcore_request_memory
        limit_cpu = var.iotcore_limit_cpu
        limit_memory = var.iotcore_limit_memory
    }
    cb_ia = {
        check_clearblade_readiness = var.ia_check_clearblade_rediness
        request_cpu = var.ia_request_cpu
        request_memory = var.ia_request_memory
        limit_cpu = var.ia_limit_cpu
        limit_memory = var.ia_limit_memory
    }
    cb_postgres = {
        enabled = var.postgres_enabled
        replicas = var.postgres_replicas
        request_cpu = var.postgres_request_cpu
        request_memory = var.postgres_request_memory
        limit_cpu = var.postgres_limit_cpu
        limit_memory = var.postgres_limit_memory
        postgres0_disk_name = var.postgres_0disk_name
    }
    cb_redis = {
        enabled = var.redis_enabled
        high_availability = var.redis_high_availability
        request_cpu = var.redis_request_cpu
        request_memory = var.redis_request_memory
        limit_cpu = var.redis_limit_cpu
        limit_memory = var.redis_limit_memory
    }
    clearblade = {
        blue_replicas = var.clearblade_blue_replicas
        green_replicas = var.clearblade_green_replicas
        mqtt_allow_duplicate_client_id = var.clearblade_mqtt_allow_duplicate_clientid
        request_cpu = var.clearblade_request_cpu
        request_memory = var.clearblade_request_memory
        limit_cpu = var.clearblade_limit_cpu
        limit_memory = var.clearblade_limit_memory
    }
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
  ]

  values = [data.clearblade-google_helm_values.cb_helm_values.values]
}