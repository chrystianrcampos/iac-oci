output "vm_ssh_access" {
  value = "ssh -i ${var.ssh_private_key} ubuntu@${oci_core_public_ip.vm_public_ip.ip_address}"
}

output "vm2_ssh_access" {
  value = "ssh -i ${var.ssh_private_key} ubuntu@${oci_core_public_ip.vm2_public_ip.ip_address}"
}