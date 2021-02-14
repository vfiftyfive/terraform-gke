variable "project_name" {}
variable "vpc_network_name" {}
variable "subnet_name" {}
variable "region" {}
variable "node_cidr" {}
variable "sa" {}
variable "zone" {}
variable "cluster_name" {}
variable "master_cidr" {}

resource "google_container_cluster" "vpc_native_cluster" {
  name               = var.cluster_name
  location           = var.zone
  initial_node_count = 2

  network    = google_compute_network.gke_vpc.name
  subnetwork = google_compute_subnetwork.node_subnet.name

  node_config {
    preemptible     = true
    machine_type    = "e2-medium"
    service_account = data.google_service_account.gke_sa.email
  }

  private_cluster_config {
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_cidr
    enable_private_endpoint = "false"
    master_global_access_config {
      enabled = "true"
    }
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/16"
    services_ipv4_cidr_block = "/22"
  }
  
}

resource "google_compute_network" "gke_vpc" {
  name                    = var.vpc_network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "node_subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.node_cidr
  region        = var.region
  network       = google_compute_network.gke_vpc.id
}

data "google_service_account" "gke_sa" {
  account_id = var.sa
}

