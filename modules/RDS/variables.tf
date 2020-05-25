variable "rds_db_username" {
	type = "list"
}

variable "env" {
	type = string
}

variable engine {
	type = string
}


variable "rds_instance_class" {
	type = string
}

variable "engine_version" {
  type = "string"
}

variable "use_rds"{
}

#variable "rds_instance_count" {
#  type    = "string"
#}

variable "rds_instance_names" {
  type 	  = list
  }
  
#variable "rds_instance_users" {
#  type 	  = list
#  }