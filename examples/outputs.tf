output "service_url" {
  value = google_cloud_run_service.service.status[0].url
}

output "service_name" {
  value = var.service_name
}

output "region" {
  value = var.REGION
}

output "image" {
  value = var.image
}

output "port" {
  value = var.port
}

output "concurrency" {
  value = var.concurrency
}
