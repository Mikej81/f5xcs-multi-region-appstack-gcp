resource "volterra_gcp_vpc_site" "example" {
  name      = "acmecorp-web"
  namespace = "staging"

  // One of the arguments from this list "cloud_credentials assisted" must be set

  cloud_credentials {
    name      = "test1"
    namespace = "staging"
    tenant    = "acmecorp"
  }
  gcp_region    = ["us-west1"]
  instance_type = ["n1-standard-4"]

  // One of the arguments from this list "log_receiver logs_streaming_disabled" must be set

  log_receiver {
    name      = "test1"
    namespace = "staging"
    tenant    = "acmecorp"
  }

  // One of the arguments from this list "ingress_gw ingress_egress_gw voltstack_cluster" must be set

  ingress_gw {
    gcp_certified_hw = "gcp-byol-voltmesh"

    gcp_zone_names = ["us-west1-a, us-west1-b, us-west1-c"]

    local_network {
      // One of the arguments from this list "new_network_autogenerate new_network existing_network" must be set

      new_network_autogenerate {
        autogenerate = true
      }
    }

    local_subnet {
      // One of the arguments from this list "new_subnet existing_subnet" must be set

      new_subnet {
        primary_ipv4 = "10.1.0.0/16"
        subnet_name  = "subnet1-in-network1"
      }
    }

    node_number = "node_number"
  }
}
