resource "kubernetes_namespace_v1" "dev" {
  metadata {
    name = "dev"
  }
}

resource "kubernetes_role_v1" "dev_readonly" {
  metadata {
    name      = "dev-readonly"
    namespace = kubernetes_namespace_v1.dev.metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments"]
    verbs      = ["get", "list"]
  }
}

resource "kubernetes_role_binding_v1" "dev_binding" {
  metadata {
    name      = "dev-readonly-binding"
    namespace = kubernetes_namespace_v1.dev.metadata[0].name
  }

  subject {
    kind      = "Group"
    name      = "dev-group"
    api_group = "rbac.authorization.k8s.io"
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role_v1.dev_readonly.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}
