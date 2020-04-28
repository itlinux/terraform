provider "google" {
    credentials = file(var.gcp-terraform["sa_json"])
    project     = var.gcp-terraform["project"]
    region      = "us-central1"
}

resource "google_compute_instance" "default" {
    for_each = {
        k1 = "dev"
        k2 = "qa"
    }

    name         = "foreach-test-${each.value}"
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
