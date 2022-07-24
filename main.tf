#use provider in the main file
# we want to use aws provider and pass theese credentials
provider "aws" {
  region     = "eu-central-1"
  access_key = "AKIA5HSVA5XYTZHNE2DP"
  secret_key = "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"
}
#we do not have providers code here so we need to install them 
#by trafform init command
#also we have defune which version of provider we use 

# #we need to explicityly define where we can find the code for this
# provider "linode" {
#   # token = "..."
# }
variable "vpc_cidr_block" {
  description = "vpc cidr block"

}
variable "environment" {
  description = "deplotyment environment"
}
#create resource
resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name"    = var.environment
    "vpc_env" = "dev"
  }

}

# resource "aws_subnet" "dev-subnet-1" {
#   #must assign to vpc 
#   vpc_id            = aws_vpc.development-vpc.id #refered to resource created before
#   cidr_block        = "10.0.10.0/24"
#   availability_zone = "eu-central-1a"
#   tags = {
#     "Name" = "subnet-1-dev"
#   }
# }
#create variable 
variable "cidr_blocks" {
  description = "subnet cidr block"
  #can define default value for variable 
  #   default = "10.0.10.0/24"
  #set different type to varibale 
#   type = list(string) # need to have some values with some kind of data
  type = list(object) # need to have some values with some kind of data and need to validate value fo objects
                    ({cidr_block =string
                    name = string})

}
#assign values to variable 
#1- terraform apply and get prompt to enter value for variable (good for testing)
#2- using command line arguments --> terraform apply -var "name of varible"=value
#3 define variblae file terraform.tfvars and define ey vakues pairs for varibales
resource "aws_subnet" "dev-subnet-1" {
  #must assign to vpc 
  vpc_id            = aws_vpc.development-vpc.id #refered to resource created before
  cidr_block        = var.cidr_blocks[1]
  availability_zone = "eu-central-1a"
  tags = {
    "Name" = "subnet-1-dev"
  }
}
#by terraform apply to apply configuration
#for query the existing resources and compoents from aws
data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  #must assign to vpc 
  vpc_id            = data.aws_vpc.existing_vpc.id #get id attribute from the object result
  cidr_block        = "172.31.48.0/20"
  availability_zone = "eu-central-1a"
  tags = {
    "Name" = "subnet-1-default"
  }
}
#two ways to remove resource : 1 - from terraform file / 2 - use terraform command (terraform destroy) and passthe resource name by -target
#terraform destroy -target aws_subnet.dev-subnet-1 #do not use it there is no changes happen on the config file
#apply changes on config file and use terraform apply command

#chack difference between current staate and desired sitate
# by terraform plan command or use terraform apply without confirmation 
#terraform apply  -auto-approve to do apply without confirmation 

#completely destroy infrusturcture
#terraform destroy
#terraform state list
#terraform state shpw name_resource

#tell terrrafrom to give us output after applying configuration from one of the resources
#terraform plan shows the attributes for that resources
output "dev-vpc-id" {
  #which attribute we want as output
  value = aws_vpc.development-vpc.id
}
output "dev-subnet-id" {
  #which attribute we want as output
  value = aws_subnet.dev-subnet-1.id
}
