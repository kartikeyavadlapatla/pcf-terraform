module "S3" {
  source = "./modules/S3" 
  
  env 							= var.env
  pcf-ops-manager-bucket-name 	= var.pcf-ops-manager-bucket-name
  pcf-buildpacks-bucket-name  	= var.pcf-buildpacks-bucket-name
  pcf-packages-bucket-name 		= var.pcf-packages-bucket-name
  pcf-resources-bucket-name 	= var.pcf-resources-bucket-name
  pcf-droplets-bucket-name 		= var.pcf-droplets-bucket-name
  ID-String 					= var.ID-String
}

module "IAM" {
  source = "./modules/IAM"
  
  pcf-ops-manager-bucket-ARN 	= module.S3.pcf-ops-manager-bucket-ARN
  pcf-buildpacks-bucket-ARN  	= module.S3.pcf-buildpacks-bucket-ARN
  pcf-droplets-bucket-ARN       = module.S3.pcf-droplets-bucket-ARN
  pcf-packages-bucket-ARN       = module.S3.pcf-packages-bucket-ARN
  pcf-resources-bucket-ARN   	= module.S3.pcf-resources-bucket-ARN
  
  env							= var.env
  iam-user-name 				= var.iam-user-name
}

module "VPC" {
  source = "./modules/VPC"
  
  env							= var.env
  availability-zones  		    = var.availability-zones
  public-subnets				= var.public-subnets
  public-subnets-list			= var.public-subnets-list
  management-subnets			= var.management-subnets
  pas-subnets					= var.pas-subnets
  service-subnets				= var.service-subnets
  rds-subnets					= var.rds-subnets
  private-subnets-list			= var.private-subnets-list
  dns_hosts						= var.dns_hosts
  dns_support					= var.dns_support
  vpc-cidr						= var.vpc-cidr
  vpc-name						= var.vpc-name

}

module "LBS" {
  source = "./modules/LBS"
  
  vpc-id 						= module.VPC.vpc-id
  public-subnets-id 			= module.VPC.pcf-public-subnets-id
  pas-subnets-id 				= module.VPC.pcf-pas-subnets-id
  
  env							= var.env
  availability-zones  		    = var.availability-zones
  use_tcp_routes				= var.use_tcp_routes
  use_ssh_routes				= var.use_ssh_routes
  use_web_lb					= var.use_web_lb

}

module "DNS" {
  source = "./modules/DNS"
  
  vpc-id 						= module.VPC.vpc-id
  opsman-eip					= module.VPC.opsman-eip
  aws_lb_tcp_dns				= module.LBS.aws_lb_tcp_dns
  aws_lb_web_dns 				= module.LBS.aws_lb_web_dns
  aws_lb_ssh_dns 				= module.LBS.aws_lb_ssh_dns
  aws_lb_tcp_zone 				= module.LBS.aws_lb_tcp_zone
  aws_lb_web_zone 				= module.LBS.aws_lb_web_zone
  aws_lb_ssh_zone 				= module.LBS.aws_lb_ssh_zone

  env							= var.env
  zone-name  					= var.zone-name
  use_route53					= var.use_route53
  use_tcp_routes				= var.use_tcp_routes
  use_ssh_routes				= var.use_ssh_routes
}

module "RDS" {
  source = "./modules/RDS"
  
  pcf-rds-subnets-id 			= module.VPC.pcf-rds-subnets-id
  pcf-msql-sg-id 				= module.VPC.pcf-msql-sg-id
  
  env							= var.env
  rds_db_username				= var.rds_db_username
  engine						= var.engine
  rds_instance_class			= var.rds_instance_class
  engine_version				= var.engine_version
  use_rds						= var.use_rds
  #rds_instance_count			= var.rds_instance_count
  rds_instance_names			= var.rds_instance_names
  #rds_instance_users			= var.rds_instance_users
}
