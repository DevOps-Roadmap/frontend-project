terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "4.5.0"
      }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

resource "aws_security_group" "webservers" {
  name        = "webservers-80"
  description = "Allow HTTP inbound traffic"

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
    type = "webserver"
    env = "production"
  }
}

resource "aws_instance" "web001" {
  count = "3"
  ami           = "ami-0851b76e8b1bce90b"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.webservers.id ]

  key_name = "webserver_key"

  root_block_device {
      encrypted = true
  }

  tags = {
    Name = "Web-${count.index + 1}"
    type = "webserver"
    env = "production"
  }
}
