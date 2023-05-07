module "cloud_run_service" {
  source = "./cloud_run_module"

  project_id   = var.GCP_PROJECT_ID
  region       = var.REGION
  service_name = var.service_name
  image        = var.image
}