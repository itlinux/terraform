provider "google" {
    credentials = file(var.my_gcp["sa_json"])
    project     = var.my_gcp["project"]
    region      = "us-central1"
}


resource "google_container_cluster" "primary" {
  name               = "my-first-cluster-1"
  location           = "us-central1-a"
  initial_node_count = 3

  network = "projects/shashi-gcp-1/global/networks/default"
  subnetwork = "projects/shashi-gcp-1/regions/us-central1/subnetworks/default"

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
        machine_type = "g1-small"
        disk_size_gb = 32
        image_type = "COS"
        disk_type = "pd-standard"

        oauth_scopes = [
            "https://www.googleapis.com/auth/devstorage.read_only",
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring",
            "https://www.googleapis.com/auth/servicecontrol",
            "https://www.googleapis.com/auth/service.management.readonly",
            "https://www.googleapis.com/auth/trace.append"
        ]

        metadata = {
            disable-legacy-endpoints = "true"
        }

        labels = {
            foo = "bar"
        }

        tags = ["foo", "bar"]
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}