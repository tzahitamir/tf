s3_buckets = {
  logs = {
    name             = "payplus-dev-logs"
    acl              = "private"
    logical_resource = "s3_dev_payplus_logs"
    environment      = "dev"
    created_at       = "2026-04-22"
  }
}

extra_tags = {
  owner = "payplus-devops"
}
