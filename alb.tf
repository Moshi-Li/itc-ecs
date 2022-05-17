resource "aws_alb" "this" {
  name               = "itc-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = data.aws_subnets.public.ids
  security_groups    = data.aws_security_groups.this.ids

  tags = {
    Type = "public"
  }
}


resource "aws_alb_target_group" "this" {
  name     = "itc-target-group"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id
}

resource "aws_alb_listener" "itc-alb-listeners" {
  load_balancer_arn = aws_alb.this.arn
  port              = "80"
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}