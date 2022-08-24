provider "google" {
  project     = var.project
  region      = var.region
}

provider "google-beta" {
  project     = var.project
  region      = var.region
}

terraform {
  required_providers {
    google = {
      version = "~> 4.32.0"
    }
    google-beta = {
      version = "~> 4.32.0"
    }
  }
}

terraform {
  backend "gcs" {
    bucket  = "etcd-io-dev-infrastructure"
    prefix  = "terraform/terraform.state"
  }
}

module "gke" {
  source = "git::git@github.com:cloudkite-io/terraform-modules.git//modules/gcp/gke?ref=v0.1.3"
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

  gke_nodepools = {
    #Scaling down dev cluster to 0 while not needed
    dev-gke-pool-0 = {
      auto_repair = true
      auto_upgrade = false
      min_node_count = 1
      max_node_count = 10
      max_pods_per_node = 110
      machine_type = "n1-standard-2"
      disk_size_gb = "50"
      disk_type = "pd-standard"
      preemptible = false
      version = var.min_master_version
      labels = {}
    } ,
  }
}

module "vpc" {
  source = "git::git@github.com:cloudkite-io/terraform-modules.git//modules/gcp/vpc?ref=v0.1.3"
  environment = var.environment
  network-prefix = var.network_prefix
  project = var.project
  region = var.region
}

module "velero" {
  source = "git::git@github.com:cloudkite-io/terraform-modules.git//modules/gcp/velero?ref=v0.1.3"

  backups_bucket_location = "US"
  backups_bucket_name = "${var.project}-backups"
  project = var.project
  service_account_name = "${module.gke.name}-velero-sa"
  backup_project          = var.project
}
