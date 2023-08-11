data "aws_availability_zones" "available" {}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}


data "aws_s3_bucket" "s3" {
  bucket = "fwd-smart-recruit-ipad-app-test"
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.s3.arn,
      "${aws_s3_bucket.s3.arn}/*",
    ]
  }
}

data "aws_instances" "nodes" {
  filter {
    name   = "instance.group-id"
    values = [module.eks.node_security_group_id]
  }

}
