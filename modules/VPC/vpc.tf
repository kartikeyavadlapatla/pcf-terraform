#data "aws_availability_zones" "available" {}
#data "aws_subnet_ids" "private" {
#  vpc_id = aws_vpc.pcf-cluster-vpc.id
##  tags = {
#    Tier = "Private"
#  }
#  depends_on = [aws_subnet.public, aws_subnet.pas, aws_subnet.management, aws_subnet.services, aws_subnet.rds]
#}

#data "aws_subnet" "selected" {
#  for_each = data.aws_subnet_ids.private.id	
#  vpc_id = aws_vpc.pcf-cluster-vpc.id
#  tags = {
#    Tier = "Private"
#  }
#  depends_on = [aws_subnet.public, aws_subnet.pas, aws_subnet.management, aws_subnet.services, aws_subnet.rds]
#}


locals {
  public_count              = length(var.public-subnets)
  management_count 			= length(var.management-subnets)
  pas_count 				= length(var.pas-subnets)
  service_count				= length(var.service-subnets)
  rds_count					= length(var.rds-subnets)
  private_count				= length(var.private-subnets-list)
}


resource "aws_vpc" "pcf-cluster-vpc" {
  enable_dns_hostnames = var.dns_hosts
  enable_dns_support = var.dns_support
  cidr_block = var.vpc-cidr
  tags = {
    Name = var.vpc-name
	Env = var.env
  } 
}


resource "aws_subnet" "public" {
  count             = local.public_count
  vpc_id            = aws_vpc.pcf-cluster-vpc.id
  availability_zone = element(var.availability-zones, count.index)
  cidr_block        = element(var.public-subnets, count.index)
  tags = {
	 Name = "${format("PCF-Public-Subnet-AZ%3d", count.index)}"
	 Env  = var.env
	 Tier = "Public"
	 SubnetEnv = "Public"
  }
}

resource "aws_subnet" "management" {
  count             = local.management_count
  vpc_id            = aws_vpc.pcf-cluster-vpc.id
  availability_zone = element(var.availability-zones, count.index)
  cidr_block        = element(var.management-subnets, count.index)
  tags = {
	 Name = "${format("PCF-Management-Subnet-AZ%3d", count.index)}"
	 Env  = var.env
	 Tier = "Private"
	 SubnetEnv = "management"
  }
}

resource "aws_subnet" "pas" {
  count             = local.pas_count
  vpc_id            = aws_vpc.pcf-cluster-vpc.id
  availability_zone = element(var.availability-zones, count.index)
  cidr_block        = element(var.pas-subnets, count.index)
  tags = {
	 Name = "${format("PCF-PAS-Subnet-AZ%3d", count.index)}"
	 Env  = var.env
	 Tier = "Private"
	 SubnetEnv = "pas"
  }
}

resource "aws_subnet" "services" {
  count             = local.service_count
  vpc_id            = aws_vpc.pcf-cluster-vpc.id
  availability_zone = element(var.availability-zones, count.index)
  cidr_block        = element(var.service-subnets, count.index)
  tags = {
	 Name = "${format("PCF-Service-Subnet-AZ%3d", count.index)}"
	 Env  = var.env
	 Tier = "Private"
  }
}

resource "aws_subnet" "rds" {
  count             = local.rds_count
  vpc_id            = aws_vpc.pcf-cluster-vpc.id
  availability_zone = element(var.availability-zones, count.index)
  cidr_block        = element(var.rds-subnets, count.index)
  tags = {
	 Name = "${format("PCF-RDS-Subnet-AZ%3d", count.index)}"
	 Env  = var.env
	 Tier = "Private"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.pcf-cluster-vpc.id}"
  tags = {
    Name = "pcf-cluster-vpc-ig"
  }
}

resource "aws_route_table" "custom-rt-public" {
  vpc_id = "${aws_vpc.pcf-cluster-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags = {
    Name = "Custom Route Table PCF Public Cluster"
	Env = var.env
  }
}

resource "aws_route_table_association" "a" {
  count          = local.public_count
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.custom-rt-public.id
}


resource "aws_security_group" "NAT-Security-Group" {
  #count 	  = local.private_count
  
  name        = "pcf-nat-security-group"
  description = "Allow inbound and outbound traffic in NAT"
  vpc_id      = "${aws_vpc.pcf-cluster-vpc.id}"
  
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
	cidr_blocks = var.pas-subnets
	
  }
  
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
	cidr_blocks = var.pas-subnets

  }
  
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
	cidr_blocks = var.rds-subnets
	
  }
  
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
	cidr_blocks = var.rds-subnets

  }
  
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
	cidr_blocks = var.management-subnets
	
  }
  
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
	cidr_blocks = var.management-subnets

  }
  
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
	cidr_blocks = var.service-subnets
	
  }
  
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
	cidr_blocks = var.service-subnets

  }
  
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
  depends_on = [aws_subnet.public, aws_subnet.pas, aws_subnet.management, aws_subnet.services, aws_subnet.rds]

}

resource "aws_eip" "nat-eip" {
  instance = "${aws_instance.NAT-VM.id}"
  depends_on = ["aws_internet_gateway.gw"]
  vpc      = true
  tags = {
	Name = "natip"
  }
}

resource "aws_eip" "opsman-eip" {
  depends_on = ["aws_internet_gateway.gw"]
  vpc      = true
  tags = {
	Name = "opsmanip"
  }
}

resource "aws_instance" "NAT-VM" {
  ami           = "ami-00a9d4a05375b2763"
  instance_type = "t2.micro"
  #security_groups = [aws_security_group.NAT-Security-Group.id]
  vpc_security_group_ids = [aws_security_group.NAT-Security-Group.id]
  subnet_id      = element(aws_subnet.public.*.id, 0)
  associate_public_ip_address = true
  source_dest_check = false
  tags = {
    Name = "PCF NAT Instance Cluster"
  }
}

resource "aws_route_table" "custom-rt-private" {
    vpc_id = "${aws_vpc.pcf-cluster-vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.NAT-VM.id}"
    }
	
	tags = {
    Name = "Custom Route Table PCF Private Cluster"
	Env = var.env
  }
}

resource "aws_route_table_association" "b" {
	count          = local.pas_count
    subnet_id 		= element(aws_subnet.pas.*.id, count.index)
    route_table_id  = "${aws_route_table.custom-rt-private.id}"
}

resource "aws_route_table_association" "c" {
	count          = local.management_count
    subnet_id 		= element(aws_subnet.management.*.id, count.index)
    route_table_id  = "${aws_route_table.custom-rt-private.id}"
}

resource "aws_route_table_association" "e" {
	count          = local.service_count
    subnet_id 		= element(aws_subnet.services.*.id, count.index)
    route_table_id  = "${aws_route_table.custom-rt-private.id}"
}

resource "aws_route_table_association" "f" {
	count          = local.rds_count
    subnet_id 		= element(aws_subnet.rds.*.id, count.index)
    route_table_id  = "${aws_route_table.custom-rt-private.id}"
}