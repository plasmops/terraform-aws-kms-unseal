variable "enabled" {
  description = "Set to false to disable this module"
  default     = true
}

variable "attach_policies" {
  description = "List of polcies ARNs to attach to the unseal role"
  default     = []
}

variable "create_kms_key" {
  description = "Set to true to create a kms key"
  default     = false
}

variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days"
  default     = 7
}

variable "name" {
  description = "Unseal role name (use either name_prefix or name)"
  default     = ""
}

variable "name_prefix" {
  description = "Unseal role name prefix (use either name_prefix or name)"
  default     = ""
}

variable "permissions_boundary" {
  description = "If provided, all IAM roles will be created with this permissions boundary attached"
  default     = ""
}

variable "tags" {
  description = "Map of tags to append to the key and role"
  default     = {}
}

variable "role_policy" {
  description = "Unseal role policy to override the default generated one"
  default     = ""
}
