# by this file we are returning value to parent module 
# export object and value to access them in main module

output "subnet" {
  value = aws_subnet.myapp-subnet-1 # output whole object
}
