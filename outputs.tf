##### DNS Details ####

#output "DNS-Hosted-Zone-ID" {
#  description = "DNS Zone NS Details"
#  value = module.DNS.hosted-zone-id
#}

#output "DNS-Hosted-Zone-NSs" {
#  description = "DNS Zone NS Details"
#  value = module.DNS.hosted-zone-ns
#}

#####  Security Groups ######

output "pcf-sg-id-ops-manager" {
	description = "Ops Manager security grp ID"
	value = module.VPC.pcf-ops-manager-sg-id
}

output "pcf-sg-id-pas-group" {
  description = "PCF PAS security grp."
  value = module.VPC.pcf-elb-web-sg-id
}

output "pcf-sg-id-vms-group" {
	description = "pcf VMs security grp"
	value = module.VPC.pcf-vms-Group-sg-id
}

output "pcf-sg-id-nlb-web" {
	description = "pcf nlb web security grp"
	value = module.VPC.pcf-elb-web-sg-id
}

output "pcf--sg-id-nlb-ssh" {
	description = "pcf nlb ssh security grp"
	value = module.VPC.pcf-elb-ssh-sg-id
}

output "pcf--sg-id-nlb-tcp" {
	description = "pcf nlb tcp security grp"
	value = module.VPC.pcf-elb-tcp-sg-id
}

output "pcf--sg-id-msql" {
	description = "pcf mysl tcp security grp"
	value = module.VPC.pcf-msql-sg-id
}


#####  VPC Details ######

output "pcf-vpc-id" {
	value = module.VPC.vpc-id
}

output "pcf-vpc-opsman-eip" {
	value = module.VPC.opsman-eip
}

output "pcf-vpc-subnets-ids-public" {
	description = "Public Subnets list for NLB"
	value = module.VPC.pcf-public-subnets-id
}

output "pcf-vpc-subnets-ids-pas" {
	description = "PAS Subnets list for NLB"
	value = module.VPC.pcf-pas-subnets-id
}

output "pcf-vpc-subnets-ids-rds" {
	description = "PAS Subnets list for ALB"
	value = module.VPC.pcf-rds-subnets-id
}

output "pcf-vpc-subnets-ids-services" {
	description = "Service Subnets list for ALB"
	value =  module.VPC.pcf-services-subnets-id
}

output "pcf-vpc-subnets-ids-management" {
	description = "Management Subnets list for ALB"
	value = module.VPC.pcf-management-subnets-id
}


#####  Buildpack Buckets ######

output "pcf-bucket-name-ops-manager" {
  description = "Ops Manager Bucket Name"
  value = module.S3.pcf-ops-manager-bucket-Name
}

output "pcf-bucket-name-buildpacks" {
  description = "BuildPack Bucket Name"
  value = module.S3.pcf-buildpacks-bucket-name
}

output "pcf-bucket-name-packages" {
  description = "Packages Bucket Name"
  value = module.S3.pcf-packages-bucket-name
}

output "pcf-bucket-name-resources" {
  description = "Resources Bucket Name"
  value = module.S3.pcf-resources-bucket-name
}

output "pcf-bucket-name-droplets" {
  description = "Droplets Bucket Name"
  value = module.S3.pcf-droplets-bucket-name
}

###### IAM User for PCF Ops #######

output "aws_iam_user_name" {
  value = module.IAM.aws_iam_user_name
}

output "aws_iam_ID" {
  value = module.IAM.aws_iam_ID
}

output "aws_iam_secret" {
  value = module.IAM.aws_iam_secret
}

####### NLB Details ##########

output "pcf_nlb_tcp_dns" {
	value = module.LBS.aws_lb_tcp_dns
}

output "pcf_nlb_ssh_dns" {
	#count = "${var.use_ssh_routes ? 1 : 0}"
	value = module.LBS.aws_lb_ssh_dns
}

output "pcf_nlb_web_dns" {
	value = module.LBS.aws_lb_web_dns
}

####### RDS ###########

output "rds_address" {
  value = module.RDS.rds_address
}

output "rds_port" {
  value = module.RDS.rds_port
}

output "rds_username" {
  value = module.RDS.rds_username
}

output "rds_password" {
  sensitive = false
  value = module.RDS.rds_password
}

output "rds_db_name" {
  value = module.RDS.rds_db_name
}