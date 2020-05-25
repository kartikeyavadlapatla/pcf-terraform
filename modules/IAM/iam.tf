
variable pcf-ops-manager-bucket-ARN {
	type = "string"
}

variable pcf-buildpacks-bucket-ARN {
	type = "string"
}

variable pcf-droplets-bucket-ARN {
	type = "string"
}

variable pcf-packages-bucket-ARN {
     type = "string"
}

variable pcf-resources-bucket-ARN {
	type = "string"
}

data "template_file" "master-user-policy-render" {
  template = "${file("${path.module}/master-user-policy.json")}"
  vars = {
	opsman_backup_bucket_arn 		= var.pcf-ops-manager-bucket-ARN
    buildpacks_backup_bucket_arn 	= var.pcf-buildpacks-bucket-ARN
    droplets_backup_bucket_arn   	= var.pcf-droplets-bucket-ARN
    packages_backup_bucket_arn   	= var.pcf-packages-bucket-ARN
    resources_backup_bucket_arn  	= var.pcf-resources-bucket-ARN
  }

  ##count = "${var.create_backup_pas_buckets ? 1 : 0}"
}


resource "aws_iam_user" "pcf-master-user" {
  name = var.iam-user-name
  force_destroy = true
  tags = {
    name = var.iam-user-name
	env = var.env
  }
}

resource "aws_iam_access_key" "pcf-master-user-access-key" {
  user = aws_iam_user.pcf-master-user.name
}

resource "aws_iam_policy" "policy" {
  name        = "${var.iam-user-name}-policy"
  path        = "/"
  description = "Master user ploicy"
  policy = "${data.template_file.master-user-policy-render.rendered}"
}

resource "aws_iam_user_policy_attachment" "policy-attach" {
  user       = "${aws_iam_user.pcf-master-user.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
