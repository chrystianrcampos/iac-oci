terraform {
  required_version = ">= 1.4.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 6.35.0"
    }
  }

  backend "local" {}
}

provider "oci" {
  tenancy_ocid          = var.tenancy_ocid
  user_ocid             = var.user_ocid
  fingerprint           = var.fingerprint
  private_key_path      = var.private_key_path
  private_key_password  = var.private_key_password
  region                = "sa-saopaulo-1"
}