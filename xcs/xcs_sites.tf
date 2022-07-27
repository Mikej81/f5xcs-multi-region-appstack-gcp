data google_compute_zones available {
  count  = length(var.gcp_regions)
  region = var.gcp_regions[count.index]
}

resource "volterra_gcp_vpc_site" "sites" {
  count     = length(var.gcp_regions)
  name      = format("%s-vpc-site-%02d", var.name, count.index)
  namespace = "system"

  labels = {
    (var.name) = true
  }

  cloud_credentials {
    name      = volterra_cloud_credentials.gcp_cc.name
    namespace = "system"
  }

  gcp_region    = var.gcp_regions[count.index]
  instance_type = var.instance_type
  ssh_key       = var.sshPublicKey

  logs_streaming_disabled = true

  voltstack_cluster {
    gcp_certified_hw = "gcp-byol-voltstack-combo"

    gcp_zone_names = data.google_compute_zones.available[count.index].names

    node_number = "3"

    site_local_network {
      new_network_autogenerate {
        autogenerate = true
      }
    }
    site_local_subnet {
      new_subnet {
        subnet_name  = format("%s-subnet-%02d", var.name, count.index)
        primary_ipv4 = var.gcp_cidrs[count.index]
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

resource "volterra_tf_params_action" "actions" {
  count           = length(var.gcp_regions)
  site_name       = volterra_gcp_vpc_site.sites[count.index].name
  site_kind       = "gcp_vpc_site"
  action          = var.xcs_tf_action
  wait_for_action = true
}
