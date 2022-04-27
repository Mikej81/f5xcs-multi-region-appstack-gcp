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
  source = "./xcs"

  name      = var.name
  name2     = var.name2
  namespace = var.namespace
  stack_name         = var.stack_name
  projectName        = var.projectName
  url                = var.api_url
  api_p12_file       = var.api_p12_file
  tenant             = var.tenant
  region_one         = var.region_one
  zone_one_a         = var.zone_one_a
  zone_one_b         = var.zone_one_b
  zone_one_c         = var.zone_one_c
  region_two         = var.region_two
  zone_two_a         = var.zone_two_a
  zone_two_b         = var.zone_two_b
  zone_two_c         = var.zone_two_c
  region_three       = var.region_three
  zone_three_a       = var.zone_three_a
  zone_three_b       = var.zone_three_b
  zone_three_c       = var.zone_three_c
  projectPrefix      = module.util.env_prefix
  sshPublicKeyPath   = var.sshPublicKeyPath
  sshPublicKey       = var.sshPublicKey
  xcs_tenant         = var.tenant_name
  gateway_type       = var.gateway_type
  xcs_tf_action      = var.xcs_tf_action
  instance_type      = var.instance_type
  cidr_one           = var.cidr_one
  cidr_two           = var.cidr_two
  cidr_three         = var.cidr_three
  tags               = var.tags
  agility_namespaces = var.agility_namespaces

}
