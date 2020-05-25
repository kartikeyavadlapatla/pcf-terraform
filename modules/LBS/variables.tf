variable "availability-zones" {
  type        = list(string)
  description = "List of Availability Zones (e.g. `['us-east-1a', 'us-east-1b', 'us-east-1c']`)"
}

variable env {
	type = string
}

variable "use_tcp_routes" {
  description = "Indicate whether or not to enable tcp routes and elbs"
}

variable "use_ssh_routes" {
  description = "Indicate whether or not to enable ssh routes and elbs"
}


variable "use_web_lb" {
	type = string
 }