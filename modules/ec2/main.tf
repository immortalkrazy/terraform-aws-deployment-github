# 1. VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "devlopment"
  }
}

# 2. Internet Gateway
resource "aws_internet_gateway" "my-internet-gateway" {
  vpc_id = aws_vpc.my-vpc.id
}

# 3. Custom Route Table
resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-internet-gateway.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.my-internet-gateway.id
  }

  tags = {
    Name = "development"
  }
}

# 4. Subnet
resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    name = "debelopment-subnet"
  }
}

# 5. Associate Subnet with Route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.my-route-table.id
}

# 6. Security Group
# moved in security.tf

# 7. Network Interface
resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]

  #   attachment {
  #     instance     = aws_instance.test.id
  #     device_index = 1
  #   }
}

# 8. Elastic IP
resource "aws_eip" "one" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.1.50"

  depends_on = [aws_internet_gateway.my-internet-gateway]
}
# output "server-public-ip" {
#   value = aws_eip.one.public_ip
# }


resource "aws_instance" "web-server-instance" {
  ami               = var.ami
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  key_name          = "faisal-key"

  network_interface {
    device_index = 0

    network_interface_id = aws_network_interface.web-server-nic.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c 'echo Your Fisrt Web Server > /var/www/html/index.html'
                EOF
  tags = {
    Name = "web-server"
  }
}
