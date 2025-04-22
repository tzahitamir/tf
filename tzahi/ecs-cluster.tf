## aws_ecs_cluster.stateless:
resource "aws_ecs_cluster" "stateless" {
    arn      = "arn:aws:ecs:eu-west-1:455178800756:cluster/w1"
    id       = "arn:aws:ecs:eu-west-1:455178800756:cluster/w1"
    name     = "w1"
    tags     = {}
    tags_all = {}

    service_connect_defaults {
        namespace = "arn:aws:servicediscovery:eu-west-1:455178800756:namespace/ns-kewahhsabxrwg5xm"
    }

    setting {
        name  = "containerInsights"
        value = "enabled"
    }
}
