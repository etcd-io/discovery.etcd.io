variable environment {
  description = "The environment for <development|production> workloads"
  type = "string"
}

variable "gcp" {
  description = "Map of Google Cloud Platform specific variables"
  type = "map"
}