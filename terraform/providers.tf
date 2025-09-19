terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.3.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "zkostov" 
}

