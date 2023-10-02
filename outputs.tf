output "bucket_name" {
  description = "Bucket name for our static webstite hosting"
  value       = module.terrahouse_aws.bucket_name
}