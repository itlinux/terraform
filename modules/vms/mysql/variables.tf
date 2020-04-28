variable "machine-type" {
    type = string
}

variable "instance-name" {
    type = string
}

variable "vm-location" {
    type = map
}

variable "mysql_image" {
    type = string
}

variable "vpc-network-name" {
    type = string
}

variable "mysql-static-ip" {
    type = string
}
