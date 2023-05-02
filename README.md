# Terraform Cloud Run Application Test

This repository contains code and instructions for testing a Cloud Run application deployed using Terraform. The tests are written using Terratest, a Python-based library for automated infrastructure testing.

## Getting Started

To get started with testing the Cloud Run application, you will need the following:

- A Google Cloud Platform (GCP) project with billing enabled
- The Google Cloud SDK installed on your machine
- A service account key for the GCP project with the `Cloud Run Admin`, `IAM Service Account Actor`, and `Service Account User` roles assigned


## Repository Structure

```
terraform-terrates-guide/
├── .github/
│   └── workflows/
│       └── ci.yml
├── main.tf
├── outputs.tf
├── variables.tf
├── test/
│   ├── __init__.py
│   └── terraform_test.py
└── README.md
```
`.github/workflows/ci.yml`: running CI pipeline on Github Actions
`main.tf`: Terraform configuration file for creating a Cloud Run service.
`variables.tf`: Terraform configuration file for defining variables used in the Terraform configuration.
`outputs.tf`: Terraform configuration file for defining outputs to display after Terraform applies the configuration.
`test`: Directory containing the Terratest test file.
`test/terraform_test.py`: Terratest test file for testing the Cloud Run service.
`README.md`: Instructions and information for using this repository.

## Running the Tests

To run the tests, follow these steps:

1. Clone this repository to your local machine:

   ```sh
   git clone https://github.com/OmarMerghany/terraform-terratest-guide.git

2. Create a virtual environment and activate it:

    ```sh
    python -m venv venv
    source venv/bin/activate

3. Install the dependencies:

    ```sh
    pip install -r requirements.txt

4. Set the environment variables required for the tests:

    ```sh
    export GOOGLE_APPLICATION_CREDENTIALS=/path/to/service/account/key.json
    export GCP_PROJECT_ID=<your-gcp-project-id>

5. Run the tests:
   
    ```sh
    python test/terraform_test.py

6. Destroy the Terraform resources:

    ```sh
    terraform destroy