variable "attach_policies" {
  description = "ARN list of policies to attach to the unseal role."
  default     = []
}

variable "permissions_boundary" {
  description = "If provided, all IAM roles will be created with this permissions boundary attached."
  default     = ""
}

variable "name_prefix" {
  description = "Name prefix to create the role."
  default     = ""
}

variable "name" {
  description = "Unseal policy role name"
  default     = ""
}

variable "attributes" {
  description = "Attributes appended to the role name."
  default     = []
}

variable "delimiter" {
  description = "Attributes delimiter."
  default     = "-"
}

variable "tags" {
  description = "Map of tags to append to the role."
  default     = {}
}
