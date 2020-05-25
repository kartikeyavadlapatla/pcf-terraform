variable opsman-eip	{
	type = string
}

variable aws_lb_tcp_dns	{
	type = list
}

variable aws_lb_web_dns	{
	type = list
}

variable aws_lb_ssh_dns	{
	type = list
}

variable aws_lb_tcp_zone	{
	type = list
}

variable aws_lb_web_zone	{
	type = list
}

variable aws_lb_ssh_zone	{
	type = list
}

variable "vpc-id" {
  type = "string"
}

#resource "aws_route53_zone" "DNS_Zone" {
 # name = var.zone-name
 # count   = "${var.use_route53 ? 1 : 0}"
  #vpc  {
	#vpc_id = var.vpc-id
  #}
  #tags = {
   # Env = "var.env"
  #}
#}

resource "aws_route53_record" "opsman_dns" {
  count   = "${var.use_route53 ? 1 : 0}"
  #zone_id = "${aws_route53_zone.DNS_Zone[0].zone_id}"
  zone_id  = "Z0648195HF1CZIBIB19"
  name    = "opsman.${var.env}.${var.zone-name}"
  type    = "A"
  ttl     = "300"
  records = ["${var.opsman-eip}"]
}


resource "aws_route53_record" "wildcard_sys_dns" {
  count   = "${var.use_route53 ? 1 : 0}"
  #zone_id = "${aws_route53_zone.DNS_Zone[0].zone_id}"
  zone_id  = "Z0648195HF1CZIBIB19"
  name    = "*.sys.${var.env}.${var.zone-name}"
  type    = "A"

  alias {
    name                   = "${element(var.aws_lb_web_dns,0)}"
    zone_id                = "${element(var.aws_lb_web_zone,0)}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "wildcard_apps_dns" {
  count   = "${var.use_route53 ? 1 : 0}"
  #zone_id = "${aws_route53_zone.DNS_Zone[0].zone_id}"
  zone_id  = "Z0648195HF1CZIBIB19"
  name    = "*.apps.${var.env}.${var.zone-name}"
  type    = "A"

  alias {
    name                   = "${element(var.aws_lb_web_dns,0)}"
    zone_id                = "${element(var.aws_lb_web_zone,0)}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ssh" {
  count   = "${var.use_route53 && var.use_ssh_routes? 1 : 0}"
  #zone_id = "${aws_route53_zone.DNS_Zone[0].zone_id}"
  zone_id  = "Z0648195HF1CZIBIB19"
  name    = "ssh.sys.${var.env}.${var.zone-name}"
  type    = "A"

  alias {
    name                   = "${element(var.aws_lb_web_dns,0)}"
    zone_id                = "${element(var.aws_lb_web_zone,0)}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "tcp" {
  count   = "${var.use_route53 && var.use_tcp_routes ? 1 : 0}"
  #zone_id = "${aws_route53_zone.DNS_Zone[0].zone_id}"
  zone_id  = "Z0648195HF1CZIBIB19"
  name    = "tcp.${var.env}.${var.zone-name}"
  type    = "A"

  alias {
    name                   = "${element(var.aws_lb_web_dns,0)}"
    zone_id                = "${element(var.aws_lb_web_zone,0)}"
    evaluate_target_health = true
  }
}