provider "aws" {
  region = "us-west-2"
  access_key = "" 
  secret_key = ""
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "instance_type" {
  type = string
  description = "Tipe instance EC2"
  default = "t2.micro" 
}

variable "instance_count" {
  type = number
  description = "Jumlah instance EC2"
  default = 1          
}

variable "enable_monitoring" {
  type = bool
  description = "Aktifkan monitoring?"
  default = false     
}

resource "aws_instance" "example" {
  ami           = "ami-00150d0e40e86c869"
  instance_type = var.instance_type  
  count         = var.instance_count  

  tags = {
    Name = "Server Saya"
    Environment = "Production"
  }
}

output "public_ip" {
  value       = aws_instance.example[0].public_ip
  description = "Public IP address of the EC2 instance"
}

output "instance_id" {
  value       = aws_instance.example[0].id
  description = "ID of the EC2 instance"
}

