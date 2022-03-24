terraform {
  required_version = ">= 0.13.0"
  required_providers {
    google = {
      version = "4.15.0"
    }
  }
}

module "service_accounts" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "~> 3.0"
  project_id = var.projectName
  prefix     = var.name
  names      = ["first", "second"]

}

output "service_account_key" {
  value = service_accounts.key
}
