

ecs_clusters = {
  cluster-wittix-prod = {
    settings = [
      {
        name  = "containerInsights"
        value = "enabled"
      }
    ]
  }
}
##
aws_ecs_task_definition = {
  routerx-td-prod = {
    family                   = "routerx-td-prod"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/ecs-task-execution-role-prod"
    container_definitions    = [
    {
      name      = "routerx"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/routerx:latest"
      cpu       = 10
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/routerx-prod"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }  
      ]
      secrets = []
      environment= []
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },
 core-td-prod = {
    family                   = "core-td-prod"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/ecs-task-execution-role-prod"
    container_definitions    = [
    {
      name      = "core"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/455178800756.dkr.ecr.eu-west-1.amazonaws.com/core:7bc006c52df4857b66c9b6888b565b940419301e"
      cpu       = 10
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/core-prod"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 50051
          hostPort      = 50051
        }
      ]
      secrets = []
      environment= []
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },
 ###
 core-td-dev = {
    family                   = "core-td-dev"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/wittix-ecs-task-execution-role-dev"
    container_definitions    = [
    {
      name      = "core"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/core:latest"
      cpu       = 10
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/core-dev"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 50051
          hostPort      = 50051
        }  
      ]
      secrets = []
      environment= []
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },
 core-td-dev-tf = {
    family                   = "core-td-dev-tf"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/wittix-ecs-task-execution-role-dev"
    container_definitions    = [
    {
      name      = "core-test"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/core-test:bac22a91ad7ef4b01680cdd5f409fa14ed8a5f9a"
      cpu       = 20
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/core-dev-tf"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 50051
          hostPort      = 50051
        }  
      ]
      secrets = []
      environment= []
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },
  core-td-prod-tf = {
    family                   = "core-td-prod-tf"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/ecs-task-execution-role-prod"
    container_definitions    = [
    {
      name      = "core"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/core:8caa4396ca7be38cdcb6e29d40b5474391f88a7f"
      cpu       = 20
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/core-prod-tf"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 50051
          hostPort      = 50051
        }  
      ]
      secrets = []
      environment= []
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },
  client-api-js-prod-td-tf = {
    family                   = "client-api-js-prod-td-tf"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/ecs-task-execution-role-prod"
    container_definitions    = [
    {
      name      = "client-api-js-prod"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/client-api-js-prod:latest"
      cpu       = 20
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/client-api-js-prod-tf"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }  
      ]
      secrets = []
      environment= []
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },
 client-api-js-test-td-tf = {
    family                   = "client-api-js-test-td-tf"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/wittix-ecs-task-execution-role-dev"
    container_definitions    = [
    {
      name      = "client-api-js-test"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/client-api-js-test:111"
      cpu       = 20
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/client-api-js-test-tf"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }  
      ],
      secrets = [
        {
          "name": "CORE_DB_PASSWORD",
          "valueFrom": "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/core-password/dev"
        },
        {
          "name": "CORE_DB_USER",
          "valueFrom": "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/core-user/dev"
        }  
      ],
      environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        },
        {
          "name": "PORT",
          "value": "3000"
        },
        {
          "name": "GRPC_PORT",
          "value": "50051"
        },
        {
          "name": "CORE_DB_HOST",
          "value": "172.20.10.111"
        },
        {
          "name": "CORE_DB_PORT",
          "value": "3306"
        },
        {
          "name": "CORE_DB_DATABASE",
          "value": "twittix_main"
        }
      ]
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },
  admin-api-js-test-td-tf = {
    family                   = "admin-api-js-test-td-tf"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/wittix-ecs-task-execution-role-dev"
    container_definitions    = [
    {
      name      = "admin-api-js-test"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/admin-api-js-test:111"
      cpu       = 20
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/admin-api-js-test-tf"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }  
      ],
      secrets = [
        {
          "name": "CORE_DB_PASSWORD",
          "valueFrom": "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/core-password/dev"
        },
        {
          "name": "CORE_DB_USER",
          "valueFrom": "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/core-user/dev"
        }  
      ],
      environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        },
        {
          "name": "PORT",
          "value": "3000"
        },
        {
          "name": "GRPC_PORT",
          "value": "50051"
        },
        {
          "name": "CORE_DB_HOST",
          "value": "172.20.10.111"
        },
        {
          "name": "CORE_DB_PORT",
          "value": "3306"
        },
        {
          "name": "CORE_DB_DATABASE",
          "value": "twittix_main"
        }
      ]
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },
 ########
 admin-api-js-prod-td-tf = {
    family                   = "admin-api-js-prod-td-tf"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/ecs-task-execution-role-prod"
    container_definitions    = [
    {
      name      = "admin-api-js-prod"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/admin-api-js-prod:111"
      cpu       = 20
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/admin-api-js-prod-tf"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }  
      ],
      secrets = [
        {
          "name": "CORE_DB_PASSWORD",
          "valueFrom": "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/core-password/prod"
        },
        {
          "name": "CORE_DB_USER",
          "valueFrom": "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/core-user/prod"
        }  
      ],
      environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        },
        {
          "name": "PORT",
          "value": "3000"
        },
        {
          "name": "GRPC_PORT",
          "value": "50051"
        },
        {
          "name": "CORE_DB_HOST",
          "value": "172.20.10.111"
        },
        {
          "name": "CORE_DB_PORT",
          "value": "3306"
        },
        {
          "name": "CORE_DB_DATABASE",
          "value": "twittix_main"
        }
      ]
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },
 ########
 vop-test-td-tf = {
    family                   = "vop-test-td-tf"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/wittix-ecs-task-execution-role-dev"
    container_definitions    = [
    {
      name      = "vop-test"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/vop-test:111"
      cpu       = 20
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/vop-test-tf"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 3333
          hostPort      = 3333
        }  
      ],
      secrets = [
        {
          "name": "CORE_DB_PASSWORD",
          "valueFrom": "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/db/core/dev/r-password"
        },
        {
          "name": "CORE_DB_USER",
          "valueFrom": "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/db/core/dev/r-username"
        }  
      ],
      environment = [
        {
          name  = "ENV"
          value = "development"
        },
        {
          "name": "PORT",
          "value": "3333"
        },
        {
          "name": "GRPC_PORT",
          "value": "50051"
        },
        {
          "name": "CORE_DB_HOST",
          "value": "172.20.10.111"
        },
        {
          "name": "CORE_DB_PORT",
          "value": "3306"
        },
        {
          "name": "CORE_DB_DATABASE",
          "value": "twittix_main"
        }
      ]
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },
 #######################
 vop-prod-td-tf = {
    family                   = "vop-prod-td-tf"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/ecs-task-execution-role-prod"
    container_definitions    = [
    {
      name      = "vop-prod"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/vop-prod:111"
      cpu       = 20
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/vop-prod-tf"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 3334
          hostPort      = 3334
        }  
      ],
      secrets = [
        {
          "name": "CORE_DB_PASSWORD",
          "valueFrom": "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/db/core/prod/r-password"
        },
        {
          "name": "CORE_DB_USER",
          "valueFrom": "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/db/core/prod/r-username"
        }  
      ],
      environment = [
        {
          name  = "ENV"
          value = "production"
        },
        {
          "name": "PORT",
          "value": "3334"
        },
        {
          "name": "GRPC_PORT",
          "value": "50051"
        },
        {
          "name": "CORE_DB_HOST",
          "value": "172.20.10.111"
        },
        {
          "name": "CORE_DB_PORT",
          "value": "3306"
        },
        {
          "name": "CORE_DB_DATABASE",
          "value": "wittix_main"
        }
      ]
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },
 ##########
