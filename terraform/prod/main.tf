provider "google" {
  version = "~> 2.16.0"
  project     = var.project
  region      = var.region
}

provider "google-beta" {
  version     = "~> 3.73.0"
  project     = var.project
  region      = var.region
}

terraform {
  backend "gcs" {
    bucket  = "etcd-io-infrastructure"
    prefix  = "terraform/terraform.state"
  }
}

module "gke" {
  source = "git::git@github.com:cloudkite-io/terraform-modules.git//modules/gcp/gke?ref=v0.0.4"
  environment = var.environment
  gke_pods_secondary_range_name = module.vpc.gke_subnetwork_secondary_range_name_services
  gke_services_secondary_range_name = module.vpc.gke_subnetwork_secondary_range_name_pods
  gke_master_authorized_networks = var.gke_master_authorized_networks
  location = var.location
  master_ipv4_cidr_block = var.master_ipv4_cidr_block
  min_master_version = var.min_master_version
  project = var.project
  region = var.region
  subnetwork = module.vpc.gke_subnetwork

  gke_nodepools = [
    {
      auto_repair = true
      auto_upgrade = false
      min_node_count = 1
      max_node_count = 10
      machine_type = "n1-standard-2"
      disk_size_gb = "50"
      preemptible = false
      version = var.min_master_version
    }
  ]
}

module "vpc" {
  source = "git::git@github.com:cloudkite-io/terraform-modules.git//modules/gcp/vpc?ref=v0.0.4"
  environment = var.environment
  network-prefix = var.network_prefix
  project = var.project
  region = var.region
}

module "velero" {
  source = "git::git@github.com:cloudkite-io/terraform-modules.git//modules/gcp/velero?ref=v0.0.4"

  backups_bucket_location = "US"
  backups_bucket_name = "${var.project}-backups"
  project = var.project
  service_account_name = "${module.gke.name}-velero-sa"
}
