terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.61.0"
    }

  }
}

provider "aws" {
  region = "us-east-1a" # Update with your desired AWS region
}

resource "aws_lightsail_instance" "Project3" {
  name              = "my-lightsail-server"
  availability_zone = "us-east-1a" # Update with your desired availability zone
  blueprint_id      = "centos_7_1901_01"
  bundle_id         = "nano_2_0"
  key_pair_name     = "PatupeG" # Update with your key pair name
  user_data         = <<-EOF
                      #!/bin/bash
                      sudo yum update -y
                      sudo yum install unzip wget httpd -y
                      sudo wget https://github.com/utrains/static-resume/archive/refs/heads/main.zip
                      sudo unzip main.zip
                      sudo rm -rf /var/www/html/*
                      sudo cp -r static-resume-main/* /var/www/html/
                      sudo systemctl start httpd
                      sudo systemctl enable httpd
                      EOF
}

output "lightsail_server_ip" {
  value = aws_lightsail_instance.Project3.public_ip_address
}
