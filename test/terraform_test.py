import os
import subprocess
import time
import requests

def test_cloud_run_app():
    # Set up the Terraform options with the path to the Terraform code and the values to use
    os.environ["GCP_PROJECT_ID"] = os.environ.get("GCP_PROJECT_ID")
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = os.environ.get("GOOGLE_APPLICATION_CREDENTIALS")
    terraform_dir = os.path.join(os.getcwd())
    test_name = "test-" + os.environ["GITHUB_RUN_NUMBER"]
    options = [
        "-auto-approve",
        "-var",
        f"project_id={os.environ.get('GCP_PROJECT_ID')}",
        "-var",
        "region=europe-west4",
        "-var",
        f"service_name={test_name}",
        "-var",
        "image=gcr.io/google-samples/hello-app:1.0",
    ]

    # Deploy the Cloud Run application using Terraform
    subprocess.run(["terraform", "init",  terraform_dir], check=True)
    subprocess.run(["terraform", "apply", terraform_dir] + options, check=True)

    # Wait for the Cloud Run service to start up
    time.sleep(30)

    # Send an HTTP GET request to the Cloud Run service
    expected_response = "Hello World!"
    url = subprocess.run(["terraform", "output", "url"], capture_output=True, text=True).stdout.strip()
    response = requests.get(url)
    response_text = response.text.strip()

    # Check that the response matches the expected response
    assert response.status_code == 200, f"Unexpected status code: {response.status_code}"
    assert response_text == expected_response, f"Unexpected response: {response_text}"

    # Destroy the resources using Terraform
    subprocess.run(["terraform", "destroy", "-auto-approve", terraform_dir] + options, check=True)


if __name__ == "__main__":
    test_cloud_run_app()
