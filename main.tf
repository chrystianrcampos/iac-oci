terraform {
  required_version = ">= 1.4.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 6.35.0"
    }
  }

  backend "s3" {
    bucket                      = var.r2_bucket
    key                         = var.r2_key
    region                      = "auto"
    endpoint                    = var.r2_endpoint
    access_key                  = var.r2_access_key
    secret_key                  = var.r2_secret_key
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    use_path_style              = true
  }
}

provider "oci" {
  tenancy_ocid          = var.tenancy_ocid
  user_ocid             = var.user_ocid
  fingerprint           = var.fingerprint
  private_key_path      = var.private_key_path
  private_key_password  = var.private_key_password
  region                = "sa-saopaulo-1"
}