variable "default_tags" {
  type = map(string)
  default = {
    "env" = "pla"
  }
  description = "Default naming scheme for Pawnee Library Association"
}
variable "public_subnet_count" {
  type        = number
  description = "public subnet count"
  default     = 2
}

variable "private_subnet_count" {
  type        = number
  description = "private subnet count"
  default     = 2
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Main VPC CIDR block"
}
