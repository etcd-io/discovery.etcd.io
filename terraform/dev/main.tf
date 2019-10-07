provider "google" {
  version = "~> 2.16.0"
  project     = var.gcp["project"]
  region      = var.gcp["region"]
}

provider "google-beta" {
  project     = var.gcp["project"]
  region      = var.gcp["region"]
}

terraform {
  backend "gcs" {
    bucket  = "etcd-io-dev-infrastructure"
    prefix  = "terraform/terraform.state"
  }
}

module "gke" {
  source = "git::git@github.com:cloudkite-io/terraform-modules.git//modules/gke?ref=v0.0.1"
  environment = var.environment
  gcp = var.gcp
  gke = var.gke
  gke_nodepools = var.gke_nodepools
  gke_pods_secondary_range_name = module.vpc.gke_subnetwork_secondary_range_name_services
  gke_service_account = module.gke_service_account.email
  gke_services_secondary_range_name = module.vpc.gke_subnetwork_secondary_range_name_pods
  network = module.vpc.network
  subnetwork = module.vpc.gke_subnetwork
}

module "vpc" {
  source = "git::git@github.com:cloudkite-io/terraform-modules.git//modules/network/vpc?ref=v0.0.1"
  environment = var.environment
  network-prefix = var.gcp["network_prefix"]
  project = var.gcp["project"]
  region = var.gcp["region"]
  master_ipv4_cidr_block = var.gke["master_ipv4_cidr_block"]
}

module "gke_service_account" {
  source = "git::git@github.com:cloudkite-io/terraform-modules.git//modules/gke-service-account?ref=v0.0.1"
  name = "${module.gke.name}-sa"
  project = var.gcp["project"]
}