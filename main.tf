provider "aws" {
  region = "us-east-2"
}

provider "aws" {
  alias  = "west"
  region = "us-west-1"
}
module "module_east" {
  source = "./mod/"

  image         = "ami-0d5d9d301c853a04a"
  instance_type = "t2.micro"

  providers = {
    aws = aws
  }
}

module "module_west" {
  source = "./mod/"

  image         = "ami-0dd655843c87b6930"
  instance_type = "t2.micro"

  providers = {
    aws = aws.west
  }
}

output "deployed_server_east" {
  value = "${module.module_east.availability_zone}"
}

output "deployed_server_west" {
  value = "${module.module_west.availability_zone}"
}

