terraform {
  backend "s3" {
    bucket   = "k1-state-store-mgmt-jb3eax"
    key      = "terraform/vault/terraform.tfstate"
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
    vault = {
      source = "hashicorp/vault"
    }
  }
}

# export CIVO_TOKEN=$MYTOKEN is set 
provider "civo" {
  region = "NYC1"
}

provider "vault" {
  skip_tls_verify = "true"
}
