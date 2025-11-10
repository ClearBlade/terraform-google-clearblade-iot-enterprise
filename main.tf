terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.12.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.16.1"
    }
    clearblade-google = {
      source = "ClearBlade/clearblade-google"
      version = "0.2.28"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.0.0-alpha1"
    }
  }
}

provider "google" {
  project         = var.project_id
  access_token    = var.service_account_access_token
  zone            = var.region
}

provider "clearblade-google" {
  project         = var.project_id
  access_token    = var.service_account_access_token
}

provider "helm" {
  kubernetes = {
    host                   = "https://${data.google_container_cluster.primary.endpoint}"
    cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
    token = data.google_client_config.provider.access_token
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
