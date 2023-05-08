variable "service_name" {
  type        = string
  description = "The name of the Cloud Run service."
}

variable "GCP_PROJECT_ID" {
  type        = string
  description = "GCP Project ID"
}


variable "REGION" {
  type        = string
  description = "The region where the Cloud Run service will be deployed."
}

variable "image" {
  type        = string
  description = "The name of the Docker image to deploy to the Cloud Run service."
}

variable "port" {
  type        = number
  description = "The port that the Cloud Run service listens on."
  default = 80
}

variable "concurrency" {
  type        = number
  description = "The maximum number of concurrent requests that the Cloud Run service can handle."
  default = 1
}

variable "timeout" {
  type        = string
  description = "The maximum amount of time that a request to the Cloud Run service can take."
  default = 30
}
