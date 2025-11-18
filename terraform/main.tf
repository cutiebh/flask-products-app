#############################################
# Terraform minimal EC2 + Flask deployment
#############################################

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

###########################
# Security Group
###########################
resource "aws_security_group" "flask_sg" {
  name        = "flask-sg"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Flask App"
    from_port   = 8000
    to_port     = 8000
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

###########################
# EC2 Instance
###########################
resource "aws_instance" "flask_app" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.flask_sg.id
  ]

  ##########################################
  # SAFE user_data (fixed)
  ##########################################
  user_data = <<EOF
#!/bin/bash
set -xe

apt update -y
apt install -y python3 python3-pip git

# Create app folder
mkdir -p /var/www/flaskapp
chown ubuntu:ubuntu /var/www/flaskapp

# Install gunicorn system-wide
pip3 install flask gunicorn

# Create systemd service
cat >/etc/systemd/system/flaskapp.service <<EOL
[Unit]
Description=Gunicorn Service for Minimal Flask App
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/var/www/flaskapp
ExecStart=/usr/bin/gunicorn --bind 0.0.0.0:8000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOL

systemctl daemon-reload
systemctl enable flaskapp.service
EOF

  tags = {
    Name = "FlaskMinimalEC2"
  }
}

###########################
# Output public IP
###########################
output "ec2_public_ip" {
  value = aws_instance.flask_app.public_ip
}
