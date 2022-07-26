# provider "aws" {
#   region = "eu-west-3"
# }


# resource "aws_vpc" "myApp-vpc" {
#   cidr_block = var.vpc_cidr_block
#   tags = {
#     "Name" = "${var.env_prefix}-vpc"
#   }
# }

# resource "aws_subnet" "myApp-subnet-1" {
#   #must assign to vpc 
#   vpc_id            = aws_vpc.myApp-vpc.id #refered to resource created before
#   cidr_block        = var.subnet_cidr_block
#   availability_zone = var.avail_zone
#   tags = {
#     "Name" = "${var.env_prefix}-subnet1"
#   }
# }


# resource "aws_internet_gateway" "myapp-ig" {
#   vpc_id = aws_vpc.myApp-vpc.id
#   tags = {
#     "Name" = "${var.env_prefix}-igw"
#   }
# }

# # resource "aws_route_table" "myapp-route-table" {
# #   vpc_id = aws_vpc.myApp-vpc.id

# #   route {
# #     cidr_block = "0.0.0.0/0"
# #     gateway_id = aws_internet_gateway.myapp-ig.id
# #   }
# #   tags = {
# #     "Name" = "${var.env_prefix}-rtb"
# #   }
# # }

# #associate subnet to route table

# # resource "aws_route_table_association" "a-rtb-subnet" {
# #   subnet_id      = aws_subnet.myApp-subnet-1.id
# #   route_table_id = aws_route_table.myapp-route-table.id
# # }

# #define default route table instead of creating one
# resource "aws_default_route_table" "main-rtb" {
#   default_route_table_id = aws_vpc.myApp-vpc.default_route_table_id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.myapp-ig.id
#   }
#   tags = {
#     "Name" = "${var.env_prefix}-rtb"
#   }

# }

# # resource "aws_security_group" "myapp-sg" {
# #   name   = "myapp-sg"
# #   vpc_id = aws_vpc.myApp-vpc.id

# #   #two type of rules incoming and outcoming traffic 
# #   #attribute
# #   ingress {
# #     from_port   = 22
# #     to_port     = 22
# #     protocol    = "tcp"
# #     cidr_blocks = [var.my_ip]
# #   }
# #   ingress {
# #     from_port   = 8080
# #     to_port     = 8080
# #     protocol    = "tcp"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# #   egress {
# #     from_port       = 0 #any port
# #     to_port         = 0
# #     protocol        = "-1" # any protocol
# #     cidr_blocks     = ["0.0.0.0/0"]
# #     prefix_list_ids = []
# #   }
# #   tags = {
# #     "Name" = "${var.env_prefix}-sg"
# #   }
# # }

# #want to use existing security group 

# resource "aws_default_security_group" "default-sg" {
#   vpc_id = aws_vpc.myApp-vpc.id

#   #two type of rules incoming and outcoming traffic 
#   #attribute
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = [var.my_ip]
#   }
#   ingress {
#     from_port   = 8080
#     to_port     = 8080
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port       = 0 #any port
#     to_port         = 0
#     protocol        = "-1" # any protocol
#     cidr_blocks     = ["0.0.0.0/0"]
#     prefix_list_ids = []
#   }
#   tags = {
#     "Name" = "${var.env_prefix}-default-sg"
#   }
# }

# data "aws_ami" "latest-amazon-linux-image" {
#   most_recent = true #attirbute most recet set to true
#   owners      = ["amazon"]
#   filter { # define criteria for this queries
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

# #output tp see result 




# resource "aws_key_pair" "ssh-key" {
#   key_name = "server-key"
#   # public_key = var.public_key
#   #orv
#   public_key = file(var.public_key_location) # read from file
# }

# resource "aws_instance" "myapp-server" {
#   #id of image
#   ami           = data.aws_ami.latest-amazon-linux-image.id
#   instance_type = var.instance_type
#   #optional arguments [not defining it's getting them by default]
#   subnet_id              = aws_subnet.myApp-subnet-1.id
#   vpc_security_group_ids = [aws_default_security_group.default-sg.id]
#   availability_zone      = var.avail_zone

#   associate_public_ip_address = true # need public ip address
#   #need also key pairs which allow us to ssh to servers
#   key_name = aws_key_pair.ssh-key.key_name

#   #execute command on EC2 isntance
#   # user_data = <<EOF
#   #               #!/bin/bash
#   #               sudo yum update -y && sudo yum install -y docker
#   #               sudo systemctl start docker
#   #               sudo usermod -aG docker ec2-user
#   #               docker run -p 8080:80 nginx 
#   #             EOF
#   user_data = file("entry-script.sh")
#   tags = {
#     "Name" = "${var.env_prefix}-server"
#   }
# }


