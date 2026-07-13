locals {
  iam_roles = {
    "eksClusterRole-dev" = {
      name = "eksClusterRole-dev"
      policy_json = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Principal" : {
              "Service" : "eks.amazonaws.com"
            },
            "Action" : "sts:AssumeRole"
          }
        ]
      })
    },
    "eks_node_role_dev" = {
      name = "eks_node_role_dev"
      policy_json = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Principal" : {
              "Service" : "ec2.amazonaws.com"
            },
            "Action" : "sts:AssumeRole"
          }
        ]
      })
    },
    "s3-tzahi-reader-role" = {
      name = "s3-tzahi-reader-role"
      policy_json = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Principal" : {
              "Service" : "ec2.amazonaws.com"
            },
            "Action" : "sts:AssumeRole"
          }
        ]
      })
    },
    "pp-read-secret-beta-role" = {
      name = "pp-read-secret-beta-role"
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
                  "system:serviceaccount:beta:eso-beta",
                  "system:serviceaccount:qa1:eso-qa1",
                  "system:serviceaccount:qa1:eso-qa"
              ]
              }
            }
          }
        ]
      })
    },
    #############################################################################
    "EKS_EFS_CSI_Driver_Role_dev" = {
      name = "EKS_EFS_CSI_Driver_Role_dev"
      policy_json = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Principal" : {
              "Federated" : "arn:aws:iam::713117837264:oidc-provider/oidc.eks.eu-west-2.amazonaws.com/id/8106579DA5EB39A5BB582330FDDCA003"
            },
            "Action" : "sts:AssumeRoleWithWebIdentity",
            "Condition" : {
              "StringEquals" : {
                "oidc.eks.eu-west-2.amazonaws.com/id/8106579DA5EB39A5BB582330FDDCA003:aud" : "sts.amazonaws.com"
               # "oidc.eks.eu-west-2.amazonaws.com/id/22F350F48ABD422BCBF4B9088AC325B7:sub" : "system:serviceaccount:beta:eso-beta"
              },
              "StringLike": { "oidc.eks.eu-west-2.amazonaws.com/id/8106579DA5EB39A5BB582330FDDCA003:sub": [
                  "system:serviceaccount:kube-system:efs-csi-controller-sa"
              ]
              }
            }
          }
        ]
      })
    }
    # #############################################################################
    # "bitbucket_dev_deploy_role" = {
    #   name = "bitbucket_dev_deploy_role"
    #   policy_json = jsonencode({
    #     "Version" : "2012-10-17",
    #     "Statement" : [
    #       {
    #         "Effect" : "Allow",
    #         "Principal" : {
    #           "Federated" : "arn:aws:iam::713117837264:oidc-provider/api.bitbucket.org/2.0/workspaces/payplusv2/pipelines-config/identity/oidc"
    #         },
    #         "Action" : "sts:AssumeRoleWithWebIdentity",
    #         "Condition" : {
    #           "StringEquals": {
    #             "api.bitbucket.org/2.0/workspaces/payplusv2/pipelines-config/identity/oidc:aud": "ariel:stack:bitbucket:pipelines"
    #          },
    #           "StringLike": {
    #             "api.bitbucket.org/2.0/workspaces/payplusv2/pipelines-config/identity/oidc:sub": "*:*:*"
    #          }
    #         }
    #       }
    #     ]
    #   })
    # },
    # #############################################################################
    "bitbucket_deploy_role_dev" = {
      name = "bitbucket_deploy_role_dev"
      policy_json = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Principal" : {
              "Federated" : "arn:aws:iam::713117837264:oidc-provider/api.bitbucket.org/2.0/workspaces/payplusv2/pipelines-config/identity/oidc"
            },
            "Action" : "sts:AssumeRoleWithWebIdentity",
            "Condition" : {
              "StringEquals": {
                "api.bitbucket.org/2.0/workspaces/payplusv2/pipelines-config/identity/oidc:aud": "ariel:stack:bitbucket:pipelines"
             },
              "StringLike": {
                "api.bitbucket.org/2.0/workspaces/payplusv2/pipelines-config/identity/oidc:sub": "*:*:*"
             }
            }
          }
        ]
      })
    }
    
    # #############################################################################
        
  }
}
