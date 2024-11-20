variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "namespace_name" {
  description = "Name of the Client"
  type        = string
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
  default = "https://github.com/ClearBlade/helm-charts/releases/download/clearblade-iot-enterprise-2.14.2/clearblade-iot-enterprise-2.14.2.tgz"
}

variable "helm_values_file" {
  description = "location of the heml values file"
  type = string
  sensitive = true
}

variable "service_account_access_token" {
  description = "svc account access token"
  type = string
  sensitive = true
}

