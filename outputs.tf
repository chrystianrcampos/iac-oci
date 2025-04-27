output "vm_ssh_access" {
  value = "ssh -i ${var.ssh_private_key} ubuntu@${oci_core_public_ip.vm_public_ip.ip_address}"
}

output "vm2_ssh_access" {
  value = "ssh -i ${var.ssh_private_key} ubuntu@${oci_core_public_ip.vm2_public_ip.ip_address}"
}

output "mysql_db_access" {
  value = "ssh -i ${var.ssh_private_key} -L 3306:${oci_mysql_mysql_db_system.database.endpoints[0].ip_address}:3306 ubuntu@${oci_core_public_ip.vm2_public_ip.ip_address}"
}