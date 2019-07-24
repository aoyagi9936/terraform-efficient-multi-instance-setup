terraform {
  required_version = ">= 0.12.0"
}

provider "google" {
  project = "${var.project.project_id}"
  region  = "${var.project.region}"
}

# VPC
resource "google_compute_network" "private-network" {
  name                    = "${var.network.vpc_name}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private-network-subnet" {
  name          = "${var.network.vpc_subnet_name}"
  region        = "${var.network.region}"
  ip_cidr_range = "${var.network.ip_cidr_range}"
  network       = "${google_compute_network.private-network.self_link}"
}

# Comput Engine
module "module_instance" {
  source = "./modules/instance"

  inst_prop   = "${var.instances}"
  inst_nw     = "${google_compute_network.private-network.self_link}"
  inst_nw_sub = "${google_compute_subnetwork.private-network-subnet.self_link}"
}
