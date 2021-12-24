# AWS Region: North of Virginia
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

/* EC2 Instance type */
#Use: instance_type = var.instance_type["type1"]
variable "instance_type" {
  type = map(string)
  default = {
    "type1" = "t2.micro"
    "type2" = "t2.small"
    "type3" = "t2.medium"
  }
}

# SSH Key-Pair 
variable "key_name" {
  type    = string
  default = "Bastion-Key"
}

/* Tags Variables */
# Use: tags  = merge(var.project-tags, { Name = "${var.resource-name-tag}-XYZ" }, )
variable "project-tags" {
  type = map(string)
  default = {
    service     = "bastion-host",
    environment = "demo"
    owner       = "example@mail.com"
  }
}

variable "resource-name-tag" {
  type    = string
  default = "Bastion"
}

variable "vpc-id" {
  type    = string
  default = "vpc-0955d0959d69fd94e"
}

variable "public-subnet-id" {
  type    = string
  default = "subnet-0a1a66d630bdf1786"
}