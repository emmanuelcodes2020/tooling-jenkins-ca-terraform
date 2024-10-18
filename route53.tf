resource "aws_route53_record" "jenkins_app_route53" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_lb.jenkins_app_nlb.dns_name
    zone_id                = aws_lb.jenkins_app_nlb.zone_id
    evaluate_target_health = true
  }
  
}