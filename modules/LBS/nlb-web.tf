variable vpc-id {
	type = string
}

variable public-subnets-id {
	type = list
}

variable pas-subnets-id {
	type = list
}

resource "aws_lb" "web" {
  count   = "${var.use_web_lb ? 1 : 0}"
  name               = "${var.env}-web-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.pas-subnets-id
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true

  tags = {
    Environment = "dev"
	Type = "weblb"
	Name = "pcf-web-elb"
  }
  
}

resource "aws_lb_listener" "web_80" {
  count   = "${var.use_web_lb ? 1 : 0}"
  load_balancer_arn = "${aws_lb.web[0].arn}"
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.web_80[0].arn}"
  }
}

resource "aws_lb_listener" "web_443" {
  count   = "${var.use_web_lb ? 1 : 0}"
  load_balancer_arn = "${aws_lb.web[0].arn}"
  port              = 443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.web_443[0].arn}"
  }
}

resource "aws_lb_target_group" "web_80" {
  count   = "${var.use_web_lb ? 1 : 0}"
  name     = "${var.env}-web-tg-80"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${var.vpc-id}"

  health_check {
    protocol = "TCP"
  }
}

resource "aws_lb_target_group" "web_443" {
  count   = "${var.use_web_lb ? 1 : 0}"
  name     = "${var.env}-web-tg-443"
  port     = 443
  protocol = "TCP"
  vpc_id   = "${var.vpc-id}"

  health_check {
    protocol = "TCP"
  }
}