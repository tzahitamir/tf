############################################# IAM policies #######################################################

iam_policies = {
  "wecs-log-policy-prod" = {
    description = "Allows ECS to write logs to CloudWatch"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = ["arn:aws:logs:*:*:*"]
      },
      {
        Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
        Condition = {}
        Effect    = "Allow"
        Resource = ["arn:aws:logs:*:*:*"]
        }
      ]
      }    
    }
  #########

  "wittix-opensearch-r-w-dev" = {
    description = "wittix-opensearch-r-w-dev"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action   = ["es:*"]
        Resource = ["arn:aws:es:eu-west-1:455178800756:domain/wittix-test/*"]
      },
      {
        Condition = {}
        Effect   = "Allow"
        Action   = ["es:*"]
        Resource = ["arn:aws:es:eu-west-1:455178800756:domain/wittix-test/*"]
        }
      ]
    }
  }
#########

  "wittix-opensearch-r-w-prod" = {
    description = "wittix-opensearch-r-w-prod"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action   = ["es:*"]
        Resource = [
          "arn:aws:es:eu-west-1:455178800756:domain/wittix/*",
          "arn:aws:es:eu-west-1:455178800756:domain/wittix-prod/*"
          ]
      },
      {
        Action    = ["iam:PassRole"]
        Condition = {
          StringEquals = {
            "iam:PassedToService" = "es.amazonaws.com"
                }
            }
        Effect    = "Allow"
        Resource  =  [
          "arn:aws:iam::455178800756:role/wittix_opensearch_backup_role"
        ]
        }
      ]
    }
  }
#########

  "ecs-task-s3-policy-prod" = {
    description = "Allows ECS to write to S3"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action =  [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      Resource =  [
        "arn:aws:s3:::wittix",
        "arn:aws:s3:::wittix/*"
      ]
      },
      {
        Condition = {}
        Effect   = "Allow"
        Action =  [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      Resource =  [
        "arn:aws:s3:::wittix",
        "arn:aws:s3:::wittix/*"
      ]
        }
      ]
    }
  }
#########

  "s3-wittix-rw-dev" = {
    description = "Allows ECS to write to S3"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action =  [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      Resource =  [
        "arn:aws:s3:::wittix-test",
        "arn:aws:s3:::wittix-test/*"
      ]
      },
      {
        Effect   = "Allow"
        Action =  [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      Resource =  [
        "arn:aws:s3:::wittix-test",
        "arn:aws:s3:::wittix-test/*"
      ]
        Condition = {}
        }
      ]
    }
  }
#########

"ecs-task-sqs-policy-prod-on-all-q-resources" = {
    description = "ecs-task-sqs-policy-prod-on-all-q-resources"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action =  [
        "sqs:ListQueues"
      ],
      Resource =  [
        "*"
      ]
      },
      {
        Effect   = "Allow"
        Action =  [
       "sqs:ListQueues"
      ],
      Resource =  [
        "*"
      ]
        Condition = {}
        }
      ]
    }
  }





#########
  "ecs-task-sqs-policy-prod" = {
    description = "Allows ECS to use sqs"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action =  [
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:ChangeMessageVisibility",
      ],
      Resource =  [
         "arn:aws:sqs:eu-west-1:455178800756:gateway.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:router-to-core.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:core-to-router.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:crm-to-core.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:core-to-crm.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:router-to-core-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:core-to-router-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:core-to-crm-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:crm-to-core-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:bridge.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:default-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:subscriptions-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:confirmations-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:centrolink-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:crm-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:transfers-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:cards-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:idenfy-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:monitoring-prod",
         "arn:aws:sqs:eu-west-1:455178800756:notifications-prod",
         "arn:aws:sqs:eu-west-1:455178800756:notifications-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:screening-prod",
         "arn:aws:sqs:eu-west-1:455178800756:screening-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:reports-prod",
         "arn:aws:sqs:eu-west-1:455178800756:client-notifications-prod",
         "arn:aws:sqs:eu-west-1:455178800756:terminal-transfers-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:translations.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:core-screening-prod" 
      ]
      },
      {
        Effect   = "Allow"
        Action =  [
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:ChangeMessageVisibility",
      ],
      Resource =  [
         "arn:aws:sqs:eu-west-1:455178800756:gateway.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:router-to-core.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:core-to-router.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:crm-to-core.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:core-to-crm.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:router-to-core-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:core-to-router-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:core-to-crm-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:crm-to-core-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:bridge.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:default-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:subscriptions-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:confirmations-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:centrolink-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:crm-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:transfers-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:cards-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:idenfy-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:monitoring-prod",
         "arn:aws:sqs:eu-west-1:455178800756:notifications-prod",
         "arn:aws:sqs:eu-west-1:455178800756:notifications-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:screening-prod",
         "arn:aws:sqs:eu-west-1:455178800756:screening-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:reports-prod",
         "arn:aws:sqs:eu-west-1:455178800756:client-notifications-prod",
         "arn:aws:sqs:eu-west-1:455178800756:terminal-transfers-prod.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:translations.fifo",
         "arn:aws:sqs:eu-west-1:455178800756:core-screening-prod" 
      ]
        Condition = {}
        }
      ]
    }
  }
