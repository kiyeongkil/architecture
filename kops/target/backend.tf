terraform {
	backend "s3" {
		bucket      = "kky-k8s-bucket"
		key         = "kops/target/terraform.tfstate"
		region      = "ap-northeast-2"
		max_retries = 3
	}
}