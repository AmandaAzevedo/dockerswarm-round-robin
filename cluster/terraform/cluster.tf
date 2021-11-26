# Provider AWS na região us-east-1
provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

# Definindo security group para acesso via ssh nas máquinas
resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "ssh-access"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cdirs_remote_access
  }
   egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  tags = {
    Name = "ssh"
  }
}

# Definindo nó manager do cluster
resource "aws_instance" "manager" {
    count = 3
    ami = "ami-026c8acd92718196b"
    instance_type = "t2.micro"
    key_name = var.key_name
    vpc_security_group_ids = ["${aws_security_group.ssh-access.id}"]
    tags = {
        Name = "manager${count.index}"
    }
}

# Definindo nós workers do cluster
resource "aws_instance" "worker" {
    count = 2
    ami = "ami-026c8acd92718196b"
    instance_type = "t2.micro"
    key_name = var.key_name
    vpc_security_group_ids = ["${aws_security_group.ssh-access.id}"]
        tags = {
        Name = "worker${count.index}"
    }
}