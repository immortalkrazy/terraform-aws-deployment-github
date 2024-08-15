variable "instance_type" {
  description = "Instance type for the ec2 instamce"
  type        = string
  default     = "t2.micro"

  validation {
    condition     = length(var.instance_type) > 4
    error_message = "Something Wrong"
  }
}

variable "ami" {
  description = "ami to be used for instance defaults to ubuntu"
  type        = string
  default     = "ami-04b70fa74e45c3917"

  sensitive = true
}

variable "availability_zone" {
  description = "availabilty zone for deployment"
  type        = string
  default     = "us-east-1a"
}
