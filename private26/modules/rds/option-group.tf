# #Oracle / SQL Server only
# resource "aws_db_option_group" "this" {
#   count = local.is_oracle || local.is_sqlserver ? 1 : 0

#   engine_name          = var.engine
#   major_engine_version = split(".", var.engine_version)[0]
#   name                 = "${var.identifier}-og"

#   tags = var.tags
# }
