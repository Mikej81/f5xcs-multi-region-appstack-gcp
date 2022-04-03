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

  name         = var.name
  namespace    = var.namespace
  projectName  = var.projectName
  url          = var.api_url
  api_p12_file = var.api_p12_file
  region_one   = var.region_one
  zone_one_a   = var.zone_one_a
  zone_one_b   = var.zone_one_b
  zone_one_c   = var.zone_one_c
  region_two   = var.region_two
  zone_two     = var.zone_two
  # region_three     = var.region_three
  # zone_three       = var.zone_three
  projectPrefix    = module.util.env_prefix
  sshPublicKeyPath = var.sshPublicKeyPath
  sshPublicKey     = var.sshPublicKey
  xcs_tenant       = var.tenant_name
  gateway_type     = var.gateway_type
  xcs_tf_action    = var.xcs_tf_action
  instance_type    = var.instance_type
  cidr_one         = var.cidr_one
  cidr_two         = var.cidr_two
  # cidr_three       = var.cidr_three
  tags = var.tags
}
