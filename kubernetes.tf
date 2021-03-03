// locals {
//   cluster_ca_certificate = base64decode(google_container_cluster.vpc_native_cluster.master_auth[0].cluster_ca_certificate)
// }

// resource "kubernetes_secret" "example" {
//   metadata {
//     name = "terraform-example"
//   }
// }
