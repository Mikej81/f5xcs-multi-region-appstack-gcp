resource "volterra_gcp_vpc_site" "site1" {
  name      = format("%s-vpc-site-one", var.name)
  namespace = "system"

  labels = {
    (var.name) = true
  }

  cloud_credentials {
    name      = volterra_cloud_credentials.gcp_cc.name
    namespace = "system"
  }

  gcp_region    = var.region_one
  instance_type = var.instance_type
  ssh_key       = var.sshPublicKey

  logs_streaming_disabled = true

  voltstack_cluster {
    gcp_certified_hw = "gcp-byol-voltstack-combo"

    gcp_zone_names = [var.zone_one_a, var.zone_one_b, var.zone_one_c]
    # gcp_zone_names = ["us-west1-a, us-west1-b, us-west1-c"]

    node_number = "3"

    site_local_network {
      new_network_autogenerate {
        autogenerate = true
      }
    }
    site_local_subnet {
      new_subnet {
        subnet_name  = format("%s-subnet-one", var.name)
        primary_ipv4 = var.cidr_one
      }
    }

    global_network_list {
      global_network_connections {
        slo_to_global_dr {
          global_vn {
            namespace = "system"
            name      = volterra_virtual_network.global.name
          }
        }
      }

    }

    no_network_policy        = true
    no_forward_proxy         = true
    no_outside_static_routes = true
    #no_k8s_cluster           = true
    #default_storage          = ""
    k8s_cluster {
      namespace = "system"
      name      = volterra_k8s_cluster.cluster.name
    }
  }

}

resource "volterra_tf_params_action" "action1" {
  site_name       = volterra_gcp_vpc_site.site1.name
  site_kind       = "gcp_vpc_site"
  action          = var.xcs_tf_action
  wait_for_action = true
}
