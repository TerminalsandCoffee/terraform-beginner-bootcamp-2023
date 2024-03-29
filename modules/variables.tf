variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "Invalid user UUID format. It should be in the form of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)."
  }
}

variable "bucket_name" {
  description = "AWS S3 Bucket Name"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}[a-z0-9]$", var.bucket_name))
    error_message = "Bucket name must be between 3 and 63 characters long, start and end with a lowercase letter or number, and contain only lowercase letters, numbers, hyphens (-), and periods (.)"
  }
}
