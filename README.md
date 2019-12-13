# two-regions
This repo contains code that can create resources in two different regions in AWS

# What this repo does

This repo's code will create two aws instance in two different regions at the same time. This is accompplished by using a module and a prvodier is defined each time the module is called.

# Why use this repo

This repo will help you get an understanding of how creating two resources in different regions can be acomplished

# How to use this repo

* Create a user in AWS, you require these two keys in order to be able to create resources in AWS
 ```
 AWS_ACCESS_KEY_ID
 AWS_SECRET_ACCESS_KEY
 ```
 * To use them you have to set them as environment variables by putting these two lines in ~/.bash_profile
 ```
 export AWS_ACCESS_KEY_ID=*your key id*
 export AWS_SECRET_ACCESS_KEY=*your access key*
 ```
 * Install Terraform
 ```
 https://www.terraform.io/downloads.html
 ```
 
 * Clone this repository
 
 ```
 git clone https://github.com/yordanivh/two-regions
 ```
 
 * Change directory
 
 ```
 cd two-regions
 ```
 
 * Initialize the project ( Terraform will download provider plugins)
 
 ```
 terraform init
 ```
 
 * To create two resources in two different regions we need to add two different aws providers. This is accomplished with     aliasing
  ```
  provider "aws" {
    region = "us-east-2"
  }

  provider "aws" {
    alias  = "west"
    region = "us-west-1"
  }
   ```
  * In each module call we specify which provider thus region to use
  ```
  providers = {
      aws = aws.west
    }
  ```

  * We use an output defined in the module to get the availability zone of each instance
  
  ```
  output "deployed_server_east" {
    value = "${module.module_east.availability_zone}"
  }
  ```
  * A sample of the output is
  ```
  Outputs:

  deployed_server_east = us-east-2b
  deployed_server_west = us-west-1a
  ```
  * Plan the operation so that you see what actions will be taken
 
  ```
   terraform plan
   ```
 
   * Run Terraform apply to create the resources
 
   ```
   terraform apply
   ```
  * To destroy the created resources. Allways run this after testing this code to avoid being charged.

  ```
  terraform destroy
  ```

