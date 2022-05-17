resource "aws_ecs_task_definition" "this" {
    family = "itc-nginx-task"
    container_definitions =jsonencode([{
        "name" : "nginx",
        //"image": "public.ecr.aws/docker/library/nginx:stable-perl",
        "image" : "nginx"
        "essential" : true
        "portMappings" : [
            {
                "containerPort" : 80
                "hostPort"      : 80
            }
      ]
    }])
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    cpu          = "256"
    memory       = "512"
}