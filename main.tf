# FastApi deployment on aws using terraform
provider "aws" {
  access_key = var.aws_access_key 
  secret_key = var.aws_secret_key 
  region     = "us-east-1"
}

resource "aws_security_group" "instance" {
  name_prefix = "instance-"

  ingress { # for incoming traffic allowed everyone to ssh using port 22
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  ingress { # for incoming traffic allowed everyone to access the database using port 5432
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { # to connect the instance to the internet on all the network.
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { # to access the application on browser 
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "Tf_key"{
  key_name = "my-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "my-key"{
  content = tls_private_key.rsa.private_key_pem
  filename = "my-key"
}

resource "aws_instance" "ubuntu" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t3.medium"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.instance.id]
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }
  # user data is something which call the script(whatever is required) to configure the instance at the time of boot.
  user_data = "${file("fast.sh")}"
  tags = {
    Name = "ubuntu-instance"
  }
}


# security group for rds 
resource "aws_security_group" "rds" {
  name_prefix = "rds-"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}

resource "aws_db_instance" "postgres" {
  engine                 = "postgres"
  engine_version         = "14.6"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  username               = var.db_username
  password               = var.db_password
  db_name                = var.db_name
  port                   = var.port
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds.id]
  tags = {
    Name = "postgres-instance"
  }
}