# Sample output
1. Run init to download the necessary plugins and initialize the module
```
two-regions (master) $ terraform init
Initializing modules...

Initializing the backend...

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.41"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
2.Run the plan to command to get and overview of what will be done

```
two-regions (master) $ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.module_east.aws_instance.server will be created
  + resource "aws_instance" "server" {
      + ami                          = "ami-0d5d9d301c853a04a"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # module.module_west.aws_instance.server will be created
  + resource "aws_instance" "server" {
      + ami                          = "ami-0dd655843c87b6930"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```
3.Run apply to apply the plan
```
two-regions (master) $ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.module_east.aws_instance.server will be created
  + resource "aws_instance" "server" {
      + ami                          = "ami-0d5d9d301c853a04a"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # module.module_west.aws_instance.server will be created
  + resource "aws_instance" "server" {
      + ami                          = "ami-0dd655843c87b6930"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.module_east.aws_instance.server: Creating...
module.module_west.aws_instance.server: Creating...
module.module_east.aws_instance.server: Still creating... [10s elapsed]
module.module_west.aws_instance.server: Still creating... [10s elapsed]
module.module_east.aws_instance.server: Still creating... [20s elapsed]
module.module_west.aws_instance.server: Still creating... [20s elapsed]
module.module_east.aws_instance.server: Creation complete after 28s [id=i-04ffbc45f85decbd7]
module.module_west.aws_instance.server: Still creating... [30s elapsed]
module.module_west.aws_instance.server: Creation complete after 31s [id=i-0f6aa11bbaba713f4]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

deployed_server_east = us-east-2b
deployed_server_west = us-west-1a
```

4. Run destroy to remove the two instances to avoid any billing.

```
two-regions (master) $ terraform destroy
module.module_east.aws_instance.server: Refreshing state... [id=i-04ffbc45f85decbd7]
module.module_west.aws_instance.server: Refreshing state... [id=i-0f6aa11bbaba713f4]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # module.module_east.aws_instance.server will be destroyed
  - resource "aws_instance" "server" {
      - ami                          = "ami-0d5d9d301c853a04a" -> null
      - arn                          = "arn:aws:ec2:us-east-2:938620692197:instance/i-04ffbc45f85decbd7" -> null
      - associate_public_ip_address  = true -> null
      - availability_zone            = "us-east-2b" -> null
      - cpu_core_count               = 1 -> null
      - cpu_threads_per_core         = 1 -> null
      - disable_api_termination      = false -> null
      - ebs_optimized                = false -> null
      - get_password_data            = false -> null
      - id                           = "i-04ffbc45f85decbd7" -> null
      - instance_state               = "running" -> null
      - instance_type                = "t2.micro" -> null
      - ipv6_address_count           = 0 -> null
      - ipv6_addresses               = [] -> null
      - monitoring                   = false -> null
      - primary_network_interface_id = "eni-0ff011faf2ed5b8f5" -> null
      - private_dns                  = "ip-172-31-27-0.us-east-2.compute.internal" -> null
      - private_ip                   = "172.31.27.0" -> null
      - public_dns                   = "ec2-18-222-130-245.us-east-2.compute.amazonaws.com" -> null
      - public_ip                    = "18.222.130.245" -> null
      - security_groups              = [
          - "default",
        ] -> null
      - source_dest_check            = true -> null
      - subnet_id                    = "subnet-52287e28" -> null
      - tags                         = {} -> null
      - tenancy                      = "default" -> null
      - volume_tags                  = {} -> null
      - vpc_security_group_ids       = [
          - "sg-879339e5",
        ] -> null

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - encrypted             = false -> null
          - iops                  = 100 -> null
          - volume_id             = "vol-00ed5ff76a241991c" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp2" -> null
        }
    }

  # module.module_west.aws_instance.server will be destroyed
  - resource "aws_instance" "server" {
      - ami                          = "ami-0dd655843c87b6930" -> null
      - arn                          = "arn:aws:ec2:us-west-1:938620692197:instance/i-0f6aa11bbaba713f4" -> null
      - associate_public_ip_address  = true -> null
      - availability_zone            = "us-west-1a" -> null
      - cpu_core_count               = 1 -> null
      - cpu_threads_per_core         = 1 -> null
      - disable_api_termination      = false -> null
      - ebs_optimized                = false -> null
      - get_password_data            = false -> null
      - id                           = "i-0f6aa11bbaba713f4" -> null
      - instance_state               = "running" -> null
      - instance_type                = "t2.micro" -> null
      - ipv6_address_count           = 0 -> null
      - ipv6_addresses               = [] -> null
      - monitoring                   = false -> null
      - primary_network_interface_id = "eni-09023f02cdee80837" -> null
      - private_dns                  = "ip-172-31-12-185.us-west-1.compute.internal" -> null
      - private_ip                   = "172.31.12.185" -> null
      - public_dns                   = "ec2-13-57-18-81.us-west-1.compute.amazonaws.com" -> null
      - public_ip                    = "13.57.18.81" -> null
      - security_groups              = [
          - "default",
        ] -> null
      - source_dest_check            = true -> null
      - subnet_id                    = "subnet-4b362910" -> null
      - tags                         = {} -> null
      - tenancy                      = "default" -> null
      - volume_tags                  = {} -> null
      - vpc_security_group_ids       = [
          - "sg-25c0995a",
        ] -> null

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - encrypted             = false -> null
          - iops                  = 100 -> null
          - volume_id             = "vol-0748c8a6a62cdef1c" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp2" -> null
        }
    }

Plan: 0 to add, 0 to change, 2 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.module_east.aws_instance.server: Destroying... [id=i-04ffbc45f85decbd7]
module.module_west.aws_instance.server: Destroying... [id=i-0f6aa11bbaba713f4]
module.module_east.aws_instance.server: Still destroying... [id=i-04ffbc45f85decbd7, 10s elapsed]
module.module_west.aws_instance.server: Still destroying... [id=i-0f6aa11bbaba713f4, 10s elapsed]
module.module_east.aws_instance.server: Still destroying... [id=i-04ffbc45f85decbd7, 20s elapsed]
module.module_west.aws_instance.server: Still destroying... [id=i-0f6aa11bbaba713f4, 20s elapsed]
module.module_east.aws_instance.server: Still destroying... [id=i-04ffbc45f85decbd7, 30s elapsed]
module.module_west.aws_instance.server: Still destroying... [id=i-0f6aa11bbaba713f4, 30s elapsed]
module.module_east.aws_instance.server: Destruction complete after 33s
module.module_west.aws_instance.server: Destruction complete after 34s

Destroy complete! Resources: 2 destroyed.
```
