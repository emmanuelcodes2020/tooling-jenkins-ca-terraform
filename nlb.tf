# Create Network Load Balancer
resource "aws_lb" "jenkins_app_nlb" {
  name               = "jenkins-app-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.subnets
  security_groups    = [aws_security_group.jenkins_app_sg.id]

  tags = {
    Name = "jenkins-nlb"
  }
}

# Create Target Group for Jenkins Controller (Port 8080)
resource "aws_lb_target_group" "jenkins_controller_tg" {
  name     = "jenkins-controller-tg"
  port     = 8080
  protocol = "TCP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = "TCP"
    port                = "8080"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 10
    interval            = 30
  }

  tags = {
    Name = "jenkins-controller-tg"
  }
}

# Attach Jenkins Controller to the Target Group (8080)
resource "aws_lb_target_group_attachment" "controller_attachment" {
  target_group_arn = aws_lb_target_group.jenkins_controller_tg.arn
  target_id        = aws_instance.jenkins_app_controller.id
  port             = 8080
}



resource "aws_lb_listener" "jenkins_controller_listener" {
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_controller_tg.arn
  }
  load_balancer_arn = aws_lb.jenkins_app_nlb.arn
  port              = 443
  protocol          = "TLS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.jenkins_acm_certificate.arn
  depends_on = [aws_lb_target_group.jenkins_controller_tg]
}