variable environment {
  description = "The environment for <development|production> workloads"
  type = "string"
}

variable "gcp" {
  description = "Map of Google Cloud Platform specific variables"
  type = "map"
}

variable "gke" {
  description = "Map of Google Kubernetes Engine specific variables."
  type = "map"
}

variable "gke_nodepools" {
  type        = list(map(string))
  description = "List of maps containing node pools"
}