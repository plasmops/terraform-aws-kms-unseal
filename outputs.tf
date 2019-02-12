output "attach_policies" {
  description = "List of polcies ARNs to attach to the unseal role"
  value       = "${var.attach_policies}"
}

output "create_kms_key" {
  description = "Specifies whether the KMS key create or not"
  value       = "${var.create_kms_key}"
}

output "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days"
  value       = "${var.deletion_window_in_days}"
}

output "name" {
  description = "Unseal role name (use either name_prefix or name)"
  value       = "${var.name}"
}

output "name_prefix" {
  description = "Unseal role name prefix (use either name_prefix or name)"
  value       = "${var.name_prefix}"
}

output "permissions_boundary" {
  description = "If provided, all IAM roles will be created with this permissions boundary attached"
  value       = "${var.permissions_boundary}"
}

output "tags" {
  description = "Map of tags to append to the key and role"
  value       = "${var.tags}"
}

# output "role_policy" {
#   description = "Unseal role policy document to override the default generated one"
#   value       = "${local.role_policy}"
# }

output "kms_key_arn" {
  description = "KMS key ARN"
  value       = "${join("", aws_kms_key.unseal.*.arn)}"
}

output "kms_key_id" {
  description = "KMS key ID"
  value       = "${join("", aws_kms_key.unseal.*.id)}"
}

output "role_arn" {
  description = "Unseal role arn"
  value       = "${local.role_id}"
}

output "role_id" {
  description = "Unseal role id"
  value       = "${local.role_id}"
}
