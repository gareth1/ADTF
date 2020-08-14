    # Constants
    provider "aws" {
      version    = "~> 2.0"
      region     = var.aws_region
      access_key = ""
      secret_key = ""
    }

    resource "aws_vpc" "default" {
      cidr_block = "${var.vpc_cidr}"
    }


    # Create an internet gateway to provide subnet access to outside world
    resource "aws_internet_gateway" "default" {
        vpc_id = "${aws_vpc.default.id}"
    }

    #Create a subnet to launch the instance into
    resource "aws_subnet" "default" {
      count                   = "${length(var.subnets)}"
      vpc_id                  = "${aws_vpc.default.id}"
      cidr_block              = "${element(values(var.subnets), count.index)}"
      map_public_ip_on_launch = true
      availability_zone       = "${element(keys(var.subnets), count.index)}"
      depends_on              = ["aws_internet_gateway.default"]
    }

    # Grant the VPC Internet access on its main route table
    resource "aws_route" "internet_access" {
      route_table_id          = "${aws_vpc.default.main_route_table_id}"
      destination_cidr_block  = "0.0.0.0/0"
      gateway_id              = "${aws_internet_gateway.default.id}"
    }

    resource "aws_security_group" "default" {
      name        = "allow_whitelist"
      description = "Allow all inbound traffic from whitelisted IPs in vars file of terraform attack range"
      vpc_id      = "${aws_vpc.default.id}"
      ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = var.ip_whitelist
      }

      egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }

    #Standup windows 2016 domain controller
    resource "aws_instance" "windows_2016_dc" {
      ami                     = var.windows_2016_dc_ami
      instance_type           = "t2.2xlarge"
      key_name                = var.key_name
      subnet_id               = "${aws_subnet.default.0.id}"
      vpc_security_group_ids  = ["${aws_security_group.default.id}"]
      tags = {
        name  = "attack-range_windows_2016_dc"
      }
    }
