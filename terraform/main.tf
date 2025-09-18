terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Create a default VPC if one doesn't exist
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# Create a new key pair for the EC2 instance
resource "aws_key_pair" "deployer_key" {
  key_name   = "deployer_key"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "app_sg" {
  name        = "flask-express-sg"
  description = "Allow Flask and Express traffic"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
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

resource "aws_instance" "flask_express_instance" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer_key.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  user_data = file("user-data.sh")
  tags = {
    Name = "FlaskExpressInstance"
  }
}