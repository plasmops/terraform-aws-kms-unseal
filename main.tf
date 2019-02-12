locals {
  role_id   = "${join("", concat(aws_iam_role.this_prefix.*.id, aws_iam_role.this.*.id))}"
  role_name = "${join("", concat(aws_iam_role.this_prefix.*.name, aws_iam_role.this.*.name))}"

  prefixed_role  = "${signum(length(var.name_prefix))}"
  name_or_prefix = "${coalesce(var.name, var.name_prefix)}"

  principal = "${var.create_kms_key ? join("", aws_kms_key.unseal.*.arn) : "*"}"

  role_policy = "${coalesce(var.role_policy, data.aws_iam_policy_document.unseal.json)}"
}

data "aws_iam_policy_document" "sts" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this_prefix" {
  count                 = "${local.prefixed_role ? var.enabled : 0}"
  name_prefix           = "${local.name_or_prefix}"
  assume_role_policy    = "${data.aws_iam_policy_document.sts.json}"
  permissions_boundary  = "${var.permissions_boundary}"
  force_detach_policies = true

  tags = "${var.tags}"
}

resource "aws_iam_role" "this" {
  count                 = "${local.prefixed_role ? 0 : var.enabled}"
  name                  = "${local.name_or_prefix}"
  assume_role_policy    = "${data.aws_iam_policy_document.sts.json}"
  permissions_boundary  = "${var.permissions_boundary}"
  force_detach_policies = true

  tags = "${var.tags}"
}

data "aws_iam_policy_document" "unseal" {
  statement {
    effect    = "Allow"
    resources = ["${local.principal}"]

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
    ]
  }
}

resource "aws_iam_role_policy" "unseal" {
  count  = "${var.enabled}"
  name   = "kms-access"
  role   = "${local.role_id}"
  policy = "${local.role_policy}"
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = "${length(var.attach_policies) * var.enabled}"
  policy_arn = "${element(var.attach_policies, count.index)}"
  role       = "${local.role_name}"
}

resource "aws_kms_key" "unseal" {
  count                   = "${var.create_kms_key * var.enabled}"
  description             = "${local.name_or_prefix}"
  deletion_window_in_days = "${var.deletion_window_in_days}"

  tags = "${var.tags}"
}
