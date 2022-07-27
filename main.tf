# main.tf

# Util Module
# - Random Prefix Generation
# - Random Password Generation
module "util" {
  source = "./util"
}


# Volterra Module
# Build Site Token and Cloud Credential
# Build out GCP Site
module "xcs" {
      source             = "./xcs"
      gcp_regions        = [var.gcp_region_one, var.gcp_region_two, var.gcp_region_three]
      gcp_cidrs          = [var.gcp_cidr_one, var.gcp_cidr_two, var.gcp_cidr_three]
      name               = var.name
      namespace          = var.namespace
      stack_name         = var.stack_name
      projectName        = var.projectName
      url                = var.api_url
      api_p12_file       = var.api_p12_file
      tenant             = var.tenant
      projectPrefix      = module.util.env_prefix
      sshPublicKeyPath   = var.sshPublicKeyPath
      sshPublicKey       = var.sshPublicKey
      xcs_tenant         = var.tenant_name
      gateway_type       = var.gateway_type
      xcs_tf_action      = var.xcs_tf_action
      instance_type      = var.instance_type

      tags               = var.tags
    # agility_namespaces = var.agility_namespaces
}
