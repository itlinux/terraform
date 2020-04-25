resource "google_compute_address" "ip_address" {
    name = "my-address"
}
resource "google_compute_instance" "default" {
    name         = var.instance-name
    machine_type = var.machine-type
    zone         = var.vm-location["zone"]

    boot_disk {
        initialize_params {
            image = var.mysql_image
        }
    }

    network_interface {
        network = var.vpc-network-name
        access_config {
            nat_ip = google_compute_address.ip_address.address
            }
    }

}
