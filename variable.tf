variable "region" {
  type        = string
  description = "aws region"
  default     = "eu-west-2"
}

variable "controller_instance_type" {
  type        = string
  description = "instance type"
  default     = "t3.medium"
}

variable "ami_id" {
  type        = string
  description = "ami"
  default     = "ami-0b4c7755cdf0d9219"
}

variable "vpc_id" {
  type        = string
  description = "vpc"
  default     = "vpc-043e1dc52827b0366"
}

variable "agent_instance_type" {
  type        = string
  description = "instance type"
  default     = "t3.large"
}

variable "key_name" {
  type        = string
  description = "key"
  default     = "londonserver"
}

variable "subnets" {
  type        = list(string)
  description = "subnets"
  default = ["subnet-02a9e5d00bbb8cc25", "subnet-0644c8c5d8ada7398", "subnet-04fb6726c16bdd4ca"]
}

variable "zone_id" {
  type = string
  description = "zone id"
  default = "Z0671589BT7MHBSY40SQ"
}


variable "domain_name" {
  type = string
  description = "domain"
  default = "jenkins.globalfrontierlink.co.uk"

}