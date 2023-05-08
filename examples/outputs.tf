output "service_url" {
  value = module.cloud_run_service.service_url
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
