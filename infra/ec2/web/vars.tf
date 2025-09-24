variable "region" {
  type    = string
  default = "ap-northeast-2"


}
variable "vpc" {
  type    = string
  default = "vpc-0c27db84dcdb113e8"
}
variable "public_subnet_id" {
  type    = list(any)
  default = ["subnet-0e0a58307e3c44617", "subnet-0cc4c6f420ee548de"]

}
variable "private_subnet_id" {
  type    = list(any)
  default = ["subnet-09480bb2bc7e07348", "subnet-08d5483cece80b8ee"]

}
