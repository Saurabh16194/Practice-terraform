resource "aws_iam_policy" "eks_readonly" {
  name        = "eks-readonly-dev"
  description = "Minimal permissions for EKS access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "eks:DescribeCluster"
        ]
        Resource = "arn:aws:eks:us-east-1:992303535017:cluster/dev-eks"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "dev_user_eks_read" {
  user       = aws_iam_user.dev_user.name
  policy_arn = aws_iam_policy.eks_readonly.arn
}
