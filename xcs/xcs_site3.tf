resource "volterra_gcp_vpc_site" "site3" {
  name      = format("%s-vpc-site-three", var.name)
  namespace = "system"

  labels = {
    (var.name) = true
  }

  cloud_credentials {
    name      = volterra_cloud_credentials.gcp_cc.name
    namespace = "system"
  }

  gcp_region    = var.region_three
  instance_type = var.instance_type
  ssh_key       = var.sshPublicKey

  logs_streaming_disabled = true

  voltstack_cluster {
    gcp_certified_hw = "gcp-byol-voltstack-combo"

    gcp_zone_names = [var.zone_three]

    node_number = "3"

    site_local_network {
      new_network_autogenerate {
        autogenerate = true
      }
    }
    site_local_subnet {
      new_subnet {
        subnet_name  = format("%s-subnet-three", var.name)
        primary_ipv4 = var.cidr_three
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

resource "volterra_tf_params_action" "action3" {
  site_name       = volterra_gcp_vpc_site.site3.name
  site_kind       = "gcp_vpc_site"
  action          = var.xcs_tf_action
  wait_for_action = true
}
