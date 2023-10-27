terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.22.0"
      configuration_aliases = [ aws.backup-region ]
    }
  }
}

provider "aws" {
  alias = "backup-region"
  region = "eu-west-2"
}