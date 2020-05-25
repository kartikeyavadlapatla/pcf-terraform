#### Environment #####

variable "env" {
  type = string
  default = "dev"
}

variable "availability-zones" {
  type        = list(string)
  description = "List of Availability Zones (e.g. `['us-east-1a', 'us-east-1b', 'us-east-1c']`)"
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}


#### IAM #####

variable "iam-user-name" {
	type = string
	default = "pcf-master-user"
}

#### S3 ######

variable "pcf-ops-manager-bucket-name" {
	type = string
	default = "pcf-ops-manager-bucket"
}

variable "pcf-buildpacks-bucket-name" {
	type = string
	default = "pcf-buildpacks-bucket"
}

variable "pcf-packages-bucket-name" {
	type = string
	default = "pcf-packages-bucket"
}

variable "pcf-resources-bucket-name" {
	type = string
	default = "pcf-resources-bucket"
}

variable "pcf-droplets-bucket-name" {
	type = string
	default = "pcf-droplets-bucket"
}

variable "ID-String" {
	type = string
	default = "xyz21jblnkxv6921"
}


##### VPC #########

variable "public-subnets" {
  type        = list(string)
  description = "List of public subnets (e.g. `['10.0.1.0/24', '10.0.2.0/24']`)"
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "public-subnets-list" {
   type        = list(string)
   default = ["public-subnets"]
}

variable "management-subnets" {
  type        = list(string)
  description = "List of private mgmt subnets (e.g. `['10.0.1.0/24', '10.0.2.0/24']`)"
  default = ["10.0.16.0/28", "10.0.16.16/28", "10.0.16.32/28"]
}

variable "pas-subnets" {
  type        = list(string)
  description = "List of private pas subnets (e.g. `['10.0.1.0/24', '10.0.2.0/24']`)"
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "service-subnets" {
  type        = list(string)
  description = "List of private service subnets (e.g. `['10.0.1.0/24', '10.0.2.0/24']`)"
  default = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
}

variable "rds-subnets" {
  type        = list(string)
  description = "List of private rds subnets (e.g. `['10.0.1.0/24', '10.0.2.0/24']`)"
  default = ["10.0.12.0/24", "10.0.13.0/24", "10.0.14.0/24"]
}

variable "private-subnets-list" {
   type        = list(string)
   default = ["management", "pas", "services", "rds"]
}


variable "dns_hosts" {
	type = bool
	default = "true"
}

variable "dns_support" {
	type = bool
	default = "true"
}

variable "vpc-cidr" {
	type = string
	default = "10.0.0.0/16"
}

variable "vpc-name" {
	type = string
    default = "dev-pcf-cluster-vpc"
}



##### LBS #########

variable "use_web_lb" {
 default = true
 }

variable "use_ssh_routes" {
 default = true
 }
 
 variable "use_tcp_routes" {
 default = true
 }


####### RDS #########

variable "rds_db_username" {
	type = list
	default = ["admin", "admin", "admin", "admin"]
}

variable "engine" {
	type = string
	default = "MySql"
}


variable "rds_instance_class" {
  default = "db.m4.large"
}

variable "engine_version" {
  type = "string"
  default = "8.0.16"
}

variable "use_rds" {
  default = "true"
  }
  
variable "rds_instance_names" {
  type 	  = list
  default = ["directordb", "pasmysqinternaldb", "uaadb", "credhubdb"]
  }

#variable "rds_instance_count" {
#  type    = "string"
#  default = 1
#}


######## DNS ##########


variable "use_route53" {
  default = true
}

variable "zone-name" {
  default = "training-pcf.me.uk"
}

