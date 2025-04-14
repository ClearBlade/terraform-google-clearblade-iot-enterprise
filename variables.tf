variable "project_id" {
  description = "Google Cloud Project Id"
  type = string
}

variable "region" {
  description = "Google Cloud Region"
  type    = string
  default = "us-central1"
}

variable "namespace_name" {
  description = "Instance namespace"
  type        = string
  default = "clearblade"
}

variable "zones" {
  description = "Zone names in region"
  type        = list(any)
  default     = ["us-central1-a", "us-central1-b"]
}

variable "gke_cluster_version_prefix" {
  description = "GKE version"
  type        = string
  default     = "1.27."
}

variable "initial_node_count" {
  description = "Initial number of nodes"
  type        = number
  default     = 1
}

variable "min_node_count" {
  description = "Min number of nodes for autoscale"
  type        = number
}

variable "max_node_count" {
  description = "Max number of nodes for autoscale"
  type        = number
}

variable "release_channel" {
  description = "Name of the release channel"
  type        = string
  default     = "UNSPECIFIED"
}

variable "monitoring_components" {
  description = "Name of the monitoring components to enable"
  type        = list(any)
  default     = ["SYSTEM_COMPONENTS"]
}

variable "enable_prometheus" {
  description = "Enable prometheus"
  type        = bool
  default     = true
}

variable "auto_upgrade" {
  description = "Enable auto upgrade"
  type        = bool
  default     = false
}

variable "node_machine_type" {
  description = "Machine type for nodes"
  type        = string
}

variable "disk_type" {
  description = "Type of the disk"
  type        = string
  default     = "pd-ssd"
}

variable "pg_disk_count" {
  description = "How many postgres disks should be created"
  type        = number
  default     = 1
}

variable "pg_disk_size" {
  description = "Size of the postgres disk"
  type        = string
}

variable "iotcore_disk_count" {
  description = "How many iotcore disks should be created"
  type        = number
  default     = 0
}

variable "iotcore_disk_size" {
  description = "Size of the iotcore disk"
  type        = string
}

variable "console_disk_count" {
  description = "How many console disks should be created"
  type        = number
  default     = 0
}

variable "console_disk_size" {
  description = "Size of the console disk"
  type        = string
}

variable "days_in_cycle" {
  description = "Snapshot days in cycle"
  type        = number
}

variable "start_time" {
  description = "What time to start the snapshot"
  type        = string
}

variable "helm_chart_name" {
  description = "name of helm chart"
  type = string
  default = "clearblade-iot-enterprise"
}

variable "helm_chart" {
  description = "location of helm chart"
  type = string
  default = "https://github.com/ClearBlade/helm-charts/releases/download/clearblade-iot-enterprise-3.1.1/clearblade-iot-enterprise-3.1.1.tgz"
}

variable "postgres_primary_password_length" {
  description = "password length for postgres primary password"
  type = number
  default = 16
}

variable "postgres_replica_password_length" {
  description = "password length for postgres replica password"
  type = number
  default = 16
}

variable "postgres_postgres_password_length" {
  description = "password length for postgres password"
  type = number
  default = 16
}

variable "registration_key_length" {
  description = "length of the registration key"
  type = number
  default = 8
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token for a creating DNS record"
  type = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type = string
}

variable "tls_certificate" {
  description = "TLS certificate PEM. Set if you have your own TLS certificate and are not using the automatic cert renewal with LetsEncrypt"
  type = string
  default = ""
}

variable "service_account_access_token" {
  description = "Service account access token"
  type = string
  default = ""
  sensitive = true
}

variable "create_gke_cluster" {
  description = "Create GKE cluster"
  type = bool
  default = true
}

variable "create_gke_node_pool" {
  description = "Create GKE node pool"
  type = bool
  default = true
}


variable "helm_values" {
  description = "helm values"
  type = object({
    gcp_gsm_service_account = optional(string, "clearblade-gsm-read")
    image_puller_secret = string
    blue_version = string
    green_version = optional(string, "")
    blue_green_slot = optional(string, "blue")
    base_url = optional(string, "")
    base_url_suffix = optional(string, "clearblade.io")
    instance_id = string
    iotcore_enabled = optional(bool, false)
    ia_enabled = optional(bool, false)
    ops_console_enabled = optional(bool, false)
    cloudsql_enabled = optional(bool, false)
    memorystore_enabled = optional(bool, false)
    storage_class = optional(string, "premium-rwo")
    console_request_cpu = optional(number, 1)
    console_request_memory = optional(string, "1G")
    console_limit_cpu = optional(number, 1)
    console_limit_memory = optional(string, "1G")
    file_hosting_request_cpu = optional(number, 1)
    file_hosting_request_memory = optional(string, "1G")
    file_hosting_limit_cpu = optional(number, 1)
    file_hosting_limit_memory = optional(string, "1G")
    haproxy_replicas = optional(number, 1)
    haproxy_request_cpu = optional(number, 1)
    haproxy_request_memory = optional(string, "1G")
    haproxy_limit_cpu = optional(number, 1)
    haproxy_limit_memory = optional(string, "1G")
    haproxy_enabled = optional(bool, true)
    haproxy_mqtt_over_443 = optional(bool, false)
    renewal_days = optional(number, 5)
    primary_ip = optional(string, "")
    create_mqtt_ip = optional(bool, false)
    iotcore_check_clearblade_rediness = optional(bool, true)
    iotcore_request_cpu = optional(number, 1)
    iotcore_request_memory = optional(string, "1G")
    iotcore_limit_cpu = optional(number, 1)
    iotcore_limit_memory = optional(string, "1G")
    iotcore_version = optional(string, "")
    iotcore_regions = optional(string, "")
    ia_check_clearblade_rediness = optional(bool, true)
    ia_request_cpu = optional(number, 1)
    ia_request_memory = optional(string, "1G")
    ia_limit_cpu = optional(number, 1)
    ia_limit_memory = optional(string, "1G")
    ia_version = optional(string, "")
    postgres_enabled = optional(bool, true)
    postgres_replicas = optional(number, 1)
    postgres_request_cpu = optional(number, 1)
    postgres_request_memory = optional(string, "2G")
    postgres_limit_cpu = optional(number, 1)
    postgres_limit_memory = optional(string, "2G")
    postgres_0disk_name = optional(string, "postgres-0")
    redis_enabled = optional(bool, true)
    redis_high_availability = optional(bool, false)
    redis_request_cpu = optional(number, 1)
    redis_request_memory = optional(string, "2G")
    redis_limit_cpu = optional(number, 1)
    redis_limit_memory = optional(string, "2G")
    clearblade_blue_replicas = optional(number, 2)
    clearblade_green_replicas = optional(number, 0)
    clearblade_mqtt_allow_duplicate_clientid = optional(bool, true)
    clearblade_request_cpu = optional(number, 1)
    clearblade_request_memory = optional(string, "1G")
    clearblade_limit_cpu = optional(number, 1)
    clearblade_limit_memory = optional(string, "1G")
  })
}

