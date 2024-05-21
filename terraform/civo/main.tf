terraform {
  backend "s3" {
    bucket   = "k1-state-store-mgmt-jb3eax"
    key      = "terraform/civo/terraform.tfstate"
    endpoint = "https://objectstore.NYC1.civo.com"

    region = "NYC1"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }
  required_providers {
    civo = {
      source = "civo/civo"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.23.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.19.0"
    }
  }
}
provider "civo" {
  region = "NYC1"
}

locals {
  cluster_name         = "mgmt"
  kube_config_filename = "../../../kubeconfig"
}

resource "civo_network" "kubefirst" {
  label = local.cluster_name
}

resource "civo_firewall" "kubefirst" {
  name                 = local.cluster_name
  network_id           = civo_network.kubefirst.id
  create_default_rules = true
}

resource "civo_kubernetes_cluster" "kubefirst" {
  name         = local.cluster_name
  network_id   = civo_network.kubefirst.id
  firewall_id  = civo_firewall.kubefirst.id
  cluster_type = "talos"
  pools {
    label      = local.cluster_name
    size       = "g4s.kube.large"
    node_count = tonumber("6") # tonumber() is used for a string token value
  }
}

resource "local_file" "kubeconfig" {
  content  = civo_kubernetes_cluster.kubefirst.kubeconfig
  filename = local.kube_config_filename
}
