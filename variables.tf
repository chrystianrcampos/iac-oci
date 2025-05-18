variable "r2_endpoint" {
  description = "R2 endpoint"
  type        = string
}

variable "r2_access_key" {
  description = "R2 access key"
  type        = string
}

variable "r2_secret_key" {
  description = "R2 secret key"
  type        = string
}

variable "r2_bucket" {
  description = "R2 bucket name"
  type        = string
}

variable "r2_key" {
  description = "R2 key"
  type        = string  
}

variable "company" {
  default     = "generic"
  description = "Company name"
  type        = string
}

variable "vcn_cidr" {
  default     = "10.0.0.0/16"
  description = "VCN CIDR block"
  type        = string
}

variable "user_ocid" {
  description = "User OCID"
  type        = string  
}

variable "tenancy_ocid" {
  description = "Tenancy OCID"
  type        = string
}

variable "compartment_id" {
  description = "Compartment ID"
  type        = string
}

variable "private_key_path" {
  description = "Private key path"
  type        = string  
}

variable "fingerprint" {
  description = "Fingerprint"
  type        = string  
}

variable "image_ocid" {
  description = "Image OCID"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key path"
  type        = string
}

variable "ssh_private_key" {
  description = "SSH private key path"
  type        = string
}

variable "db_admin_password" {
  description = "Admin password for MySQL database"
  type        = string
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}