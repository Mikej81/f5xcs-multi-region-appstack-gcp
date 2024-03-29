# Environment
// Required Variable
variable "adminUserName" {
  type        = string
  description = "REQUIRED: Admin Username for All systems"
  default     = "xadmin"
}

// Required Variable
variable "projectName" {
  type        = string
  description = "REQUIRED: GCP project: "
  default     = "project-name"
}
variable "tenant" {
  type        = string
  description = "REQUIRED: GCP project: "
  default     = "xc tenant id"
}
variable "stack_name" {
  type        = string
  description = "REQUIRED: GCP project: "
  default     = "gcp-app-stack"
}

variable "cluster_size" {
  type        = string
  description = "REQUIRED: Sets Cluster size to single node or 3 node; use 1 or 3."
  default     = "1"
}

// Required Variable
variable "gcp_region_one" {
  type        = string
  description = "REQUIRED: GCP Region: "
  default     = "us-east4"
}
variable "gcp_zone_one_a" {
  type        = string
  description = "REQUIRED: GCP Region: "
  default     = "us-east4-a"
}
variable "gcp_zone_one_b" {
  type        = string
  description = "REQUIRED: GCP Region: "
  default     = "us-east4-b"
}
variable "gcp_zone_one_c" {
  type        = string
  description = "REQUIRED: GCP Region: "
  default     = "us-east4-c"
}
variable "gcp_region_two" {
  type        = string
  description = "REQUIRED: GCP Region: "
  default     = "us-west2"
}
variable "gcp_zone_two_a" {
  type        = string
  description = "REQUIRED: GCP Region: "
  default     = "us-west2-a"
}
variable "gcp_zone_two_b" {
  type        = string
  description = "REQUIRED: GCP Region: "
  default     = "us-west2-b"
}
variable "gcp_zone_two_c" {
  type        = string
  description = "REQUIRED: GCP Region: "
  default     = "us-west2-c"
}
variable "gcp_region_three" {
  type        = string
  description = "REQUIRED: GCP Region: "
  default     = "europe-west3"
}
variable "gcp_zone_three_a" {
  type        = string
  description = "REQUIRED: GCP Region: "
  default     = "europe-west3-a"
}
variable "gcp_zone_three_b" {
  type        = string
  description = "REQUIRED: GCP Region: "
  default     = "europe-west3-b"
}
variable "gcp_zone_three_c" {
  type        = string
  description = "REQUIRED: GCP Region: "
  default     = "europe-west3-c"
}
variable "instance_type" {
  type        = string
  description = "REQUIRED: Instance Type"
  default     = "n1-standard-4"
  #default = "n1-standard-8"
}

variable "sshPublicKey" {
  type        = string
  description = "OPTIONAL: ssh public key for instances"
  default     = ""
}
variable "sshPublicKeyPath" {
  type        = string
  description = "OPTIONAL: ssh public key path for instances"
  default     = "~/.ssh/id_rsa.pub"
}
// Required Variable
variable "api_p12_file" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api-creds.p12"
}

variable "api_cert" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api2.cer"
}
variable "api_key" {
  type        = string
  description = "REQUIRED:  This is the path to the volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api.key"
}
// Required Variable
variable "tenant_name" {
  type        = string
  description = "REQUIRED:  This is your volterra Tenant Name:  https://<tenant_name>.console.ves.volterra.io/api"
  default     = "mr-customer"
}
// Required Variable
variable "namespace" {
  type        = string
  description = "REQUIRED:  This is your volterra App Namespace"
  default     = "namespace"
}
// Required Variable
variable "name" {
  type        = string
  description = "REQUIRED:  This is name for your deployment"
  default     = "cust-provided"
}

// Required Variable
variable "xcs_tf_action" {
  default = "plan"
}
variable "delegated_dns_domain" {
  default = "testdomain.com"
}
// Required Variable
variable "api_url" {
  type        = string
  description = "REQUIRED:  This is your volterra API url"
  default     = "https://playground.console.ves.volterra.io/api"
}

variable "gateway_type" { default = "voltstack_cluster" }

# NETWORK
// Required Variable
variable "cidr_one" {
  description = "REQUIRED: VNET Network CIDR"
  default     = "10.90.0.0/23"
}
variable "cidr_two" {
  description = "REQUIRED: VNET Network CIDR"
  default     = "10.90.2.0/23"
}
variable "cidr_three" {
  description = "REQUIRED: VNET Network CIDR"
  default     = "10.90.4.0/23"
}

variable "gcp_subnet_one" {
  type        = map(string)
  description = "REQUIRED: Subnet CIDRs"
  default = {
    "external" = "10.90.0.0/24"
  }
}
variable "gcp_subnet_two" {
  type        = map(string)
  description = "REQUIRED: Subnet CIDRs"
  default = {
    "external" = "10.90.2.0/24"
  }
}
variable "gcp_subnet_three" {
  type        = map(string)
  description = "REQUIRED: Subnet CIDRs"
  default = {
    "external" = "10.90.4.0/24"
  }
}

# TAGS
variable "tags" {
  description = "Environment tags for objects"
  type        = map(string)
  default = {
    purpose     = "public"
    environment = "gcp"
    owner       = "f5owner"
    group       = "f5group"
    costcenter  = "f5costcenter"
    application = "f5app"
    creator     = "Terraform"
    delete      = "True"
  }
}

#Coleman Added for Agility

variable "agility_namespaces" {
  type    = number
  default = 50
}
