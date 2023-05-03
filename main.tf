provider "google" {
  credentials = file("var.cred")
  project = var.project_id
  region  = var.region
}

resource "google_cloud_run_service" "service" {
  name               = var.service_name
  location           = var.region
  template {
    spec {
      containers {
        image = var.image
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}