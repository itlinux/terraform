variable "vm-location" {
    type = map
    default = {
        "region" = "us-central1"
        "zone" = "us-central1-a"
    }
}

variable "firewall-ports" {
    type = list(string)
    default = ["80","8080"]
}

variable "firewall-cidrs" {
    type = list(string)
    default = ["0.0.0.0/0"]
}

variable "mysql_image" {
    type = string
    default = "projects/terraform-demo/global/images/mysql-57"
}