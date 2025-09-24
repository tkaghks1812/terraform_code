output "user05-public-ip" {
  value = aws_instance.user05-bastion.public_ip
}