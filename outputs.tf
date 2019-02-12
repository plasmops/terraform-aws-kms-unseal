output "attach_policies" {
  description = "ARN list of policies to attach to the unseal role."
  value       = "${var.attach_policies}"
}

output "permissions_boundary" {
  description = "If provided, all IAM roles will be created with this permissions boundary attached."
  value       = "${var.permissions_boundary}"
}

output "name_prefix" {
  description = "Name prefix to create the new role."
  value       = "${var.name_prefix}"
}

output "name" {
  description = "Unseal policy role name."
  value       = "${var.name}"
}

output "role_id" {
  description = "Unseal role id."
  value       = "${local.role_id}"
}

output "attributes" {
  description = "Attributes appended to the role name."
  value       = "${var.attributes}"
}

output "delimiter" {
  description = "Attributes delimiter."
  value       = "${var.delimiter}"
}
