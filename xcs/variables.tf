variable "name" {}
variable "namespace" {}
variable "projectName" {}
variable "projectPrefix" {}
variable "url" {}
variable "api_p12_file" {}
variable "gateway_type" {}
variable "xcs_tf_action" {}
variable "tags" {}
variable "sshPublicKey" {}
variable "sshPublicKeyPath" {}
variable "xcs_tenant" {}
variable "instance_type" {}
variable "tenant" {}
variable "stack_name" {}
variable "gcp_cidrs" {
    type = list(string)
}
variable "gcp_regions"{
    type = list(string)
}


