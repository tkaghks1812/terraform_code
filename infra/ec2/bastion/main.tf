
//단일 WEB Server 구축
resource "aws_instance" "user05-bastion" {
  ami                         = "ami-077ad873396d76f6a"
  instance_type               = "t2.micro"
  subnet_id                   = element(var.public_subnet_id, 0)
  vpc_security_group_ids      = ["sg-037c173534eb3529b"]
  key_name                    = "user05-key"
  associate_public_ip_address = true
  tags = {
    Name = "user05-bastion"
  }

}