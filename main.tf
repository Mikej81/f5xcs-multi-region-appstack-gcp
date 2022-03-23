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
# module "xcs" {
#   source = "./xcs"

#   name                  = var.name
#   namespace             = var.namespace
#   resource_group_name   = "${module.util.env_prefix}_xcs_rg"
#   fleet_label           = var.fleet_label
#   url                   = var.api_url
#   api_p12_file          = var.api_p12_file
#   region                = var.region
#   location              = var.location
#   projectPrefix         = module.util.env_prefix
#   sshPublicKeyPath      = var.sshPublicKeyPath
#   sshPublicKey          = var.sshPublicKey
#   volterra_tenant       = var.tenant_name
#   gateway_type          = var.gateway_type
#   volterra_tf_action    = var.volterra_tf_action
#   tags                  = var.tags
# }
