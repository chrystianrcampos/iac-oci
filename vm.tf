resource "oci_core_instance" "vm" {
  availability_domain   = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id        = var.compartment_id
  display_name          = "${var.company}-vm-${var.env}"
  shape                 = "VM.Standard.A1.Flex"

  shape_config {
    ocpus         = 2
    memory_in_gbs = 12
  }

  source_details {
    source_type             = "image"
    source_id               = var.image_ocid
    boot_volume_size_in_gbs = 100
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public_subnet_a.id
    assign_public_ip = false
    hostname_label   = "${var.company}-vm-${var.env}"
    display_name     = "${var.company}-vm-vnic-${var.env}"
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }

  preserve_boot_volume = false
}

data "oci_core_private_ips" "vm_private_ip" {
  ip_address = oci_core_instance.vm.private_ip
  subnet_id  = oci_core_subnet.public_subnet_a.id
}

resource "oci_core_public_ip" "vm_public_ip" {
  compartment_id = var.compartment_id
  lifetime       = "RESERVED"
  display_name   = "${var.company}-vm-public-ip-${var.env}"
  private_ip_id  = data.oci_core_private_ips.vm_private_ip.private_ips[0].id
}