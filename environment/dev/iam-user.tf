resource "aws_iam_user" "dev_user" {
  name = "dev-user"
}

resource "aws_iam_access_key" "dev_user" {
  user = aws_iam_user.dev_user.name
}
