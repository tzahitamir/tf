buckets = {
  aws_s3_test1 = {
    name             = "payplus-dev-aws-s3-test1"
    logical_resource = "s3_dev_payplus_test1"
    environment      = "dev"
    created_at       = "2026-04-22"
  }
  aws_s3_test2 = {
    name             = "payplus-dev-aws-s3-test2"
    logical_resource = "s3_dev_payplus_test2"
    environment      = "dev"
    created_at       = "2026-04-22"
  }
}

extra_tags = {
  owner = "payplus-devops"
}
