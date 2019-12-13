variable "image" {
  type = string
}

variable "instance_type" {
  type = string
}

resource "aws_instance" "server" {
  ami           = var.image
  instance_type = var.instance_type
}

output "availability_zone" {
  value = aws_instance.server.availability_zone
}
