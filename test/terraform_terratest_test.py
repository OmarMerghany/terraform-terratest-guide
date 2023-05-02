import os
import time

from terratest import options
from terratest import terraform
from terratest import test
from terratest.http_helper import http_get


def setup_environment():
    # Set the Google Cloud project to use for this test
    os.environ["GOOGLE_CLOUD_PROJECT"] = os.environ.get("GCP_PROJECT_ID")
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = os.environ.get("GOOGLE_APPLICATION_CREDENTIALS")


def test_cloud_run_app():
    # Set up the Terraform options with the path to the Terraform code and the values to use
    setup_environment()
    terraform_dir = os.path.join(os.getcwd(), "terraform")
    test_name = "test-" + os.environ["GITHUB_RUN_NUMBER"]
    options = terraform.Options(
        terraform_dir=terraform_dir,
        vars={
            "project_id": os.environ.get("GCP_PROJECT_ID"),
            "region": "europe-west4",
            "service_name": test_name,
            "image": "gcr.io/google-samples/hello-app:1.0",
        },
    )

    # Deploy the Cloud Run application using Terraform
    terraform.apply(options)

    # Wait for the Cloud Run service to start up
    time.sleep(30)

    # Send an HTTP GET request to the Cloud Run service
    expected_response = "Hello World!"
    url = terraform.output(options, "url")
    response = http_get(url, expected_status=200, expected_response=expected_response)

    # Check that the response matches the expected response
    test.assertEqual(expected_response, response, f"Unexpected response: {response}")

    # Destroy the resources using Terraform
    terraform.destroy(options)


if __name__ == "__main__":
    test_cloud_run_app()
