resource "oci_mysql_mysql_db_system" "database" {
  compartment_id            = var.compartment_id
  availability_domain       = data.oci_identity_availability_domains.ads.availability_domains[0].name
  shape_name                = "MySQL.Free"
  subnet_id                 = oci_core_subnet.private_subnet_a.id
  mysql_version             = "9.3.0"
  display_name              = "database-free"
  description               = "Always Free MySQL DB System for client"
  data_storage_size_in_gb   = 50
  admin_username            = "admin"
  admin_password            = var.db_admin_password
  hostname_label            = "database"
  
  maintenance {
    window_start_time = "SUN 02:00"
  }
}