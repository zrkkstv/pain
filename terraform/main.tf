# Defining the Cloud Storage bucket resource
resource "google_storage_bucket" "website_bucket" {
  name          = "the-world-shall-know-pain" # Globally unique name
  location      = "US-CENTRAL1"
  force_destroy = true # This allows Terraform to delete the bucket and its contents. Better for stopping the water meter :D 

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