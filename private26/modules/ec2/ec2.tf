resource "aws_instance" "this" {
  for_each = var.instances

  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  subnet_id                   = each.value.subnet_id
  vpc_security_group_ids      = each.value.vpc_security_group_ids
  key_name                    = each.value.key_name
  iam_instance_profile        = each.value.iam_instance_profile
  associate_public_ip_address = each.value.associate_public_ip_address

  root_block_device {
    volume_size = each.value.root_volume_size
    volume_type = each.value.root_volume_type
  }

  tags = each.value.tags
}
