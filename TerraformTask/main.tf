provider "aws" {
    region = "ap-south-1"
    access_key = "AKIA2UC3EXX42ER3FZU6"
    secret_key = "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"
}
resource "aws_instance" "terraform-ap-south" {
  ami = "ami-08718895af4dfa033"
  instance_type = "t2.micro"
}
provider "aws" {
    region = "us-west-1"
    access_key = "AKIA2UC3EXX42ER3FZU6"
    secret_key = "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"
    alias = "west"
}
resource "aws_instance" "terraform-us-west" {
  ami = "ami-047d7c33f6e7b4bc4"
  instance_type = "t2.micro"
  provider = aws.west
}