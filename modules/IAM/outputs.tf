output "aws_iam_user_name" {
  value = aws_iam_access_key.pcf-master-user-access-key.user
}

output "aws_iam_ID" {
  value = aws_iam_access_key.pcf-master-user-access-key.id
}


output "aws_iam_secret" {
  value = aws_iam_access_key.pcf-master-user-access-key.secret
}