terraform {
  backend "gcs" {
    bucket  = "etcd-io-infrastructure"
    prefix  = "terraform/terraform.state"
  }
}

provider "google" {
  version = "~> 2.16.0"
  project     = var.gcp["project"]
  region      = var.gcp["region"]
}

provider "google-beta" {
  project     = var.gcp["project"]
  region      = var.gcp["region"]
}
