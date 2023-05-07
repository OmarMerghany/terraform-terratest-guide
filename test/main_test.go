package test

import (
	"testing"
	"time"
	"fmt"
	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestCloudRunServiceExample(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples",
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	serviceURL := terraform.Output(t, terraformOptions, "service_url")
	time.Sleep(10 * time.Second)

	expectedResponseBody := "Hello, world!\nVersion: 1.0.0\nHostname: localhost"
	fmt.Println("serviceURL",serviceURL)

	http_helper.HttpGetWithRetry(t, serviceURL, nil, 200, expectedResponseBody, 3, 5)

}