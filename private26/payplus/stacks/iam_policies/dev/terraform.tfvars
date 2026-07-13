############################################# IAM policies #######################################################

iam_policies = {

  "s3-access-tzahi-bucket" = {
    description = "s3-access-tzahi-bucket"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action =  [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      Resource =  [
        "arn:aws:s3:::tzahi",
        "arn:aws:s3:::tzahi/*"
      ]
      },
      {
        Condition = {}
        Effect   = "Allow"
        Action =  [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      Resource =  [
        "arn:aws:s3:::tzahi",
        "arn:aws:s3:::tzahi/*"
      ]
        }
      ]
    }
  },
    "s3-pp-ops-read" = {
    description = "s3-pp-ops-read"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action =  [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      Resource =  [
        "arn:aws:s3:::pp-ops",
        "arn:aws:s3:::pp-ops/*"
      ]
      },
      {
        Condition = {}
        Effect   = "Allow"
        Action =  [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      Resource =  [
        "arn:aws:s3:::pp-ops",
        "arn:aws:s3:::pp-ops/*"
      ]
        }
      ]
    }
  },
  
  "pp-read-secret-beta" = {
    description = "pp-read-secret-beta"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action =  [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
      ],
      Resource =  [
        "arn:aws:secretsmanager:eu-west-2:713117837264:secret:payplus/*/beta*",
        "arn:aws:secretsmanager:eu-west-2:713117837264:secret:postgres/beta/*",
        "arn:aws:secretsmanager:eu-west-2:713117837264:secret:rdsmysql/beta/*",
        "arn:aws:secretsmanager:eu-west-2:713117837264:secret:payplus/mongo_credentials/test1-vLAvgq"
      ]
      },
      {
        Condition = {}
        Effect   = "Allow"
        Action =  [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ],
      Resource =  [
        "arn:aws:secretsmanager:eu-west-2:713117837264:secret:payplus*beta*"
      ]
        }
      ]
    }
  },

  

  }

