terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile != "" ? var.aws_profile : null
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  key_name                    = aws_key_pair.local_key.key_name

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name = var.instance_name
  }

  vpc_security_group_ids = [aws_security_group.ssh-sg.id, aws_security_group.app-3000.id]
}

resource "aws_key_pair" "local_key" {
  key_name   = "my-local-key"
  public_key = file("${path.module}/../firstvm.pub")
}

resource "aws_security_group" "ssh-sg" {
  name        = "ssh-sg"
  description = "security group for incoming ssh requests"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app-3000" {
  name        = "app-3000"
  description = "security group for incoming ssh requests"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

