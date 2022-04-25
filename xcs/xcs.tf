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

resource "volterra_virtual_k8s" "vk8s" {
  name      = format("%s-vk8s", var.name)
  namespace = var.namespace
  # namespace = "default"
  vsite_refs {
    name      = volterra_virtual_site.vsite.name
    namespace = "shared"
  }
}

# resource "volterra_voltstack_site" "netta-gcp-mz-stack" {
#   name      = var.stack_name
#   namespace = "system"

#   // One of the arguments from this list "no_bond_devices bond_device_list" must be set
#   no_bond_devices = true

#   // One of the arguments from this list "disable_gpu enable_gpu enable_vgpu" must be set
#   disable_gpu = true

#   // One of the arguments from this list "no_k8s_cluster k8s_cluster" must be set
#   # no_k8s_cluster = true
#   k8s_cluster {
#     tenant    = "f5-amer-ent-qyyfhhfj"
#     namespace = "system"
#     name      = "netta-k8s-cluster"
#   }

#   // One of the arguments from this list "logs_streaming_disabled log_receiver" must be set
#   logs_streaming_disabled = true

#   master_nodes = ["master-0", "master-1", "master-2"]

#   // One of the arguments from this list "custom_network_config default_network_config" must be set
#   default_network_config = true

#   // One of the arguments from this list "default_storage_config custom_storage_config" must be set
#   default_storage_config = true

#   // One of the arguments from this list "deny_all_usb allow_all_usb usb_policy" must be set
#   deny_all_usb          = true
#   volterra_certified_hw = "generic-single-nic-voltstack-combo"
# }