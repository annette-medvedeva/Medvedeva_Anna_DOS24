provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "jenkins" {
  ami                    = "ami-0437e8813894fa0c5"  # Ubuntu 22.04 LTS (проверьте актуальность)
  instance_type          = "t2.micro"
  key_name               = "ssh_linux1"  # Укажите ваш ключ SSH
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  tags = {
    Name = "Jenkins-Server"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt update && apt upgrade -y
              apt install -y docker.io curl
              usermod -aG docker ubuntu
              curl -SL https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose
              mkdir -p /home/ubuntu/jenkins
              cat <<EOT > /home/ubuntu/jenkins/docker-compose.yml
              version: '3.8'
              services:
                jenkins:
                  image: jenkins/jenkins:lts
                  container_name: jenkins
                  ports:
                    - "8080:8080"
                    - "50000:50000"
                  volumes:
                    - jenkins_home:/var/jenkins_home
                  restart: always
              volumes:
                jenkins_home:
              EOT
              cd /home/ubuntu/jenkins
              docker-compose up -d
              EOF
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Security group for Jenkins"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Разрешает SSH откуда угодно (лучше ограничить по IP)
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Jenkins Web UI
  }

  ingress {
    from_port   = 50000
    to_port     = 50000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Jenkins Agent
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
