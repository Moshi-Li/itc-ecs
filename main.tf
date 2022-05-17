resource "aws_ecs_cluster" "this" {
  name = "itc-cluster"
}


resource "aws_ecs_service" "this" {

  depends_on = [aws_ecs_task_definition.this, aws_alb_target_group.this]

  name        = "nginx-service"
  cluster     = aws_ecs_cluster.this.arn
  launch_type = "FARGATE"

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 0
  desired_count                      = 2
  task_definition                    = "${aws_ecs_task_definition.this.family}:${aws_ecs_task_definition.this.revision}"

  network_configuration {
    assign_public_ip = true
    security_groups  = data.aws_security_groups.this.ids
    subnets          = data.aws_subnets.this.ids
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.this.arn
    container_name   = aws_ecs_task_definition.this.family
    container_port   = 80
  }
  
}


