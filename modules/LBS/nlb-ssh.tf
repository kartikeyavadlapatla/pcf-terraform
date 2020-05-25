resource "aws_lb" "ssh" {
  count                            = "${var.use_ssh_routes ? 1 : 0}"
  name                             = "${var.env}-ssh-lb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = false
  subnets           			 	= var.pas-subnets-id


}

resource "aws_lb_listener" "ssh" {
  count             = "${var.use_ssh_routes ? 1 : 0}"
  load_balancer_arn = "${aws_lb.ssh[count.index].arn}"
  port              = 2222
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.ssh[count.index].arn}"
  }
}

resource "aws_lb_target_group" "ssh" {
  count    = "${var.use_ssh_routes ? 1 :0}"
  name     = "${var.env}-ssh-tg"
  port     = 2222
  protocol = "TCP"
  vpc_id   = "${var.vpc-id}"

  health_check {
    protocol = "TCP"
  }

}