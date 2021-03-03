provider "google" {
  project = var.project_name
  region  = var.region
  zone    = var.zone
}

// provider "kubernetes" {
//   host                   = google_container_cluster.vpc_native_cluster.endpoint
//   cluster_ca_certificate = local.cluster_ca_certificate
//   token                  = data.google_client_config.default.access_token
// }