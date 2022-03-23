resource "volterra_gcp_vpc_site" "site3" {
  name      = ""
  namespace = "system"

  cloud_credentials {
    name      = "test1"
    namespace = "system"
  }

  gcp_region    = ["us-west1"]
  instance_type = ["n1-standard-4"]
  ssh_key       = ""

  logs_streaming_disabled = true

  voltstack_cluster {
    gcp_certified_hw = "gcp-byol-voltmesh"

    gcp_zone_names = ["us-west1-a, us-west1-b, us-west1-c"]

    node_number = "3"

    site_local_network {
      new_network_autogenerate {
        autogenerate = true
      }
    }
    site_local_subnet {
      new_subnet {
        subnet_name  = "subnet"
        primary_ipv4 = "1.1.1.0/24"
      }
    }

    global_network_list {
      global_vn {

      }
    }

    no_network_policy        = true
    no_forward_proxy         = true
    no_outside_static_routes = true
    no_k8s_cluster           = true
    default_storage          = ""
  }

}
