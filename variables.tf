variable "cidr" {
    default = "10.0.0.0/16"
    type = string
  
}
variable "ec2_type" {
  default = "t2.micro"
  type = string
}

variable "ec2_ami" {
  default = "ami-01f23391a59163da9"
  type = string
}