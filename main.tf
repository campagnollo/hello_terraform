terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}

provider "aws" {
  region     = "us-east-1"
  access_key  = var.aws_access_key
  secret_key  = var.aws_secret_key
}

provider "aws" {
  alias      = "east_alt"
  region     = "us-east-1"
  access_key  = var.aws_access_key
  secret_key  = var.aws_secret_key
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


resource "aws_network_interface" "intsub1" {
  for_each    = var.vm_ip1
  subnet_id   = aws_subnet.my_subnet1.id
  private_ips = each.value.ip
  tags = {
    Name = each.value.name
  }
}

resource "aws_db_instance" "my_postgres" {
  allocated_storage    = 50
  engine               = "postgres"
  engine_version       = "16.3"
  instance_class       = "db.t3.micro"
  username             = "campagnollo"
  password             = "3A18Abnranger"
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true
}