utility-prod-td-tf = {
    family                   = "utility-prod-td-tf"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/ecs-task-execution-role-prod"
    container_definitions    = [
    {
      name      = "utility-prod"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/utility:111"
      cpu       = 20
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/utility-prod-tf"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 3335
          hostPort      = 3335
        }  
      ],
      secrets = [
        {
          "name": "GEMINI_API_KEY",
          "valueFrom": "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/gemini-ai/key"
        },
        {
          "name": "CAPTCHA_API_KEY",
          "valueFrom": "arn:aws:secretsmanager:eu-west-1:455178800756:secret:wittix/2captcha/key"
        }  
      ],
      environment = [
        {
          name  = "S3_BUCKET_NAME"
          value = "wittix"
        }
      ]
    }
  ]
    requires_compatibilities = ["FARGATE"]
 },

dictionary-service-test-td-tf  = {
    family                   = "dictionary-service-test-td-tf"
    network_mode             = "awsvpc"
    memory                   = "2048"
    cpu                      = "512"
    execution_role_arn       = "arn:aws:iam::455178800756:role/ecs_task_execution_role"
    task_role_arn            = "arn:aws:iam::455178800756:role/wittix-ecs-task-execution-role-dev"
    container_definitions    = [
    {
      name      = "dictionary-service-test"
      image     = "455178800756.dkr.ecr.eu-west-1.amazonaws.com/dictionary-service-beta:9eeb59792cff4e37e216487ad37604c3f177c205"
      cpu       = 20
      memory    = 2048
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/dictionary-service-test"
          awslogs-region        = "eu-west-1"
          awslogs-stream-prefix = "ecs"
        }
     }
      portMappings = [
        {
          containerPort = 3337
          hostPort      = 3337
        }
      ],
      secrets = [],
      environment = []
    }
  ]
    requires_compatibilities = ["FARGATE"]
 }
}

aws_cloudwatch_log_group = {
  1 = {
    name              = "/ecs/routerx-prod"
    retention_in_days = "7"
  },
  2 = {
    name              = "/ecs/core-prod"
    retention_in_days = "7"
  },
  3 = {
    name              = "/ecs/core-dev"
    retention_in_days = "7"
  },
  4 = {
    name              = "/ecs/core-dev-tf"
    retention_in_days = "7"
  }
  5 = {
    name              = "/ecs/core-prod-tf"
    retention_in_days = "7"
  }
  6 = {
    name              = "/ecs/client-api-js-test-tf"
    retention_in_days = "7"
  }
  7 = {
    name              = "/ecs/client-api-js-prod-tf"
    retention_in_days = "7"
  }
  8 = {
    name              = "/ecs/admin-api-js-test-tf"
    retention_in_days = "7"
  }
  9 = {
    name              = "/ecs/vop-test-tf"
    retention_in_days = "7"
  }
  10 = {
    name              = "/ecs/vop-prod-tf"
    retention_in_days = "7"
  }
  11 = {
    name              = "/ecs/utility-prod-tf"
    retention_in_days = "7"
  }
  12 = {
    name              = "/ecs/admin-api-js-prod-tf"
    retention_in_days = "7"
  }
  13 = {
    name              = "/ecs/dictionary-service-test"
    retention_in_days = "7"
  }
}
