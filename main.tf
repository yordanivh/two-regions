provider "aws" {
  alias  = "east"
  region = "us-east-2"
}

provider "aws" {
  alias  = "west"
  region = "us-west-1"
}

resource "aws_instance" "server_east" {
  provider = aws.east
  ami  = "ami-0d5d9d301c853a04a"
  instance_type     = "t2.micro"
  

}

resource "aws_instance" "server_west" {
  provider = aws.west
  ami   = "ami-0dd655843c87b6930"
  instance_type     = "t2.micro"
  
}

output "deployed_server_east" {
  value = "${aws_instance.server_east.availability_zone}"
}

output "deployed_server_west" {
  value = "${aws_instance.server_west.availability_zone}"
}

