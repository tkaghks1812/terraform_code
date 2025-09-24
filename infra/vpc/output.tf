output "vpc_id" {
    value = aws_vpc.user05-vpc.id
  
}
output "user05_public01_id" {
    value = aws_subnet.user05-public01.id

  
}
output "user05_public02_id" {
    value = aws_subnet.user05-public02.id

  
}
output "user05_private01_id" {
    value = aws_subnet.user05-private01.id

  
}
output "user05_private02_id" {
    value = aws_subnet.user05-private02.id

  
}