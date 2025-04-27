resource "oci_core_virtual_network" "vcn" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_id
  display_name   = "${var.company}-vcn"
  dns_label      = "${var.company}vcn"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  display_name   = "${var.company}-igw"
  vcn_id         = oci_core_virtual_network.vcn.id
  enabled        = true
}

resource "oci_core_route_table" "public" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "${var.company}-route-table-public"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_subnet" "public_subnet_a" {
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  cidr_block          = cidrsubnet(var.vcn_cidr, 8, 0)
  vcn_id              = oci_core_virtual_network.vcn.id
  display_name        = "public-subnet-a"
  dns_label           = "pubsuba"
  route_table_id      = oci_core_route_table.public.id
  security_list_ids   = [oci_core_security_list.default_security_list.id]
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_subnet" "private_subnet_a" {
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  cidr_block          = cidrsubnet(var.vcn_cidr, 8, 1)
  vcn_id              = oci_core_virtual_network.vcn.id
  display_name        = "private-subnet-a"
  dns_label           = "privsuba"
  security_list_ids   = [oci_core_security_list.default_security_list.id, oci_core_security_list.db_security_list.id]
  prohibit_public_ip_on_vnic = true
}