##########

  "wittix-sqs-policy-dev" = {
    description = "wittix-sqs-policy-dev"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action =  [
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:ChangeMessageVisibility"
      ],
      Resource =  [
        "arn:aws:sqs:eu-west-1:455178800756:router-to-core-dev.fifo",
				"arn:aws:sqs:eu-west-1:455178800756:core-to-router-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:crm-to-core-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:core-to-crm-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:default-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:subscriptions-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:confirmations-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:transfers-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:cards-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:idenfy-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:notifications-dev",
        "arn:aws:sqs:eu-west-1:455178800756:notifications-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:screening-dev",
        "arn:aws:sqs:eu-west-1:455178800756:screening-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:reports-dev",
        "arn:aws:sqs:eu-west-1:455178800756:client-notifications-dev",
        "arn:aws:sqs:eu-west-1:455178800756:terminal-transfers-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:centrolink-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:crm-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:bridge-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:monitoring-dev",
        "arn:aws:sqs:eu-west-1:455178800756:core-screening-dev",
        "arn:aws:sqs:eu-west-1:455178800756:router-to-core-denis.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:core-screening-denis"
      ]
      },
      {
        Effect   = "Allow"
        Action =  [
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes",
        "sqs:GetQueueUrl",
        "sqs:ChangeMessageVisibility"
      ],
      Resource =  [
        "arn:aws:sqs:eu-west-1:455178800756:router-to-core-dev.fifo",
				"arn:aws:sqs:eu-west-1:455178800756:core-to-router-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:crm-to-core-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:core-to-crm-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:default-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:subscriptions-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:confirmations-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:transfers-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:cards-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:idenfy-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:notifications-dev",
        "arn:aws:sqs:eu-west-1:455178800756:notifications-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:screening-dev",
        "arn:aws:sqs:eu-west-1:455178800756:screening-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:reports-dev",
        "arn:aws:sqs:eu-west-1:455178800756:client-notifications-dev",
        "arn:aws:sqs:eu-west-1:455178800756:terminal-transfers-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:centrolink-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:crm-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:bridge-dev.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:monitoring-dev",
        "arn:aws:sqs:eu-west-1:455178800756:core-screening-dev",
        "arn:aws:sqs:eu-west-1:455178800756:router-to-core-denis.fifo",
        "arn:aws:sqs:eu-west-1:455178800756:core-screening-denis"
      ]
        Condition = {}
        }
      ]
    }
  }

##########
  "ecs-task-secrets-policy-prod" = {
    description = "ecs-task-secrets-policy-prod"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/aws_secret_opensearch_access_key/prod-1KDG9g",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/sqs_secret/prod-RP7BkD",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/aws_secret_access_key/prod-MnZhjv",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wittix_terminal/prod-g9hFgy",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wittix_accounting/prod-F5jd43",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wittix_logs/prod-w7EPpv",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wittix_main/prod-GTv7m4",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/dictionary/prod-9vd1YI",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wallester/private_key/prod-57YeB6",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wallester/private_key/prod2-rIqRVy",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/external_services/ibancom-gaXEPs",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/currency_cloud/api_key/prod-X4tIft",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/external_services/screening-Zt1SMm",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/db/core/prod/r-password-95iFzD",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/db/core/prod/r-username-H3gdDP"
        ]
      },
      {
        Effect   = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/aws_secret_opensearch_access_key/prod-1KDG9g",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/sqs_secret/prod-RP7BkD",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/aws_secret_access_key/prod-MnZhjv",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wittix_terminal/prod-g9hFgy",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wittix_accounting/prod-F5jd43",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wittix_logs/prod-w7EPpv",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wittix_main/prod-GTv7m4",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/dictionary/prod-9vd1YI",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wallester/private_key/prod-57YeB6",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wallester/private_key/prod2-rIqRVy",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/external_services/ibancom-gaXEPs",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/currency_cloud/api_key/prod-X4tIft",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/external_services/screening-Zt1SMm",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/db/core/prod/r-password-95iFzD",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/db/core/prod/r-username-H3gdDP"
        ]
        Condition = {}
      }
      ]
    }  
  }
