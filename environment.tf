provider "google" {
  #export GOOGLE_APPLICATION_CREDENTIALS
  project = "data-development"
  region = "eu-west-1"
}

resource "google_container_cluster" "primary" {
  name               = "development"
  region             = "eu-west-1"
  initial_node_count = 1

  master_auth {
    username = ""
    password = ""
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      
      "https://www.googleapis.com/auth/monitoring",
    ]
    labels {
        this-is-for = "development"
    }
    tags = ["development"]
  }
}

output "client_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}
