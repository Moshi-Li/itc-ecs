resource "aws_ecs_task_definition" "this" {
    depends_on = [aws_ecs_cluster.this]
    family = "itc-nginx-task"
    container_definitions =jsonencode([{
        "name" : var.image_name,
        "image": var.image_url,
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