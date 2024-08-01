provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my-app" {

  ami = "ami-0427090fd1714168b"
  subnet_id = "subnet-0edd425aeb259bc23"
  instance_type = "t2.micro"
  
}
