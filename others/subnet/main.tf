
#all variables should pass to the main file so turn all values to variables
resource "aws_subnet" "myapp-subnet-1" {
  #must assign to vpc 
  vpc_id            = var.vpc_id #refered to resource created before
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    "Name" = "${var.env_prefix}-subnet1"
  }
}

resource "aws_internet_gateway" "myapp-ig" {
  vpc_id = var.vpc_id
  tags = {
    "Name" = "${var.env_prefix}-igw"
  }
}


resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = var.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-ig.id # refer to same file 
  }
  tags = {
    "Name" = "${var.env_prefix}-rtb"
  }

}
