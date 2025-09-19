# Configure the Terraform backend to store state in a GCS bucket
terraform {
  backend "gcs" {
    bucket = "does-the-world-know-pain" # <-- REPLACE with the name of your state bucket
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.3.0"
    }
  }
}

# Configure the Google Cloud provider with your Project ID
provider "google" {
  project = "zkostov" # <-- This is your project ID
}

# Defining the Cloud Storage bucket resource
resource "google_storage_bucket" "website_bucket" {
  name          = "the-world-shall-know-pain" # <-- The name of your website bucket
  location      = "US-CENTRAL1"
  force_destroy = true

  # Configure the bucket for static website hosting
  website {
    main_page_suffix = "index.html"
  }
}

# Define the IAM policy to make the bucket's objects publicly readable
resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.website_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Output the URL of the deployed website for easy access
output "website_url" {
  value = "http://${google_storage_bucket.website_bucket.name}.storage.googleapis.com"
}