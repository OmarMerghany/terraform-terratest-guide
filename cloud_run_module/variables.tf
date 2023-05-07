variable "project_id" {
  type        = string
  description = "The ID of the GCP project to deploy resources into."
}

variable "region" {
  type        = string
  description = "The region to deploy resources into."
}

variable "service_name" {
  type        = string
  description = "The name of the Cloud Run service to create."
}

variable "image" {
  type        = string
  description = "The container image to use for the Cloud Run service."
}

