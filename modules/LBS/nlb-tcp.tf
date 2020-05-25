
locals {
  tcp_port_count = "${var.use_tcp_routes ? 10 : 0}"
}

resource "aws_lb" "tcp" {
  count                            = "${var.use_tcp_routes ? 1 : 0}"
  name                             = "${var.env}-tcp-lb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = false
  subnets            			   = var.pas-subnets-id
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = "${aws_lb.tcp[0].arn}"
  port              = "${1024 + count.index}"
  protocol          = "TCP"
  count = "${local.tcp_port_count}"
  default_action {
    type             = "forward"
    target_group_arn = "${element(aws_lb_target_group.tcp.*.arn, count.index)}"
  }
  
}

resource "aws_lb_target_group" "tcp" {
  name     = "${var.env}-tcp-tg-${1024 + count.index}"
  port     = "${1024 + count.index}"
  protocol = "TCP"
  vpc_id   = "${var.vpc-id}"
  count = "${local.tcp_port_count}"
  health_check {
    protocol = "TCP"
  }
}