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
  default = "https://github.com/ClearBlade/helm-charts/releases/download/clearblade-iot-enterprise-3.1.0/clearblade-iot-enterprise-3.1.0.tgz"
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



# Global

variable "gcp_gsm_service_account" {
  description = "GCP Secret Manager service account ID"
  type = string
  default = "clearblade-gsm-read"
}

variable "image_puller_secret" {
  description = "Secret to pull containers from the Google Container Registry"
  type = string
}

variable "blue_version" {
  description = "The blue version is the default ClearBlade version"
  type = string
}

variable "green_version" {
  description = "Needed for blue green upgrades. Ignore if not using"
  type = string
  default = ""
}

variable "blue_green_slot" {
  description = "Slot for blue green upgrades. Ignore if not using"
  type = string
  default = "blue"
}

variable "base_url" {
  description = "The base URL the platform will be reachable at. Set if you have your own domain name"
  type = string
  default = ""
}

variable "base_url_suffix" {
  description = "For example clearblade.com"
  type = string
  default = "clearblade.io"
}

variable "instance_id" {
  description = "The Instance ID for the deployment, provided by ClearBlade"
  type = string
}

variable "iotcore_enabled" {
  description = "Set to true if this deployment uses the IOTCore Sidecar"
  type = bool
  default = false
}

variable "ia_enabled" {
  description = "Set to true if this deployment uses the Intelligent Assets Sidecar"
  type = bool
  default = false
}

variable "cloudsql_enabled" {
  description = "Set to true if you are using GCP's Cloud SQL instead of postgres"
  type = bool
  default = false
}

variable "memorystore_enabled" {
  description = "Set to true if you are using GCP's MemoryStore instead of redis"
  type = bool
  default = false
}

variable "storage_class" {
  description = "Define the storage class used by all Persistent Volume Claims in the deployment"
  type = string
  default = "premium-rwo"
}



# Console CPU and memory

variable "console_request_cpu" {
  description = "ClearBlade Console requested CPU"
  type = number
  default = 1
}

variable "console_request_memory" {
  description = "ClearBlade Console requested memory"
  type = string
  default = "1G"
}

variable "console_limit_cpu" {
  description = "ClearBlade Console CPU limit"
  type = number
  default = 1
}

variable "console_limit_memory" {
  description = "ClearBlade Console memory limit"
  type = string
  default = "1G"
}



# File hosting CPU and memory

variable "file_hosting_request_cpu" {
  description = "ClearBlade File Hosting requested CPU"
  type = number
  default = 1
}

variable "file_hosting_request_memory" {
  description = "ClearBlade File Hosting requested memory"
  type = string
  default = "1G"
}

variable "file_hosting_limit_cpu" {
  description = "ClearBlade File Hosting CPU limit"
  type = number
  default = 1
}

variable "file_hosting_limit_memory" {
  description = "ClearBlade File Hosting memory limit"
  type = string
  default = "1G"
}



# HAProxy CPU and memory

variable "haproxy_replicas" {
  description = "Number of HAProxy replicas"
  type = number
  default = 1
}

variable "haproxy_request_cpu" {
  description = "HAProxy requested CPU"
  type = number
  default = 1
}

variable "haproxy_request_memory" {
  description = "HAProxy requested memory"
  type = string
  default = "1G"
}

variable "haproxy_limit_cpu" {
  description = "HAProxy CPU limit"
  type = number
  default = 1
}

variable "haproxy_limit_memory" {
  description = "HAProxy memory limit"
  type = string
  default = "1G"
}

variable "haproxy_enabled" {
  description = "Set to false if using an external HAProxy deployment"
  type = bool
  default = true
}

variable "haproxy_mqtt_over_443" {
  description = "Set to true for allowing MQTT connections over port 443 in addition to the default 1883"
  type = bool
  default = false
}

variable "renewal_days" {
  description = "Days out to renew cert if using automatic cert renewal with LetsEncrypt"
  type = number
  default = 5
}

variable "primary_ip" {
  description = "The primary external IP address for the deployment. Set if you already have an external IP address setup in GCP"
  type = string
  default = ""
}

