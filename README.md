# terraform-aws-kms-unseal

Terraform module to create an unseal role together with a KMS key (optional). Unseal role is used to encrypt/decrypt KMS key(s).

## Usage

The bellow example is used to create an IAM instance role for a Vault KMS key access. `create_kms_key` will create a new KMS key and will allow the unseal role to access only this key. **Note that if `create_kms_key` is `false`** the unseal role allows to encrypt/decrypt and describe **all keys in KMS**.

```hcl
module "vault_unseal" {
  source      = "git::https://github.com/plasmops/terraform-aws-kms-unseal"
  name_prefix = "${module.project.id}"

  create_kms_key = true

  attach_policies = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  ]

  tags = {
    Namespace = "myproject"
    Stage     = "dev"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attach_policies | List of polcies ARNs to attach to the unseal role | list | `<list>` | no |
| create_kms_key | Set to true to create a kms key | boolean | `false` | no |
| deletion_window_in_days | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days | string | `7` | no |
| enabled | Set to `false` to prevent the module from creating any resources | boolean | `true` | no |
| name | Unseal role name (use either name_prefix or name) | string | `""` | no |
| name_prefix | Unseal role name prefix (use either name_prefix or name) | string | `""` | no |
| permissions_boundary | If provided, all IAM roles will be created with this permissions boundary attached | string | `""` | no |
| tags | Map of tags to append to the key and role | map | `<map>` | no |
| role_policy | Unseal role policy document to override the default generated one | string | `""` | no |

## Outputs

The module outputs most of its inputs along with the bellow parameters:

| Name | Description |
| ---  | --- |
| kms_key_arn | KMS key ARN (if key creation is enabled) |
| kms_key_id | KMS key ID (if key creation is enabled) |
| role_arn | Unseal role arn |
| role_id | Unseal role ID |
