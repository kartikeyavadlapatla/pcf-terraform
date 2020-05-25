output "vpc-id" {
	value = aws_vpc.pcf-cluster-vpc.id
}

output "opsman-eip" {
	value = aws_eip.opsman-eip.public_ip
}

output "pcf-public-subnets-id" {
	description = "Public Subnets list for ALB"
	value = aws_subnet.public.*.id
}

output "pcf-pas-subnets-id" {
	description = "PAS Subnets list for ALB"
	value = aws_subnet.pas.*.id
}

output "pcf-rds-subnets-id" {
	description = "PAS Subnets list for ALB"
	value = aws_subnet.rds.*.id
}

output "pcf-services-subnets-id" {
	description = "PAS Subnets list for ALB"
	value = aws_subnet.services.*.id
}

output "pcf-management-subnets-id" {
	description = "PAS Subnets list for ALB"
	value = aws_subnet.management.*.id
}

output "pcf-ops-manager-sg-id" {
	description = "Ops Manager security grp ID"
	value = aws_security_group.opsman-Group.id
}

output "pcf-vms-Group-sg-id" {
	description = "pcf VMs security grp"
	value = aws_security_group.vms-Group.id
}

output "pcf-elb-web-sg-id" {
	description = "pcf elb web security grp"
	value = aws_security_group.elb-web-sg-grp.id
}

output "pcf-elb-ssh-sg-id" {
	description = "pcf elb ssh security grp"
	value = aws_security_group.elb-ssh-sg-grp.id
}

output "pcf-elb-tcp-sg-id" {
	description = "pcf elb tcp security grp"
	value = aws_security_group.elb-tcp-sg-grp.id
}

output "pcf-msql-sg-id" {
	description = "pcf mysl tcp security grp"
	value = aws_security_group.msql-security-group.id
}