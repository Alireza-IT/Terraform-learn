provider "aws" {
  region = "eu-west-3"
}


resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "${var.env_prefix}-vpc"
  }
}

# reference to module
module "myapp-subnet" {
  #source of module & the path of module
  source = "./modules/subnet"
  #we need to pass the parameters and set them instead of tfvars so put variable here and give values or reference it from tfvars but need variable definiation in variable.tf in root file
  subnet_cidr_block      = var.subnet_cidr_block
  avail_zone             = var.avail_zone
  env_prefix             = var.env_prefix
  vpc_id                 = aws_vpc.myapp-vpc.id
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}


module "myapp-server" {
  source              = "./modules/webserver"
  my_ip               = var.my_ip
  vpc_id              = aws_vpc.myapp-vpc.id
  env_prefix          = var.env_prefix
  image_name          = var.image_name
  public_key_location = var.public_key_location
  instance_type       = var.instance_type
  subnet_id           = module.myapp-subnet.subnet.id
  avail_zone          = var.avail_zone
}
