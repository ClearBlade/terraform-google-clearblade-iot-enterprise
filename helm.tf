data "clearblade-google_helm_values" "cb_helm_values" {
  options = {
    global = {
        namespace = var.namespace_name
        image_puller_secret = var.helm_values.image_puller_secret
        enterprise_base_url = var.helm_values.base_url == "" ? "${var.namespace_name}.${var.helm_values.base_url_suffix}" : var.helm_values.base_url
        enterprise_blue_version = var.helm_values.blue_version
        enterprise_green_version = var.helm_values.green_version
        enterprise_console_version = var.helm_values.console_version
        enterprise_slot = var.helm_values.blue_green_slot
        enterprise_instance_id = var.helm_values.instance_id
        enterprise_registration_key = var.helm_values.enterprise_registration_key == "" ? clearblade-google_random_string.registration_key.value : var.helm_values.enterprise_registration_key
        iotcore_enabled = var.helm_values.iotcore_enabled
        ia_enabled = var.helm_values.ia_enabled
        ops_console_enabled = var.helm_values.ops_console_enabled
        gcp_cloudsql_enabled = var.helm_values.cloudsql_enabled
        gcp_memorystore_enabled = var.helm_values.memorystore_enabled
        gcp_project = var.project_id
        gcp_region = var.region
        gcp_gsm_service_account = var.helm_values.gcp_gsm_service_account
        storage_class_name = var.helm_values.storage_class
        enable_mtls_clearblade = var.helm_values.clearblade_mtls_enable
        enable_mtls_haproxy = var.helm_values.haproxy_mtls_enable
    }
    cb_console = {
        request_cpu = var.helm_values.console_request_cpu
        request_memory = var.helm_values.console_request_memory
        limit_cpu = var.helm_values.console_limit_cpu
        limit_memory = var.helm_values.console_limit_memory
    }
    cb_file_hosting = {
        request_cpu = var.helm_values.file_hosting_request_cpu
        request_memory = var.helm_values.file_hosting_request_memory
        limit_cpu = var.helm_values.file_hosting_limit_cpu
        limit_memory = var.helm_values.file_hosting_limit_memory
    }
    cb_haproxy = {
        replicas = var.helm_values.haproxy_replicas
        enabled = var.helm_values.haproxy_enabled
        primary_ip = var.helm_values.primary_ip == "" ? google_compute_address.cb_primary[0].address : var.helm_values.primary_ip
        mqtt_ip = var.helm_values.create_mqtt_ip == true ? google_compute_address.cb_mqtt[0].address : ""
        mqtt_over_443 = var.helm_values.haproxy_mqtt_over_443
        request_cpu = var.helm_values.haproxy_request_cpu
        request_memory = var.helm_values.haproxy_request_memory
        limit_cpu = var.helm_values.haproxy_limit_cpu
        limit_memory = var.helm_values.haproxy_limit_memory
        cert_renewal = var.tls_certificate == "" ? true : false
        renewal_days = var.helm_values.renewal_days
        controller_version = var.helm_values.haproxy_controller_version
        acme_config = var.helm_values.haproxy_controller_acme
        check_clearblade_readiness = var.helm_values.haproxy_check_clearblade_readiness
        platform_cert_name = var.helm_values.haproxy_platform_cert_name
        mqtt_cert_name = var.helm_values.haproxy_mqtt_cert_name
    }
    cb_iotcore = {
        check_clearblade_readiness = var.helm_values.iotcore_check_clearblade_rediness
        request_cpu = var.helm_values.iotcore_request_cpu
        request_memory = var.helm_values.iotcore_request_memory
        limit_cpu = var.helm_values.iotcore_limit_cpu
        limit_memory = var.helm_values.iotcore_limit_memory
        version = var.helm_values.iotcore_version
        regions = var.helm_values.iotcore_regions
    }
    cb_ia = {
        check_clearblade_readiness = var.helm_values.ia_check_clearblade_rediness
        request_cpu = var.helm_values.ia_request_cpu
        request_memory = var.helm_values.ia_request_memory
        limit_cpu = var.helm_values.ia_limit_cpu
        limit_memory = var.helm_values.ia_limit_memory
        version = var.helm_values.ia_version
    }
    cb_postgres = {
        enabled = var.helm_values.postgres_enabled
        replicas = var.helm_values.postgres_replicas
        request_cpu = var.helm_values.postgres_request_cpu
        request_memory = var.helm_values.postgres_request_memory
        limit_cpu = var.helm_values.postgres_limit_cpu
        limit_memory = var.helm_values.postgres_limit_memory
        postgres0_disk_name = var.helm_values.postgres_0disk_name
    }
    cb_redis = {
        enabled = var.helm_values.redis_enabled
        high_availability = var.helm_values.redis_high_availability
        request_cpu = var.helm_values.redis_request_cpu
        request_memory = var.helm_values.redis_request_memory
        limit_cpu = var.helm_values.redis_limit_cpu
        limit_memory = var.helm_values.redis_limit_memory
    }
    clearblade = {
        blue_replicas = var.helm_values.clearblade_blue_replicas
        green_replicas = var.helm_values.clearblade_green_replicas
        mqtt_allow_duplicate_client_id = var.helm_values.clearblade_mqtt_allow_duplicate_clientid
        request_cpu = var.helm_values.clearblade_request_cpu
        request_memory = var.helm_values.clearblade_request_memory
        limit_cpu = var.helm_values.clearblade_limit_cpu
        limit_memory = var.helm_values.clearblade_limit_memory
        license_renewal_webhooks = var.helm_values.clearblade_license_renewal_webhooks
        metrics_reporting_webhooks = var.helm_values.clearblade_metrics_reporting_webhooks
    }
  }
}

resource "helm_release" "deploy" {
  name  = var.namespace_name
  chart = var.helm_chart
  timeout = 3600

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
