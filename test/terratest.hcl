terraform {
  required_version = ">= 1.0.0"
}

provider "google" {
  project = var.GCP_PROJECT_ID
  region  = var.region
}

dependency "terraform" {
  config_path = "../"
}

dependency "gcp" {
  version     = "3.44.0"
  config_path = "../"
}

dependency "google" {
  version     = "4.5.0"
  config_path = "../"
}

test_fixture {
  name = "cloud-run"

  // Deploy the Cloud Run service before running tests
  setup {
    commands = [
      "terraform init",
      "terraform apply -auto-approve",
    ]
  }

  // Destroy the Cloud Run service after running tests
  teardown {
    commands = [
      "terraform destroy -auto-approve",
    ]
  }

  // Run the Go tests
  tests {
    commands = [
      "cd test",
      "go test -v",
    ]
  }
}