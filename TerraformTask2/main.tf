
# Provider for ap-south-1  
provider "aws" {  
  region = "ap-south-1"  
}  

# Security group for the first instance  
resource "aws_security_group" "nginx_sg_south" {  
  name        = "nginx_sg_south"  
  description = "Allow HTTP and SSH traffic"  
  
  ingress {  
    from_port   = 80  
    to_port     = 80  
    protocol    = "tcp"  
    cidr_blocks = ["0.0.0.0/0"]  
  }  

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

# First EC2 Instance in ap-south-1  
resource "aws_instance" "nginx_server_south" {  
  ami           = "ami-08718895af4dfa033"  
  instance_type = "t2.micro"  
  
  user_data = <<-EOF
    #!/bin/bash  
    yum update -y  
    yum install -y nginx  
    systemctl start nginx  
    systemctl enable nginx  
  EOF  
  
  vpc_security_group_ids = [aws_security_group.nginx_sg_south.id]  
  
  tags = {  
    Name = "NginxServerSouth"  
  }  
}  

provider "aws" {  
  alias  = "west-1"  
  region = "us-west-1"  
}

# Security group for the second instance  
resource "aws_security_group" "nginx_sg_west" {  
  provider = aws.west-1  
  name        = "nginx_sg_west"  
  description = "Allow HTTP and SSH traffic"  
  
  ingress {  
    from_port   = 80  
    to_port     = 80  
    protocol    = "tcp"  
    cidr_blocks = ["0.0.0.0/0"]  
  }  

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

# Second EC2 instance in us-west-1  
resource "aws_instance" "nginx_server_west" {  
  provider      = aws.west-1  
  ami           = "ami-047d7c33f6e7b4bc4"  
  instance_type = "t2.micro"  
  
  user_data     = <<-EOF
    #!/bin/bash  
    yum update -y  
    yum install -y nginx  
    systemctl start nginx  
    systemctl enable nginx  
  EOF  
  
  vpc_security_group_ids = [aws_security_group.nginx_sg_west.id]  
  
  tags = {  
    Name = "NginxServerWest"  
  }  
}  

# Output for instance IP addresses  
output "instance_ip_south" {  
  value = aws_instance.nginx_server_south.public_ip  
}  

output "instance_ip_west" {  
  value = aws_instance.nginx_server_west.public_ip  
}