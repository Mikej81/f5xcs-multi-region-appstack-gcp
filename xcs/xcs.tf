terraform {
  required_version = ">= 0.12"
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = "0.11.6"
    }
  }
}

resource "volterra_cloud_credentials" "gcp_cc" {
  name      = format("%s-gcp-credentials", var.name)
  namespace = "system"

  gcp_cred_file {
    credential_file {
      clear_secret_info {
        url = format("string:///%s", base64encode(file("${path.module}/../key.json")))
      }
    }

  }

}

resource "volterra_virtual_network" "global" {
  name      = format("%s-global-network", var.name)
  namespace = "system"

  global_network = true
}

resource "volterra_network_connector" "direct" {
  name      = format("%s-global-direct-cloud", var.name)
  namespace = "system"

  description = "Global Network Connector for Cloud Site."

  slo_to_global_dr {
    global_vn {
      name      = volterra_virtual_network.global.name
      namespace = "system"
    }

  }

  disable_forward_proxy = true
}

resource "volterra_k8s_cluster" "cluster" {
  name      = format("%s-k8s-cluster", var.name)
  namespace = "system"

  no_cluster_wide_apps              = true
  use_default_cluster_role_bindings = true
  use_default_cluster_roles         = true

  // One of the arguments from this list "cluster_scoped_access_permit cluster_scoped_access_deny" must be set
  cluster_scoped_access_permit = true
  global_access_enable         = true
  no_insecure_registries       = true

  local_access_config {
    local_domain = format("%s.local", var.name)
    default_port = true
  }
  use_default_psp = true
}

resource "volterra_virtual_site" "vsite" {
  name      = format("%s-k8s-vsite", var.name)
  namespace = "shared"

  site_selector {
    expressions = ["${var.name} in (true)"]
  }

  site_type = "CUSTOMER_EDGE"
}

resource "volterra_virtual_k8s" "vk8s" {
  name = format("%s-vk8s", var.name)
  namespace = var.namespace
  # namespace = "default"
  vsite_refs {
    name      = volterra_virtual_site.vsite.name
    namespace = "shared"
  }
}
