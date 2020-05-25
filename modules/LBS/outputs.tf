output "aws_lb_tcp_dns" {
	#count = "${var.use_tcp_routes ? 1 : 0}"
	value = aws_lb.tcp.*.dns_name
}

output "aws_lb_ssh_dns" {
	#count = "${var.use_ssh_routes ? 1 : 0}"
	value = aws_lb.ssh.*.dns_name
}

output "aws_lb_web_dns" {
	value = aws_lb.web.*.dns_name
}

output "aws_lb_tcp_zone" {
	#count = "${var.use_tcp_routes ? 1 : 0}"
	value = aws_lb.tcp.*.zone_id
}

output "aws_lb_ssh_zone" {
	#count = "${var.use_ssh_routes ? 1 : 0}"
	value = aws_lb.ssh.*.zone_id
}

output "aws_lb_web_zone" {
	value = aws_lb.web.*.zone_id
}