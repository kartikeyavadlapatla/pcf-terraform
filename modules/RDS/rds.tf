variable pcf-rds-subnets-id {
	type = list
}

variable pcf-msql-sg-id {
	type = string
}

locals {
  db_count              = length(var.rds_instance_names)
  }

resource "aws_db_subnet_group" "rds_subnet_group" {
  count = "${local.db_count  > 0 ? 1 : 0}"
  name        = "${var.env}_director_db_subnet_group"
  description = "PCF Director RDS Subnet Group"
  subnet_ids = "${var.pcf-rds-subnets-id}"

  tags = {
  Env = var.env
  }
  #count   = "${var.use_rds ? 1 : 0}"
  #count = "${var.rds_instance_count > 0 ? 1 : 0}"
}


resource "random_string" "rds_password" {
  #count   = "${var.use_rds ? 1 : 0}"
  #count = "${var.rds_instance_count > 0 ? 1 : 0}"'
  count = local.db_count
  length  = 16
  special = false
}

resource "aws_db_instance" "rds" {
  count				      = local.db_count
  allocated_storage       = 100
  name                	  = "${element(var.rds_instance_names, count.index)}"
  instance_class          = "${var.rds_instance_class}"
  engine                  = "${var.engine}"
  engine_version          = "${var.engine_version}"
  identifier              = "${var.env}-${element(var.rds_instance_names, count.index)}"
  username                = "${element(var.rds_db_username, count.index)}"
  password                = "${random_string.rds_password[count.index].result}"
  db_subnet_group_name    = "${aws_db_subnet_group.rds_subnet_group[0].name}"
  publicly_accessible     = false
  vpc_security_group_ids  = [var.pcf-msql-sg-id]
  iops                    = 1000
  multi_az                = true
  skip_final_snapshot     = true
  backup_retention_period = 7
  apply_immediately       = true

  #count = "${var.rds_instance_count}"
  #count   = "${var.use_rds ? 1 : 0}"

  tags = {
  "Usage" = "PCF Director DB"
  "Env" = var.env
  }
}