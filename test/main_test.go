package test

import (
	"testing"
	"time"
	"fmt"
	"os"
	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCloudRunServiceExample(t *testing.T) {
	t.Parallel()
	gcpProjectID := os.Getenv("GCP_PROJECT_ID")
	creds := os.Getenv("GOOGLE_APPLICATION_CREDENTIALS")
	region := os.Getenv("REGION")

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples",
		Vars: map[string]interface{}{
			"GCP_PROJECT_ID": gcpProjectID,
			"cred": creds,
			"REGION": region,
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	serviceURL := terraform.Output(t, terraformOptions, "service_url")
	
    fmt.Println("/////////////////////////////////////////////////////////////////////\n\n\n",serviceURL)
    
	time.Sleep(10 * time.Second)

	expectedResponseBody := "Hello, world!\nVersion: 1.0.0\nHostname: localhost"
	fmt.Println("serviceURL",serviceURL)

	http_helper.HttpGetWithRetry(t, serviceURL, nil, 200, expectedResponseBody, 3, 5)

}