# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  lower   = true
  upper   = false
  length  = 32
  special = false
}

terraform {
  cloud {
    organization = "Level-Up-in-Tech-RGMartinez"

    workspaces {
      name = "terra-house-1"
    }
  }

}

