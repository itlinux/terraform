provider "google" {
    credentials = file("CHANGE_IT_service_account.json")
    project     = "terraform-demo"
    region      = "us-central1"
}

resource "google_compute_address" "ip_address" {
  name = "my-address"
}

/*
resource "google_storage_bucket" "bucket_1" {
  name          = "terraform-demo-bucket1"
  location      = "US"
  storage_class = "STANDARD"
}
*/


resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-firewall"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  source_tags = ["http-server"]

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "default" {
    name         = "test"
    machine_type = "n1-standard-1"
    zone         = "us-central1-a"

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

    metadata_startup_script = "sudo apt-get update; sudo apt-get --assume-yes install nginx; sudo systemctl start nginx"

//    depends_on = [google_storage_bucket.bucket_1]
}
