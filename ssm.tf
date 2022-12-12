resource "aws_ssm_parameter" "ssm" {
  for_each = local.ssm

  name = "/${var.project}/${each.key}"
  description = "${var.project} ${title(each.key)}"
  type = "SecureString"
  value = each.value

  lifecycle {
    ignore_changes = [
        value
    ]
  }
}