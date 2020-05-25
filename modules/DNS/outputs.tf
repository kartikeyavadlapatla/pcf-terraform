#output "hosted-zone-id" {
#  description = "DNS Zone NS Details"
#  value = aws_route53_zone.DNS_Zone.*.zone_id
#}

#output "hosted-zone-ns" {
#  description = "DNS Zone NS Details"
#  value = aws_route53_zone.DNS_Zone.*.name_servers
#}