variable "aws_region" {
  default = "eu-west-1"
}

variable "key_name" {
  description = "Your EC2 Key Pair"
  default     = "MyKeyValuePair"
}

variable "ami_id" {
  description = "Ubuntu AMI"
  default     = "ami-049442a6cf8319180"
}
