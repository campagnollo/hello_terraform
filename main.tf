terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAV6V5U7HYEXMVVKVW"
  secret_key = "*************"
}

provider "aws" {
  alias      = "east_alt"
  region     = "us-east-1"
  access_key = "AKIAV6V5U7HYEXMVVKVW"
  secret_key = "************"
}


# Configuration options
resource "aws_instance" "my_terra_server1" {
  for_each      = var.vm_map1
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  tags = {
    Name = each.value.name

  }
  network_interface {
    network_interface_id = aws_network_interface.intsub1[each.key].id
    device_index         = 0
  }

}
resource "aws_instance" "my_terra_server2" {
  for_each      = var.vm_map2
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  tags = {
    Name = each.value.name

  }
  network_interface {
    network_interface_id = aws_network_interface.intsub2[each.key].id
    device_index         = 0
  }

}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform VPC"
  }
}

resource "aws_subnet" "my_subnet1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet1"
  }
}
resource "aws_subnet" "my_subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet2"
  }
}

resource "aws_network_interface" "intsub1" {
  for_each    = var.vm_ip1
  subnet_id   = aws_subnet.my_subnet1.id
  private_ips = each.value.ip
  tags = {
    Name = each.value.name
  }
}
resource "aws_network_interface" "intsub2" {
  for_each    = var.vm_ip2
  subnet_id   = aws_subnet.my_subnet2.id
  private_ips = each.value.ip

  tags = {
    Name = each.value.name
  }
}

resource "aws_ec2_instance_connect_endpoint" "terraform_instances_access1" {
  count     = 1
  subnet_id = aws_subnet.my_subnet1.id
}
resource "aws_ec2_instance_connect_endpoint" "terraform_instances_access2" {
  count     = 1
  subnet_id = aws_subnet.my_subnet2.id
}

resource "aws_instance" "my_terra_server3" {
  provider      = aws.east_alt
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  tags = {
    Name = "east_alt_terra_server"
  }
  lifecycle {
    prevent_destroy = false
  }
}
