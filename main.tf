locals {
  role_id   = "${join("", concat(aws_iam_role.this_prefix.*.id, aws_iam_role.this.*.id))}"
  role_name = "${join("", concat(aws_iam_role.this_prefix.*.name, aws_iam_role.this.*.name))}"

  prefixed_role  = "${signum(length(var.name_prefix))}"
  name_or_prefix = "${coalesce(var.name, var.name_prefix)}"
  label          = "${join(var.delimiter, concat(list(local.name_or_prefix), var.attributes))}"
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
  count                 = "${local.prefixed_role ? 1 : 0}"
  name_prefix           = "${local.label}"
  assume_role_policy    = "${data.aws_iam_policy_document.sts.json}"
  permissions_boundary  = "${var.permissions_boundary}"
  force_detach_policies = true
}

resource "aws_iam_role" "this" {
  count                 = "${local.prefixed_role ? 0 : 1}"
  name                  = "${local.label}"
  assume_role_policy    = "${data.aws_iam_policy_document.sts.json}"
  permissions_boundary  = "${var.permissions_boundary}"
  force_detach_policies = true

  tags = "${var.tags}"
}

data "aws_iam_policy_document" "unseal" {
  statement {
    sid       = "VaultKMSUnseal"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
    ]
  }
}

resource "aws_iam_role_policy" "unseal" {
  name   = "vault-kms-unseal"
  role   = "${local.role_id}"
  policy = "${data.aws_iam_policy_document.unseal.json}"
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = "${length(var.attach_policies)}"
  policy_arn = "${element(var.attach_policies, count.index)}"
  role       = "${local.role_name}"
}
