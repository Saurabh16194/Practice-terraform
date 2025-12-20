# data "aws_caller_identity" "current" {}

# resource "kubernetes_config_map_v1" "aws_auth" {
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }

#   data = {
#     mapRoles = yamlencode([
#       {
#         rolearn  = module.eks.node_group_role_arn
#         username = "system:node:{{EC2PrivateDNSName}}"
#         groups   = ["system:bootstrappers", "system:nodes"]
#       }
#     ])

#     mapUsers = yamlencode([
#       {
#         userarn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${data.aws_caller_identity.current.user_id}"
#         username = "admin"
#         groups   = ["system:masters"]
#       }
#     ])
#   }
# }


resource "kubernetes_config_map_v1" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = module.eks.node_group_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ])

    mapUsers = yamlencode([
      # Admin (Terraform IAM user)
      {
        userarn  = "arn:aws:iam::992303535017:user/Terraform"
        username = "terraform-admin"
        groups   = ["system:masters"]
      },

      # Limited user
      {
        userarn  = aws_iam_user.dev_user.arn
        username = "dev-user"
        groups   = ["dev-group"]
      }
    ])
  }
}
