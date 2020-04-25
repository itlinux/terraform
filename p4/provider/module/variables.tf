variable "environment" {
    type = string
}

variable "vm-location" {
    type = map
    default = {
        "region" = "us-central1"
        "zone" = "us-central1-b"
    }
}

variable "instance-name" {
    type = string
    default = "my-project-mysql"
}

variable "machine-type" {
    type = string
    default = "n1-standard-1"
}
variable "mysql_image" {
    type = string
    default = "projects/terraform-demo-skd1/global/images/mysql-57"
}

variable "vpc-network-name" {
    type = string
    default = "default"
}