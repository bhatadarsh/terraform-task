variable "aws_region" {
  description = "The AWS region to deploy the resources."
  type        = string
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
  default     = "ami-01b6d88af12965bb6" # Replace with a valid Amazon Linux 2 AMI ID for your region
}

variable "public_key_path" {
  description = "Path to the public SSH key to be used for the EC2 instance."
  type        = string
  default     = "C:/Users/bhata/.ssh/id_rsa.pub" # Adjust path as needed
}