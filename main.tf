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

  name             = var.name
  namespace        = var.namespace
  projectName      = var.projectName
  url              = var.api_url
  api_p12_file     = var.api_p12_file
  gcp_region_one   = var.gcp_region_one
  gcp_zone_one_a   = var.gcp_zone_one_a
  gcp_zone_one_b   = var.gcp_zone_one_b
  gcp_zone_one_c   = var.gcp_zone_one_c
  gcp_region_two   = var.gcp_region_two
  gcp_zone_two_a   = var.gcp_zone_two_a
  gcp_zone_two_b   = var.gcp_zone_two_b
  gcp_zone_two_c   = var.gcp_zone_two_c
  gcp_region_three = var.gcp_region_three
  gcp_zone_three_a = var.gcp_zone_three_a
  gcp_zone_three_b = var.gcp_zone_three_b
  gcp_zone_three_c = var.gcp_zone_three_c
  projectPrefix    = module.util.env_prefix
  sshPublicKeyPath = var.sshPublicKeyPath
  sshPublicKey     = var.sshPublicKey
  xcs_tenant       = var.tenant_name
  gateway_type     = var.gateway_type
  xcs_tf_action    = var.xcs_tf_action
  instance_type    = var.instance_type
  cidr_one         = var.cidr_one
  cidr_two         = var.cidr_two
  cidr_three       = var.cidr_three
  tags             = var.tags
  cluster_size     = var.cluster_size
  # agility_namespaces = var.agility_namespaces
}
