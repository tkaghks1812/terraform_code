resource "local_file" "example" {
content = "ABC!"
filename = "${path.module}/example.txt"
}