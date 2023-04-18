terraform {
  required_version = ">= 0.13"
  required_providers {
    volterrarm = {
      source  = "volterraedge/volterra"
      version = "0.11.21"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.61.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
  }
}

provider "google" {
  project = var.projectName
  region  = var.gcp_region_one
}

provider "volterrarm" {
  api_p12_file = var.api_p12_file
  api_cert     = var.api_p12_file != "" ? "" : var.api_cert
  api_key      = var.api_p12_file != "" ? "" : var.api_key
  url          = var.api_url
}

provider "http" {
}
