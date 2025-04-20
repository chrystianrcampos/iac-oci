resource "oci_core_instance" "vm2" {
  availability_domain   = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id        = var.compartment_id
  display_name          = "${var.company}-vm2"
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
    hostname_label   = "${var.company}-vm2"
    display_name     = "${var.company}-vm2-vnic"
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
    user_data = base64encode(<<EOF
#!/bin/bash

set -e

echo "=== Atualizando pacotes ==="
sudo apt update
sudo apt upgrade -y

echo "=== Instalando utilitários ==="
sudo apt install -y curl wget zip unzip ca-certificates gnupg lsb-release

echo "=== Instalando Docker ==="
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

echo "=== Ativando e iniciando Docker ==="
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu

echo "=== Versões instaladas ==="
docker --version
EOF
    )
  }

  preserve_boot_volume = false
}

data "oci_core_private_ips" "vm2_private_ip" {
  ip_address = oci_core_instance.vm2.private_ip
  subnet_id  = oci_core_subnet.public_subnet_a.id
}

resource "oci_core_public_ip" "vm2_public_ip" {
  compartment_id = var.compartment_id
  lifetime       = "RESERVED"
  display_name   = "${var.company}-vm2-public-ip"
  private_ip_id  = data.oci_core_private_ips.vm2_private_ip.private_ips[0].id
}