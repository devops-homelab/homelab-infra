package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformLocalSimple(t *testing.T) {
	t.Parallel()

	// Load environment variables
	environment := os.Getenv("ENVIRONMENT")
	component := os.Getenv("COMPONENT")
	module := os.Getenv("MODULE")

	terraformOptions := &terraform.Options{
		TerraformDir:    "../live/" + environment + "/" + component + "/" + module,
		TerraformBinary: "terragrunt",
		Reconfigure:     true,
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
