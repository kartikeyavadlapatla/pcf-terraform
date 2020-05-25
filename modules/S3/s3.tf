resource "aws_s3_bucket" "pcf-ops-manager-bucket" {
  bucket = "${var.ID-String}-${var.pcf-ops-manager-bucket-name}"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "${var.ID-String}-${var.pcf-ops-manager-bucket-name}"
    Environment = var.env
  }
}

resource "aws_s3_bucket" "pcf-buildpacks-bucket" {
  bucket = "${var.ID-String}-${var.pcf-buildpacks-bucket-name}"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "${var.ID-String}-${var.pcf-buildpacks-bucket-name}"
    Environment = var.env
  }
}

resource "aws_s3_bucket" "pcf-packages-bucket" {
  bucket = "${var.ID-String}-${var.pcf-packages-bucket-name}"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "${var.ID-String}-${var.pcf-packages-bucket-name}"
    Environment = var.env
  }
}

resource "aws_s3_bucket" "pcf-resources-bucket" {
  bucket = "${var.ID-String}-${var.pcf-resources-bucket-name}"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "${var.ID-String}-${var.pcf-resources-bucket-name}"
    Environment = var.env
  }
}

resource "aws_s3_bucket" "pcf-droplets-bucket" {
  bucket = "${var.ID-String}-${var.pcf-droplets-bucket-name}"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "${var.ID-String}-${var.pcf-droplets-bucket-name}"
    Environment = var.env
  }
}