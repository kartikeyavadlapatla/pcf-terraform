output "pcf-ops-manager-bucket-Name" {
  description = "Ops Manager Bucket Name"
  value = aws_s3_bucket.pcf-ops-manager-bucket.id
}

output "pcf-buildpacks-bucket-name" {
  description = "BuildPack Bucket Name"
  value = aws_s3_bucket.pcf-buildpacks-bucket.bucket
}

output "pcf-packages-bucket-name" {
  description = "Packages Bucket Name"
  value = aws_s3_bucket.pcf-packages-bucket.bucket
}

output "pcf-resources-bucket-name" {
  description = "Resources Bucket Name"
  value = aws_s3_bucket.pcf-resources-bucket.bucket
}

output "pcf-droplets-bucket-name" {
  description = "Droplets Bucket Name"
  value = aws_s3_bucket.pcf-droplets-bucket.bucket
}

output "pcf-ops-manager-bucket-ARN" {
  description = "Ops Manager Bucket Name"
  value = aws_s3_bucket.pcf-ops-manager-bucket.arn
}

output "pcf-buildpacks-bucket-ARN" {
  description = "BuildPack Bucket Name"
  value = aws_s3_bucket.pcf-buildpacks-bucket.arn
}

output "pcf-packages-bucket-ARN" {
  description = "Packages Bucket Name"
  value = aws_s3_bucket.pcf-packages-bucket.arn
}

output "pcf-resources-bucket-ARN" {
  description = "Resources Bucket Name"
  value = aws_s3_bucket.pcf-resources-bucket.arn
}

output "pcf-droplets-bucket-ARN" {
  description = "Droplets Bucket Name"
  value = aws_s3_bucket.pcf-droplets-bucket.arn
}


