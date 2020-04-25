provider "google" {
    credentials = file("CHANGE_IT_service_account.json")
    project     = "terraform-demo-skd1"
    region      = "us-central1"
}

provider "google" {
    credentials = file("CHANGE_IT_service_account.json")
    project     = "terraform-demo-skd1"
    region      = "us-east1"
    alias       = "east"
}

resource "google_compute_address" "ip_address" {
    provider = google.east
    name = "my-address"
}

resource "google_compute_instance" "default" {
    provider = google.east

    name         = "test"
    machine_type = "n1-standard-1"
    zone         = "us-east1-b"

    boot_disk {
        initialize_params {
        image = "debian-cloud/debian-9"
        }
    }

    tags = ["http-server"]

    network_interface {
        network = "default"
        access_config {
            nat_ip = google_compute_address.ip_address.address
            }
    }
}
