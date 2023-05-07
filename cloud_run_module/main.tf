provider "google" {
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

resource "google_cloud_run_service_iam_policy" "service" {
  location = var.region
  project  = var.project_id
  service  = google_cloud_run_service.service.name

  policy_data = jsonencode({
    bindings = [
      {
        members = ["allUsers"]
        role    = "roles/run.invoker"
      }
    ]
  })
}