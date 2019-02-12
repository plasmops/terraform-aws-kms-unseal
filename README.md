# terraform-aws-vault-unseal

Terraform module creates a role and a KMS key to unseal vault. It does not install vault or does anything else.

## Usage

```hcl
module "unseal" {
  source      = "/home/fixuid/code/plasmops/terraform-aws-vault-unseal"
  name_prefix = "${module.project.id}"

  attributes = [
    "hetzner",
    "vault",
  ]

  attach_policies = [
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  ]

  tags = "${module.project.tags}"
}
```
