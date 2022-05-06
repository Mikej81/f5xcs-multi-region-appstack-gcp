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
  use_default_cluster_role_bindings = false
  use_default_cluster_roles         = false
  use_custom_cluster_role_list {
    cluster_roles {
      tenant    = var.tenant
      namespace = "system"
      name      = "admin"
    }
    cluster_roles {
      tenant    = "ves-io"
      namespace = "system"
      name      = "ves-io-psp-permissive"
    }
    cluster_roles {
      tenant    = "ves-io"
      namespace = "system"
      name      = "ves-io-admin-cluster-role"
    }
    cluster_roles {
      tenant    = var.tenant
      namespace = "system"
      name      = var.name2
    }
  }
  use_custom_cluster_role_bindings {
    cluster_role_bindings {
      tenant    = var.tenant
      namespace = "system"
      name      = "admin"
    }
    cluster_role_bindings {
      tenant    = var.tenant
      namespace = "system"
      name      = "ves-io-admin-cluster-role-binding"
    }
    cluster_role_bindings {
      tenant    = "ves-io"
      namespace = "shared"
      name      = "ves-io-psp-permissive"
    }
    cluster_role_bindings {
      tenant    = var.tenant
      namespace = "system"
      name      = var.name2
    }
  }


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
###create cluster role ###
resource "volterra_k8s_cluster_role" "role" {
  name      = var.name2
  namespace = "system"

  // One of the arguments from this list "policy_rule_list k8s_cluster_role_selector yaml" must be set

  policy_rule_list {
    policy_rule {
      // One of the arguments from this list "resource_list non_resource_url_list" must be set
      resource_list {

        verbs = ["*"]

        api_groups = ["*"]

        resource_types = ["*"]

        resource_instances = ["*"]
      }
      # non_resource_url_list {
      #   urls = ["*"]

      #   verbs = ["*"]
      # }
    }
  }
}
###create cluster role binding###
resource "volterra_k8s_cluster_role_binding" "bind" {
  name      = var.name2
  namespace = "system"

  k8s_cluster_role {
    name      = "ves-io-admin-cluster-role"
    namespace = "shared"
    tenant    = "ves-io"
  }

  subjects {
    // One of the arguments from this list "user service_account group" must be set
    user = "s.iannetta@f5.com"
  }
}

resource "volterra_virtual_site" "vsite" {
  name      = format("%s-k8s-vsite", var.name)
  namespace = "shared"

  site_selector {
    expressions = ["${var.name} in (true)"]
  }

  site_type = "CUSTOMER_EDGE"
}

## Coleman added / edited for Agility
# resource "volterra_namespace" "namespace" {
#   count = var.agility_namespaces
#   name  = "3${format("%02d", count.index)}"

# }

# resource "volterra_virtual_k8s" "vk8s" {
#   count     = var.agility_namespaces
#   name      = format("%s-vk8s-3${format("%02d", count.index)}", var.name)
#   namespace = "3${format("%02d", count.index)}"

#   vsite_refs {
#     name      = volterra_virtual_site.vsite.name
#     namespace = "shared"
#   }
# }
# ## End Coleman Added / Edited


resource "volterra_virtual_k8s" "vk8s" {
  name = format("%s-vk8s", var.name)
  # namespace = var.namespace
  namespace = "s-iannetta"
  vsite_refs {
    name      = volterra_virtual_site.vsite.name
    namespace = "shared"
  }
}