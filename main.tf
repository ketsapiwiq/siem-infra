variable "access_key" {}
variable "secret_key" {}
variable "organization_id" {}

provider "scaleway" {
  region       = "fr-par"
  zone       = "fr-par-1"

  access_key = var.access_key
  secret_key = var.secret_key
  organization_id = var.organization_id
}

resource "scaleway_instance_ip" "wazuh_manager_public_ip" {}
resource "scaleway_instance_ip" "wazuh_agent_public_ip" {}


data "scaleway_image" "bionic" {
  architecture = "x86_64"
  name         = "Ubuntu Bionic"
}
data "scaleway_image" "debian_9_x64" {
  architecture = "x86_64"
  name         = "Debian Stretch"
}

resource "scaleway_instance_server" "wazuh_manager_1" {
  type  = "DEV1-L"
  # Bugs in Wazuh Kibana plugin with Debian 9/10
  image = data.scaleway_image.bionic.id
  ip_id = scaleway_instance_ip.wazuh_manager_public_ip.id
  tags = ["wazuh_manager","wazuh"]

}


resource "scaleway_instance_server" "wazuh_agent_1" {
  type  = "DEV1-S"
  image = data.scaleway_image.debian_9_x64.id
  ip_id = scaleway_instance_ip.wazuh_agent_public_ip.id

  tags = ["wazuh_agent","wazuh"]

}
