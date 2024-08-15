output "server-public-ip" {
  value = aws_eip.one.public_ip
}

