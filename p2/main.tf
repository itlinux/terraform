provider "google" {
    credentials = file("CHANGE_IT_service_account.json")
    project     = "terraform-demo"
    region      = var.vm-location["region"]
}

locals {
    owner_name = "Central DevOps"
    vm_type_name = "NGINX"
}

locals {
    comman_tags = {
        Owner = local.owner_name
        Type = local.vm_type_name
    }
}

resource "google_compute_address" "ip_address" {
  name = "my-address"
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-firewall"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.firewall-ports
  }

  source_tags = ["http-server"]

  source_ranges = var.firewall-cidrs
}

resource "google_compute_instance" "default" {
    name         = "test-default"
    machine_type = "n1-standard-1"
    zone         = var.vm-location["zone"]

    boot_disk {
        initialize_params {
            image = var.mysql_image
        }
    }

    tags = ["http-server"]

    network_interface {
        network = "default"
        access_config {
            nat_ip = google_compute_address.ip_address.address
            }
    }

    metadata = local.comman_tags
}

output "ip-address" {
    value = google_compute_address.ip_address.address
    sensitive = true
}