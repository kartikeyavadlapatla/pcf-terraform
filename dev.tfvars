#### Environment #####

env 							= "dev"
availability-zones 				= ["us-east-1a", "us-east-1b", "us-east-1c"]


#### IAM #####

iam-user-name 					= "pcf-master-user"

#### S3 ######

pcf-ops-manager-bucket-name 	= "pcf-ops-manager-bucket"
pcf-buildpacks-bucket-name 		= "pcf-buildpacks-bucket"
pcf-packages-bucket-name 		= "pcf-packages-bucket"
pcf-resources-bucket-name 		= "pcf-resources-bucket"
pcf-droplets-bucket-name 		= "pcf-droplets-bucket"
ID-String 						= "xyz21jblnkxv6921"


##### VPC #########

public-subnets-list 			= ["public-subnets"]
private-subnets-list			= ["management", "pas", "services", "rds"]
public-subnets 					= ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
management-subnets				= ["10.0.16.0/28", "10.0.16.16/28", "10.0.16.32/28"]
pas-subnets					    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
service-subnets					= ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
rds-subnets						= ["10.0.12.0/24", "10.0.13.0/24", "10.0.14.0/24"]
dns_hosts						= "true"
dns_support						= "true"
vpc-cidr						= "10.0.0.0/16"
vpc-name						= "dev-pcf-cluster-vpc"

##### LBS #########

use_web_lb						= true
use_ssh_routes					= true
use_tcp_routes					= true

####### RDS #########

rds_db_username					= ["admin", "admin", "admin", "admin"]
engine							= "MySql"
rds_instance_class				= "db.m4.large"
engine_version					= "8.0.16"
use_rds							= "true"
rds_instance_count				= 4
rds_instance_names				= ["directordb", "pasmysqinternaldb", "uaadb", "credhubdb"]
#rds_instance_users				= ["admin", "admin", "admin", "admin"]


######## DNS ##########

use_route53						= true
zone-name						= "test-pcf.de"