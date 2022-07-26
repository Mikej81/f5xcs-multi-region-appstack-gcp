variable "name" {}
variable "namespace" {}
variable "projectName" {}
variable "projectPrefix" {}
variable "url" {}
variable "api_p12_file" {}
variable "gcp_region_one" {}
variable "gcp_zone_one_a" {}
variable "gcp_zone_one_b" {}
variable "gcp_zone_one_c" {}
variable "gcp_region_two" {}
variable "gcp_zone_two_a" {}
variable "gcp_zone_two_b" {}
variable "gcp_zone_two_c" {}
variable "gcp_region_three" {}
variable "gcp_zone_three_a" {}
variable "gcp_zone_three_b" {}
variable "gcp_zone_three_c" {}
variable "gateway_type" {}
variable "xcs_tf_action" {}
variable "tags" {}
variable "sshPublicKey" {}
variable "sshPublicKeyPath" {}
variable "xcs_tenant" {}
variable "instance_type" {}
variable "gcp_cidr_one" {}
variable "gcp_cidr_two" {}
variable "gcp_cidr_three" {}
variable "tenant" {}
variable "stack_name" {}
variable "gcp_cidrs" {
    type = list(string)
}
variable "gcp_regions"{
    type = list(string)
}


