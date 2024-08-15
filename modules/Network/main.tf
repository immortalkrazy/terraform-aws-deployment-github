# 1. VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        name = "my-test-vpc"
    }  
}
