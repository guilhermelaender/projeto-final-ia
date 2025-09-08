# main.tf

provider "aws" {
  region = "us-east-1"  # Altere para a sua região
}

# Security Group para permitir SSH (22) e Docker (opcional)
resource "aws_security_group" "docker_sg" {
  name        = "docker-sg"
  description = "Allow SSH access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # permite SSH de qualquer lugar
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Puxando a VPC default
data "aws_vpc" "default" {
  default = true
}

# EC2 Instance
resource "aws_instance" "docker_instance" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 (verifique na sua região)
  instance_type = "t2.micro"
  key_name      = "minha-chave"       # substitua pelo seu par de chaves existente
  security_groups = [aws_security_group.docker_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              yum install git -y
              cd /home/ec2-user
              git clone https://github.com/guilhermelaender/projeto-final-ia.git
              chown -R ec2-user:ec2-user projeto-final-ia
              cd projeto-final-ia
              docker build -t agente-ia .
              docker run -it -p 8501:8501 agente-ia
              EOF

  tags = {
    Name = "DockerServer"
  }
}
