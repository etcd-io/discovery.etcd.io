environment = "dev"

gcp = {
  project = "etcd-io-dev"
  region = "us-central1"
  network_prefix = "10.128"
}

gke = {
  location = "us-central1"
  min_master_version = "1.14.3-gke.11"
  master_ipv4_cidr_block = "172.31.0.0/28"
}

gke_nodepools = [
  {
    auto_repair = true
    auto_upgrade = false
    min_node_count = 1
    max_node_count = 10
    machine_type = "n1-standard-2"
    disk_size_gb = "50"
    preemptible = true
    version = "1.14.3-gke.11"
  },
]

gke_master_authorized_networks = [
  {
    display_name = "open",
    cidr_block = "0.0.0.0/0"
  }
]