variable "create_mqtt_ip" {
  description = "Set to true if utilizing external MQTT connections"
  type = bool
  default = false
}



# IoT Core CPU and memory

variable "iotcore_check_clearblade_rediness" {
  description = "Set to true to force the IOTCore pod to wait for the Clearblade pods before starting"
  type = bool
  default = false
}

variable "iotcore_request_cpu" {
  description = "ClearBlade IoT Core requested CPU"
  type = number
  default = 1
}

variable "iotcore_request_memory" {
  description = "ClearBlade IoT Core requested memory"
  type = string
  default = "1G"
}

variable "iotcore_limit_cpu" {
  description = "ClearBlade IoT Core CPU limit"
  type = number
  default = 1
}

variable "iotcore_limit_memory" {
  description = "ClearBlade IoT Core memory limit"
  type = string
  default = "1G"
}



# IA CPU and memory

variable "ia_check_clearblade_rediness" {
  description = "Set to true to force the Intelligent Assets pod to wait for the Clearblade pods before starting"
  type = bool
  default = false
}

variable "ia_request_cpu" {
  description = "ClearBlade Intelligent Assets requested CPU"
  type = number
  default = 1
}

variable "ia_request_memory" {
  description = "ClearBlade Intelligent Assets requested memory"
  type = string
  default = "1G"
}

variable "ia_limit_cpu" {
  description = "ClearBlade Intelligent Assets CPU limit"
  type = number
  default = 1
}

variable "ia_limit_memory" {
  description = "ClearBlade Intelligent Assets memory limit"
  type = string
  default = "1G"
}



# Postgres CPU and memory

variable "postgres_enabled" {
  description = "Set to false if using an external postgres deployment"
  type = bool
  default = true
}

variable "postgres_replicas" {
  description = "Number of Postgres replicas"
  type = number
  default = 1
}

variable "postgres_request_cpu" {
  description = "Postgres requested CPU"
  type = number
  default = 1
}

variable "postgres_request_memory" {
  description = "Postgres requested memory"
  type = string
  default = "2G"
}

variable "postgres_limit_cpu" {
  description = "Postgres CPU limit"
  type = number
  default = 1
}

variable "postgres_limit_memory" {
  description = "Postgres memory limit"
  type = string
  default = "2G"
}

variable "postgres_0disk_name" {
  description = "Postgres0 disk name"
  type = string
  default = "postgres-0"
}



# Redis CPU and memory

variable "redis_enabled" {
  description = "Set to false if using an external redis deployment"
  type = bool
  default = true
}

variable "redis_high_availability" {
  description = "Set to true to utilize redis sentinel with automatic failover. Requires roughly 4x CPU/mem as a non-HA deployment"
  type = bool
  default = false
}

variable "redis_request_cpu" {
  description = "Redis requested CPU"
  type = number
  default = 1
}

variable "redis_request_memory" {
  description = "Redis requested memory"
  type = string
  default = "2G"
}

variable "redis_limit_cpu" {
  description = "Redis CPU limit"
  type = number
  default = 1
}

variable "redis_limit_memory" {
  description = "Redis memory limit"
  type = string
  default = "2G"
}



# ClearBlade CPU and memory

variable "clearblade_blue_replicas" {
  description = "If not using blue/green deployments, blue is the default"
  type = number
  default = 2
}

variable "clearblade_green_replicas" {
  description = "If not using blue/green deployments, set to 0"
  type = number
  default = 0
}

variable "clearblade_mqtt_allow_duplicate_clientid" {
  description = "Set to true to allow duplicate client IDs. Set to false to reject duplicate connections"
  type = bool
  default = true
}

variable "clearblade_request_cpu" {
  description = "ClearBlade requested CPU"
  type = number
  default = 1
}

variable "clearblade_request_memory" {
  description = "ClearBlade requested memory"
  type = string
  default = "1G"
}

variable "clearblade_limit_cpu" {
  description = "ClearBlade CPU limit"
  type = number
  default = 1
}

variable "clearblade_limit_memory" {
  description = "ClearBlade memory limit"
  type = string
  default = "1G"
}

