
//단일 WEB Server 구축
resource "aws_instance" "user05-web" {
  ami                         = "ami-077ad873396d76f6a"
  instance_type               = "t2.micro"
  subnet_id                   = element(var.private_subnet_id, 0)
  vpc_security_group_ids      = ["sg-0a7966c08d2f2e75b", 
                                "sg-0945622ef6e92f18a",
                                "sg-037c173534eb3529b"]
  key_name                    = "user05-key"
  tags = {
    Name = "user05-web"
  }

}