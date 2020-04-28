provider "google" {
    credentials = file(var.gcp-terraform["sa_json"])
    project     = var.gcp-terraform["project"]
    region      = "us-central1"
}

resource "google_sql_database_instance" "postgres" {
  name             = "postgres-master"
  database_version = "POSTGRES_11"
  region           = "us-central1"

    settings {
        tier = "db-f1-micro"
        ip_configuration {
            dynamic "authorized_networks" {
                for_each = google_compute_instance.apps
                iterator = apps

                content {
                    name = apps.value.name
                    value = apps.value.network_interface.0.access_config.0.nat_ip
                    expiration_time= "2025-12-31T23:59:60Z" 
                }
            }
        }
    }
}


resource "google_compute_instance" "apps" {

    count = 4

    name         = "count-test-${count.index+1}"
    machine_type = "n1-standard-1"
    zone         = "us-central1-a"

    boot_disk {
        initialize_params {
        image = data.google_compute_image.ubuntu-image.self_link
        }
    }

    network_interface {
        network = "default"
        access_config {
            }
    }
}

data "google_compute_image" "ubuntu-image" {
  family  = "ubuntu-1804-lts"
  project = "ubuntu-os-cloud"
}