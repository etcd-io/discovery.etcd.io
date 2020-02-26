variable "project" {
  description = "The project ID to host the cluster in (required)"
  type = string
}

variable environment {
  description = "The environment for <development|production> workloads."
  type = string
}

variable "location" {
  description = "The location (region or zone) of the GKE cluster."
  type        = string
}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
}

variable "gke_master_authorized_networks" {
  description = "The networks from which a connection to the master can be established"
  type        = list(map(string))
}

variable "network_prefix" {
  description = "A network segment prefix in the VPC network to host the cluster in"
  type        = string
}

variable "master_ipv4_cidr_block" {
  type = string
  description = "The IP range in CIDR notation (size must be /28) to use for the hosted master network."
  default = "172.31.0.0/28"
}

variable "min_master_version" {
  type        = string
  description = "The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region."
  default     = "latest"
}