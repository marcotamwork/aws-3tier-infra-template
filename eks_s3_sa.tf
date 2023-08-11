module "s3_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "s3-fwd-role"
  role_policy_arns = {
    policy = aws_iam_policy.s3_policy.arn
  }
  #   attach_vpc_cni_policy = true
  #   vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["sit:s3-fwd-sa"]
    }
  }
}

resource "aws_iam_policy" "s3_policy" {
  name        = "FWD EKS s3 policy"
  path        = "/"
  description = "FWD EKS s3 policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${aws_s3_bucket.s3.id}/*"
      },
    ]
  })
}
