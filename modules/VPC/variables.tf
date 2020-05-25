variable "env" {
  type = string
}

variable "availability-zones" {
  type        = list(string)
  description = "List of Availability Zones (e.g. `['us-east-1a', 'us-east-1b', 'us-east-1c']`)"
}

variable "public-subnets" {
  type        = list(string)
  description = "List of public subnets (e.g. `['10.0.1.0/24', '10.0.2.0/24']`)"
}

variable "public-subnets-list" {
   type        = list(string)
}

variable "management-subnets" {
  type        = list(string)
  description = "List of private mgmt subnets (e.g. `['10.0.1.0/24', '10.0.2.0/24']`)"
}

variable "pas-subnets" {
  type        = list(string)
  description = "List of private pas subnets (e.g. `['10.0.1.0/24', '10.0.2.0/24']`)"
}

variable "service-subnets" {
  type        = list(string)
  description = "List of private service subnets (e.g. `['10.0.1.0/24', '10.0.2.0/24']`)"
}

variable "rds-subnets" {
  type        = list(string)
  description = "List of private rds subnets (e.g. `['10.0.1.0/24', '10.0.2.0/24']`)"
}

variable "private-subnets-list" {
   type        = list(string)
}


variable "dns_hosts" {
	type = bool
}

variable "dns_support" {
	type = bool
}

variable "vpc-cidr" {
	type = string
}

variable "vpc-name" {
	type = string
}



