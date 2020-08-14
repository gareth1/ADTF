  # Static Variables
  variable "public_key_path" {
    default = "~/.ssh/id_rsa.pub"
  }

  variable "private_key_path" {
    default = "~/.ssh/id_rsa"
  }

  variable "win_username" {
    description = "Windows default username"
    type        = "string"
    default     = "Administrator"
  }

  variable "win_password" {
    description = "default password"
    type        = "string"
  }

  variable "key_name" {
    description = "active_directory"
  }

  variable "aws_region" {
    description = "AWS region to launch server"
    default     = "us-east-2"
  }

  # for automatic availability_zone
  variable "vpc_cidr" {
    description = "The CIDR Block for the VPC"
    type    = "string"
    default = "10.0.0.0/16"
  }

  variable "subnets" {
    description = "A map of availability_zones to CIDR Blocks, which will be setup as subnets"
    type = "map"
    default = {
      us-east-2a = "10.0.1.0/24"
      us-east-2b = "10.0.2.0/24"
      us-east-2c = "10.0.3.0/24"
    }
  }

  variable "aws_profile" {
    default = "default"
  }

  variable "ip_whitelist" {
    description = "A list of CIDRs that will be allowed to access the EC2 Instance"
    type        = list(string)
    default     = ["own_ip_range"]
  }

  variable "external_dns_servers" {
    description = "Configure Lab to allow external DNS resolution"
    type        = list(string)
    default     = ["8.8.8.8"]
  }
  # Uses AWS AMI Windows 2016 Server Base
  variable "windows_2016_dc_ami" {
    type    = string
    default = "ami-0eee786016f889c3a"
  }