###########

  "wittix-secrets-policy-dev" = {
    description = "wittix-secrets-policy-dev"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
				  "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/sqs_secret/dev-6weMt2",
				  "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/aws_secret_access_key/dev-dBfGBt",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/twittix_main/dev-PxDPkH",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wallester/private_key/dev-7HFwwK",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/twittix_logs/dev-LpTmbd",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/dictionary_test/dev-Wz4gUw",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/twittix_accounting/dev-l1j7kA",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/twittix_terminal/dev-qedJMg",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wallester/private_key/dev2-1T3qYv",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/external_services/ibancom-gaXEPs",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/currency_cloud/api_key/dev-8tzU9O",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/external_services/screening-Zt1SMm",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/core-password/dev-8r3kRb",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/external_services/screening-Zt1SMm"
        ]
      },
      {
        Effect   = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
				  "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/sqs_secret/dev-6weMt2",
				  "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/aws_secret_access_key/dev-dBfGBt",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/twittix_main/dev-PxDPkH",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wallester/private_key/dev-7HFwwK",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/twittix_logs/dev-LpTmbd",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/dictionary_test/dev-Wz4gUw",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/twittix_accounting/dev-l1j7kA",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/twittix_terminal/dev-qedJMg",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/wallester/private_key/dev2-1T3qYv",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/currency_cloud/api_key/dev-8tzU9O",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/external_services/screening-Zt1SMm",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/core-password/dev-8r3kRb",
          "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/external_services/screening-Zt1SMm"
        ]
        Condition = {}
      }
      ]
    }  
  }

###########
  "wittix-ecr-policy-ro" = {
    description = "wittix-ecr-policy-ro"
    policy_json = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action = [
          "ecr:StartImageScan",
				  "ecr:DescribeImageReplicationStatus",
				  "ecr:ListTagsForResource",
				  "ecr:ListImages",
				  "ecr:BatchGetRepositoryScanningConfiguration",
				  "ecr:GetRegistryScanningConfiguration",
				  "ecr:DescribeRepositories",
				  "ecr:BatchCheckLayerAvailability",
				  "ecr:ReplicateImage",
				  "ecr:GetLifecyclePolicy",
				  "ecr:GetRegistryPolicy",
				  "ecr:DescribeImageScanFindings",
				  "ecr:GetLifecyclePolicyPreview",
				  "ecr:DescribeRegistry",
				  "ecr:GetDownloadUrlForLayer",
				  "ecr:DescribePullThroughCacheRules",
				  "ecr:GetAuthorizationToken",
				  "ecr:BatchGetImage",
				  "ecr:DescribeImages",
				  "ecr:StartLifecyclePolicyPreview",
				  "ecr:GetRepositoryPolicy"
        ]
        Resource =  [
         "*"
      ]
      },
      {
        Effect   = "Allow"
        Action = [
          "ecr:StartImageScan",
				  "ecr:DescribeImageReplicationStatus",
				  "ecr:ListTagsForResource",
				  "ecr:ListImages",
				  "ecr:BatchGetRepositoryScanningConfiguration",
				  "ecr:GetRegistryScanningConfiguration",
				  "ecr:DescribeRepositories",
				  "ecr:BatchCheckLayerAvailability",
				  "ecr:ReplicateImage",
				  "ecr:GetLifecyclePolicy",
				  "ecr:GetRegistryPolicy",
				  "ecr:DescribeImageScanFindings",
				  "ecr:GetLifecyclePolicyPreview",
				  "ecr:DescribeRegistry",
				  "ecr:GetDownloadUrlForLayer",
				  "ecr:DescribePullThroughCacheRules",
				  "ecr:GetAuthorizationToken",
				  "ecr:BatchGetImage",
				  "ecr:DescribeImages",
				  "ecr:StartLifecyclePolicyPreview",
				  "ecr:GetRepositoryPolicy"
        ]
        Resource =  [
         "*"
      ]
        Condition = {}
      }
      ]
    }  
  }
}


