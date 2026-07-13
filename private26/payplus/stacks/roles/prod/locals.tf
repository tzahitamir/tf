locals {
  cluster_name = "payplus"
  
  iam_roles = {
    "pp-read-secret-prod-role" = {
      name = "pp-read-secret-prod-role"
      policy_json = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Principal" : {
              "Federated" : "arn:aws:iam::713117837264:oidc-provider/oidc.eks.eu-west-2.amazonaws.com/id/22F350F48ABD422BCBF4B9088AC325B7"
            },
            "Action" : "sts:AssumeRoleWithWebIdentity",
            "Condition" : {
              "StringEquals" : {
                "oidc.eks.eu-west-2.amazonaws.com/id/22F350F48ABD422BCBF4B9088AC325B7:aud" : "sts.amazonaws.com"
               # "oidc.eks.eu-west-2.amazonaws.com/id/22F350F48ABD422BCBF4B9088AC325B7:sub" : "system:serviceaccount:beta:eso-beta"
              },
              "StringLike": { "oidc.eks.eu-west-2.amazonaws.com/id/22F350F48ABD422BCBF4B9088AC325B7:sub": [
                  "system:serviceaccount:pp-prod:sa-read-secrets-pp-prod",
                  "system:serviceaccount:temporal-system:sa-read-secrets-pp-prod"
              ]
              }
            }
          }
        ]
      })
    }
    ####################################################
    # "test-role" = {
    #   name = "test-role"
    #   policy_json = jsonencode({
    #     "Version" : "2012-10-17",
    #     "Statement" : [
    #       {
    #         "Effect" : "Allow",
    #         "Principal" : {
    #           "Federated" : "arn:aws:iam::713117837264:oidc-provider/oidc.eks.eu-west-2.amazonaws.com/id/22F350F48ABD422BCBF4B9088AC325B7"
    #         },
    #         "Action" : "sts:AssumeRoleWithWebIdentity",
    #         "Condition" : {
    #           "StringEquals" : {
    #             "oidc.eks.eu-west-2.amazonaws.com/id/22F350F48ABD422BCBF4B9088AC325B7:aud" : "sts.amazonaws.com"
    #            # "oidc.eks.eu-west-2.amazonaws.com/id/22F350F48ABD422BCBF4B9088AC325B7:sub" : "system:serviceaccount:beta:eso-beta"
    #           },
    #           "StringLike": { "oidc.eks.eu-west-2.amazonaws.com/id/22F350F48ABD422BCBF4B9088AC325B7:sub": [
    #               "system:serviceaccount:pp-prod:sa-read-secrets-pp-prod",
    #               "system:serviceaccount:temporal-system:sa-read-secrets-pp-prod"
    #           ]
    #           }
    #         }
    #       }
    #     ]
    #   })
    # }
    #######
  }
}
